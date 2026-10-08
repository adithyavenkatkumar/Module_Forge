module "eip" {
  source = "../../"
  eips = {
    "nat-eip-1" = { domain = "vpc" }
  }
}
