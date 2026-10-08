run "validate_vpc" {
  command = plan

  variables {
    name       = "vpc-test-plan"
    cidr_block = "10.100.0.0/16"
  }

  assert {
    condition     = aws_vpc.vpc.cidr_block == "10.100.0.0/16"
    error_message = "VPC CIDR block mismatch"
  }
}
