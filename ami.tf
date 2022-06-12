resource "aws_ami_from_instance" "ami" {
  name               = "terraform-example"
  source_instance_id = "i-xxxxxxxx"
  depends_on         = [null_resource.app-deploy]
}