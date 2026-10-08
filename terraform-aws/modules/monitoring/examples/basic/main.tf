module "monitoring" {
  source           = "../../"
  log_group_name   = "/aws/app/example-log-group"
  alarm_topic_name = "sns-infra-alerts"
}
