terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}
provider "aws" {
  profile = "default"
  region =  "us-east-1"

}

resource "aws_instance" "S3_Project" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"  
}

resource "aws_vpc" "S3_Bucket_VPC" {
    cidr_block = "172.0.0.0/16"
}

resource "aws_s3_bucket" "S3_Project" {
    for_each = { 
    bucket-1 = "Winn-terraform-s3-project-1"
    bucket-2 = "Winn-terraform-s3-project-2" }
    bucket = each.value

  tags = {
    Name = "S3_Project_${each.key}"
  }
}


