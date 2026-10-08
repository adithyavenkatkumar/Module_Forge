run "validate_sg" {
  command = plan

  variables {
    name   = "sg-test"
    vpc_id = "vpc-12345678"
  }

  assert {
    condition     = aws_security_group.sg.name == "sg-test"
    error_message = "Security Group name mismatch"
  }
}
