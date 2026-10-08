run "validate_subnets" {
  command = plan

  variables {
    vpc_id = "vpc-12345678"
    subnets = {
      "test-sub" = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1a"
      }
    }
  }

  assert {
    condition     = contains(keys(var.subnets), "test-sub")
    error_message = "Subnet key mismatch"
  }
}
