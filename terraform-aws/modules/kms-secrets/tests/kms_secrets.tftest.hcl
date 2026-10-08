run "validate_kms" {
  command = plan

  variables {
    kms_alias_name = "test-kms-alias"
  }

  assert {
    condition     = aws_kms_alias.alias.name == "alias/test-kms-alias"
    error_message = "Alias name mismatch"
  }
}
