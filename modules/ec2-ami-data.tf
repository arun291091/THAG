


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



