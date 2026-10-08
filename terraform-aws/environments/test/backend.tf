terraform {
  backend "s3" {
    bucket         = "st-tfstate-aws-enterprise-102938"
    key            = "test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
