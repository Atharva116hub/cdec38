provider "aws" {
  # Configuration options
  region = "us-east-2"
}


resource "aws_instance" "ec2" {
    ami = "ami-088b41ffb0933423f"
    instance_type = "t2.micro"
    key_name = "ohio-faiz-key"
    security_groups = ["default"]
     count = 2

    tags = {
      Name  = "my-aws-instance"
    }
  
}





provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "my_instance" {
    ami = "ami-088b41ffb0933423f"
    instance_type = "t2.micro"
    key_name = "ohio-faiz-key"
   # count = 3


    tags = {
       #  Name  = "my-aws-instance"
        Env = terraform.workspace
    }
}

resource "aws_instance" "my_instance" {
    for_each = var.instance_type
    ami = "ami-088b41ffb0933423f"
    instance_type = each.value
    key_name = "ohio-faiz-key"
    tags = {
        Name = "instance-${each.key}"
        Env = terraform.workspace
    }
}

variable "instance_type" {
default = {
    small  = "t2.small"
    micro  = "t2.micro"
    medium  = "t2.medium"
}
}

variable "my_name" {
    default = ["shubham", "Anil", "cloudblitz"]
}

output "new_name" {
    value = var.my_name
}

output "name" {
    value = [for name in var.my_name : "my name is ${name}"]
}






provider "aws" {
  # Configuration options
  region = "us-east-2"
}




module "ec2-vpc_basics" {

    source = "./modules/vpc"
  
}


terraform {
  backend "s3" {
    bucket = "cdecb36-bucket007"
    key    = "demo/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "my-terra-table780-7"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}
resource "aws_instance" "ec2" {
    ami = var.image_id
    instance_type = var.instance_type
#    security_groups = [ "default" ]
     vpc_security_group_ids = [aws_security_group.my_sg.id]
    key_name = var.key_name

      tags = {
      Name  = "my-aws-instance"
    }
  
  
}
resource "aws_security_group" "my_sg" {
    name = "my-sg"
    description = "allow HTTP Port"
    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
        from_port        = 443
        to_port          = 443
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}


variable "image_id" {
    type = string
    default = "ami-0f5d1713c9af4fe30"
    description = "enter image id"
  
}
variable "instance_type" {
    type = string
    default = "t2.micro"
  
}
variable "key_name" {
    type = string
    default = "adi-sydney"
  
}
output "public_ip" {
    value = aws_instance.ec2.public_ip
}





























resource "aws_security_group" "my_sg" {
    name = "my-sg"
    description = "allow HTTP Port"
    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "instance_1" {
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_pair
#    security_groups = var.sg_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = var.subnet_id
    user_data = <<-EOF       
        #!/bin/bash
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
    EOF
}

variable "image_id" {
  type        = string
  default     = "ami-07ba57196a766fc6d"
  description = "Enter AMI ID"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_pair" {
    default = "new-key-nv"
}

variable "subnet_id" {
    default = "subnet-091678d44aa5db41d"
}

# variable "sg_name" {
#     type = list
#     default = ["default"]
# }

output "demo" {
    value = "Hello World"
}

output "public_ip" {
    value = aws_instance.instance_1.public_ip
}

# output "arn_subnet" {
#     value = data.aws_subnet.my_subnet.arn
# }