
# This Terraform configuration file sets up an AWS environment for Project 3.

#This creates the instances with a userdata script, 3 in this case by referencing the info in thevar.tf file
resource "aws_instance" "project-3_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.project-3_sg.id]
  user_data              = <<-EOF
    #!/bin/bash
    echo "Hello, World. This is Terraform Project 3.!" > /var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "Project-3_instance_${count.index + 1}" #This is to tag the instance with 1 & 2 instead of the default 0 & 1
  }

}
#create a VPC for the project
resource "aws_vpc" "project-3_vpc" {
  cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Project-3_vpc"
    }

}
#This creates a subnet for the project, which is associated with the VPC created above.
resource "aws_subnet" "project-3_subnet" {
  vpc_id     = aws_vpc.project-3_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Project-3_subnet"
  }
}
#This creates an internet gateway for the VPC, allowing the instances to access the internet.
resource "aws_internet_gateway" "project-3_igw" {
  vpc_id = aws_vpc.project-3_vpc.id

  tags = {
    Name = "project-3_igw"
  }
}
#This creates a route table for the VPC, allowing traffic to flow to and from the internet gateway.
resource "aws_route_table" "project-3_route_table" {
  vpc_id = aws_vpc.project-3_vpc.id

  route {
    cidr_block = "10.0.1.1/24"
    gateway_id = aws_internet_gateway.project-3_igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.project-3_igw.id
  }
  tags = {
    Name = "project-3_route_table"
  }
}
#This associates the subnet with the route table, allowing the instances in the subnet to use the routes defined in the route table.
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.project-3_subnet.id
  route_table_id = aws_route_table.project-3_route_table.id
}

#This creates a security group for the project, allowing SSH and HTTP traffic from anywhere.
resource "aws_security_group" "project-3_sg" {
  name        = "allow_ssh_http_project-3"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.project-3_vpc.id

}

resource "aws_vpc_security_group_ingress_rule" "allow_SSH_IPV4" { # This rule allows SSH access from any IPv4 address
  security_group_id = aws_security_group.project-3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_SSH_IPV6" { # This rule allows SSH access from any IPv6 address
  security_group_id = aws_security_group.project-3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_IPV4" { # This rule allows HTTP access from any IPv4 address
  security_group_id = aws_security_group.project-3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

}

resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_IPV6" { # This rule allows HTTP access from any IPv6 address
  security_group_id = aws_security_group.project-3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" { # This rule allows all outbound traffic to any IPv4 address
  security_group_id = aws_security_group.project-3_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" { # This rule allows all outbound traffic to any IPv6 address
  security_group_id = aws_security_group.project-3_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# This creates an S3 bucket for the project, which is dependent on the instance and VPC being created first.
resource "aws_s3_bucket" "project_3_s3_bucket" {
  bucket     = "winn-terraform-project-3-bucket"
  depends_on = [aws_instance.project-3_instance, aws_vpc.project-3_vpc]
  tags = {
    Name = "Project-3_S3_Bucket"
  }
}
