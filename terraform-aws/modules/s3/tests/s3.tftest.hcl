run "validate_s3" {
  command = plan

  variables {
    bucket_name = "s3-test-validation-bucket"
  }

  assert {
    condition     = aws_s3_bucket.bucket.bucket == "s3-test-validation-bucket"
    error_message = "Bucket name mismatch"
  }
}
