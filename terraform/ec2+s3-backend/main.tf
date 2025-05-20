
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
    name = "my_sg"
    description = "allow HTTP Port"
    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    # ingress {
    #     from_port        = 443
    #     to_port          = 443
    #     protocol         = "TCP"
    #     cidr_blocks      = ["0.0.0.0/0"]
    # }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}