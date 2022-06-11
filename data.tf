data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "rotot-with-ansible-ami"
  owners           = ["self"]
}

data "aws_secretsmanager_secret" "secret" {
  name = "dev/roboshop/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secret.id
}
