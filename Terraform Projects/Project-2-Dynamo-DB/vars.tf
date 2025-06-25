
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
  
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t2.micro"
  
}

variable "instance_count" {
  description = "The number of EC2 instances to create"
  type        = number
  default     = 2
  
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instances"
  type        = string
  default     = "ami-09e6f87a47903347c" # Example AMI ID, replace with a valid one for your region
  
}

variable "vpc_id" {
    description = "The VPC ID where the resources will be deployed"
    type        = string
    default     = "vpc-0a97f2e95a89a9fab" # Replace with your actual VPC ID
  
}
