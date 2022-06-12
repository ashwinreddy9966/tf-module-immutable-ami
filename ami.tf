resource "aws_ami_from_instance" "ami" {
  name               = "${var.COMPONENT}-${var.APP_VERSION}"
  source_instance_id = aws_instance.ami-instance.id
  depends_on         = [null_resource.app-deploy]
}