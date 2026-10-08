module "baseline" {
  source      = "../../"
  workload    = "app"
  environment = "dev"
  region      = "us-east-1"
}
