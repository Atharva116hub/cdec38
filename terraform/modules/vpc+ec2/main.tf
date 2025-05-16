# provider "aws" {
#     region = "ap-southeast-2"

# }

# resource "aws_vpc" "my_vpc" {
#     cidr_block = "10.0.0.0/16"
  
# }

# # resource "aws_vpc" "main" {
# #   cidr_block = "10.0.0.0/16"
# # }

# resource "aws_subnet" "my_vpc-sub" {
#   cidr_block = "10.0.0.0/20"
#   vpc_id = aws_vpc.my_vpc.id

#   tags= {
#     Name = "public subnet"  

#   }
# }

# resource "aws_internet_gateway" "my_igw" {
#   vpc_id = aws_vpc.my_vpc.id

#   tags = {
#     Name = "my_igw"
#   }
# }

# resource "aws_default_route_table" "example" {
#   default_route_table_id = aws_vpc.example.default_route_table_id

#   route {
#     cidr_block = "10.0.1.0/24"
#     gateway_id = aws_internet_gateway.example.id
#   }


#   tags = {
#     Name = "example"
#   }
# }




resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"


  tags = {

    Name = "my-vpc"
  }
  
}

resource "aws_subnet" "my-sub" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "my-public-subnet"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_default_route_table" "my-rt" {
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

 

  tags = {
    Name = "my-rt"
  }
}


resource "aws_instance" "ec2" {

  ami = var.image_id
  key_name = var.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  subnet_id = aws_subnet.my-sub.id
  

  tags = {
    Name = "my-vpc-instance"
  }
}

resource "aws_security_group" "my-sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}