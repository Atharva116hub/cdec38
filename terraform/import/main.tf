provider "aws" {
  region = "ap-southeast-2"  # Specify the AWS region
}

resource "aws_instance" "my_instance" {
  ami             = "ami-056c5f56210baa04a"
  instance_type   = "t2.micro"
  key_name        = "my-key-sy"
  security_groups = ["default"]  # Ensure this security group exists

  tags = {
    Name = "My-Terraform-Instance"
  }
}





resource "aws_instance" "demo_import_instance" {
    instance_type = ""
    ami = ""
}
