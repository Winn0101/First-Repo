
resource "aws_instance" "Project_DynamoDB" {
  count         = var.instance_count
  ami           = var.instance_ami
  instance_type = var.instance_type

 user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World. This is my DynamoDB Terraform Project.!" > /var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "Project_DynamoDB_instance_${count.index + 1}"
  }
}

resource "aws_security_group" "Project_DynamoDB_security_group" {
    description = "Allow SSH and HTTP Inbound Access"
    name        = "Project_DynamoDB_security_group"
    vpc_id      = var.vpc_id
}

  #inbound rules
  resource "aws_security_group_rule" "Project_DynamoDB_inbound_rules" {
    security_group_id = aws_security_group.Project_DynamoDB_security_group.id
    description = "Allow SSH inbound access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    type        = "ingress"
    cidr_blocks  = ["0.0.0.0/0"]
  }
  
resource "aws_security_group_rule" "Project_DynamoDB_http_inbound_rules" {
  security_group_id = aws_security_group.Project_DynamoDB_security_group.id
  description       = "Allow HTTP inbound access"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
  resource "aws_security_group_rule" "Project_DynamoDB_egress_rules" {
    security_group_id = aws_security_group.Project_DynamoDB_security_group.id
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    type        = "egress"
    cidr_blocks  = ["0.0.0.0/0"]
      }
    

resource "aws_dynamodb_table" "Project_DynamoDB_table" {
  name           = "Project_DynamoDB_table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Project_1_id"
  attribute {
    name = "Project_1_id"
    type = "S"
  }

  tags = {
    Name = "Project_DynamoDB_table"
  }
}

output "aws_instance" {
  value = aws_instance.Project_DynamoDB[1].public_ip
}