resource "aws_instance" "ami-instance" {
  ami                     = data.aws_ami.ami.id
  instance_type           = "t3.micro"
  vpc_security_group_ids  = [aws_security_group.allows_ssh.id]
  iam_instance_profile    = "dev_instance_profile"
}

resource "null_resource" "app-deploy" {
  provisioner "remote-exec" {
    connection {
      host     = aws_instance.ami-instance.public_ip
      user     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USERNAME"]
      password = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
    }
    inline = [
      "ansible-pull -U https://github.com/ashwinreddy9966/ansible roboshop-pull.yml -e ENV=ENV -e APP_VERSION=${var.APP_VERSION} -e COMPONENT=${var.COMPONENT} -e MONGODB_ENDPOINT=MONGODB_ENDPOINT"
    ]
  }
}