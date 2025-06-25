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
#This variable ensures that two instances are created using the same AMI ID & instance type specified, which is specified in the variable "instance_ami".
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


