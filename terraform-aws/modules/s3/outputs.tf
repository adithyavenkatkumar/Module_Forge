output "bucket_id" {
  type        = string
  description = "S3 Bucket ID (Name)."
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  type        = string
  description = "S3 Bucket ARN."
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_domain_name" {
  type        = string
  description = "S3 Bucket Regional Domain Name."
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}
