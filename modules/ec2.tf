


############ Ec2 #####################

  resource "aws_key_pair" "key" {
  key_name   = "demo1"
  public_key = file("~/.ssh/id_rsa.pub")
}



data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.key.key_name
  security_groups = [aws_security_group.secgrp.id]
  user_data       = "${file("scripts/init.sh")}"

  tags = {
    Name = "thag-1"
  }
  
}

output "ec2_id" {
  value = aws_instance.web.id

}
