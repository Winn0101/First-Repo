output "instance_public_ip" { # This output will display the public IP address of the EC2 instances created in the project.
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.project-3_instance[*].public_ip
}

output "s3_bucket_name" { #This output will display the name of the bucket created will be displayed as an output when the command apply is ran
  description = "The name of the S3 bucket created."
  value       = aws_s3_bucket.project_3_s3_bucket.bucket
}