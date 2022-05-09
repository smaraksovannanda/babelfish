#jumpserver securitygroup
resource "aws_security_group" "allow_tls" {
  name        = "Pub-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "Allow ssh and http traffic from internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
   ingress {
    description      = "Allow ssh and http traffic from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    # for Aurora MySQL

    ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public1.cidr_block,aws_subnet.public2.cidr_block]
    # security_groups  = ["aws_security_group.allow_http.id"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

#private securitygroup

resource "aws_security_group" "pvt_sg" {
  name        = "pvt-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public1.cidr_block,aws_subnet.public2.cidr_block]
    # security_groups  = ["aws_security_group.allow_http.id"]
    # ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Allow ssh and http traffic from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public1.cidr_block,aws_subnet.public2.cidr_block,aws_subnet.dev_pvt.cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }

  # for Aurora MySQL

    ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public1.cidr_block,aws_subnet.public2.cidr_block]
    # security_groups  = ["aws_security_group.allow_http.id"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform-pvt-sg"
  }
}