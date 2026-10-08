resource "aws_cloudwatch_log_group" "logs" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_arn
  tags              = merge(var.tags, { Name = var.log_group_name })
}

resource "aws_sns_topic" "alerts" {
  count             = var.alarm_topic_name != null ? 1 : 0
  name              = var.alarm_topic_name
  kms_master_key_id = var.kms_key_arn
  tags              = merge(var.tags, { Name = var.alarm_topic_name })
}

resource "aws_cloudtrail" "trail" {
  count                         = var.enable_cloudtrail ? 1 : 0
  name                          = var.trail_name
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  kms_key_id                    = var.kms_key_arn
  tags                          = merge(var.tags, { Name = var.trail_name })
}
