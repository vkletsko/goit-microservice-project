output "s3_bucket_name" {
  description = "The name of the S3 bucket for storing Terraform state files"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table for state locking"
  value       = module.s3_backend.dynamodb_table_name
}