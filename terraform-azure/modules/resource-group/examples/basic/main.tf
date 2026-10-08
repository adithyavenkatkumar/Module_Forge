module "rg" {
  source   = "../../"
  name     = "rg-example-basic"
  location = "eastus"
  tags = {
    Environment = "example"
  }
}
