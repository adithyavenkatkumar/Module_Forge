module "kms" {
  source         = "../../"
  kms_alias_name = "app-key-example"
  secrets = {
    "app/db-password" = { description = "DB password" }
  }
}
