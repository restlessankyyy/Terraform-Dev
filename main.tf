provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "example" {
  key_name   = "AdvanceCFN"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC28ecGrcZV21/s4Br8vCT+CmVO9Ahq1ou/+kln8etkeHU6t1R19n45NsVMvJmj+mgudUwUdMwTQ5RbcKZ0Tsur677VbRTfgsEoJ+9mraB7KHV9HK0Ij6PI4CzrgsvCCoqLNC4c2zZ/TgJYujFT7ozWhrVfn4XiKWK7+0CUi8hUAe5uD1ulEnvIsQqfTAq8ah63ZvOLp/S+WpaYlecErQoN6nVcVSOVVh+E8ml7gpLjy+gM2mtiin2lop2MPrwIWnst7HHKSxB6UE85dW43h+M2SnBKN6U/EMUIwsb9ndQ05TVnHw2gnBN5EwLkGwuNjqXHOjwZZZ6T2RW7JStlhqXZ"
}

resource "aws_security_group" "examplesg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-28e07e50"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.example.id}"

  tags {
    Name = "first-ec2-instance"
  }
}
