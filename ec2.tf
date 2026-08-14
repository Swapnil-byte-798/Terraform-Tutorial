# requirements:

#key pair(login)
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

#vpc
resource "aws_default_vpc" "default" {
}

#Security Group
resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "this will add TF generated SG to my EC2 instance"
  vpc_id      = aws_default_vpc.default.id #interpolation syntax

  #inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow SSH access from anywhere"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow HTTP access from anywhere"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow access to port 8000 from anywhere"
  }


  #outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all outbound traffic"
  }


  tags = {
    Name = "my-security-group"
  }
}


#ec2 instance
resource "aws_instance" "my_ec2" {
  for_each=tomap({
    instance1 = "t3.micro",
    instance2 = "t3.micro",
    instance_small = "t3.small"
})
  depends_on=[aws_key_pair.my_key, aws_security_group.my_sg,aws_default_vpc.default]

  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sg.name]
  instance_type   = each.value
  ami             = var.aws_ami_id           #ubuntu 26.04 LTS
  user_data       = file("install_ngnix.sh") #install nginx web server

  root_block_device {
    volume_size = var.aws_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}

