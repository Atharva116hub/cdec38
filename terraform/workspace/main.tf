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
    region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
    ami = "ami-0e35ddab05955cf57"
    instance_type = "t2.micro"
    key_name = "adi-mumbai"
   # count = 3


    tags = {
       #  Name  = "my-aws-instance"
        Env = terraform.workspace
         #Environment = "prod"
    }
}

# loops :- count (ceate same resources in multiple times),
# for_each (change configuration of ur infra), 
# for(for variabels and outputs print)


provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_instance" "my_instance" {
    for_each = var.instance_type
    ami = "ami-05377cf8cfef186c2"
    instance_type = each.value
    key_name = "adi-soual"
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

output "instance_type" {
    value = [for type in var.instance_type : "${type}"]
  
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