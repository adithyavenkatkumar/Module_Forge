resource "aws_db_subnet_group" "rds" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags, { Name = "${var.identifier}-subnet-group" })
}

resource "aws_db_parameter_group" "rds" {
  name   = "${var.identifier}-param-group"
  family = var.family
  tags   = merge(var.tags, { Name = "${var.identifier}-param-group" })
}

resource "aws_db_instance" "db" {
  identifier                  = var.identifier
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  allocated_storage           = var.allocated_storage
  storage_type                = "gp3"
  db_subnet_group_name        = aws_db_subnet_group.rds.name
  parameter_group_name        = aws_db_parameter_group.rds.name
  vpc_security_group_ids      = var.vpc_security_group_ids
  db_name                     = var.database_name
  username                    = var.admin_username
  password                    = var.manage_master_user_password ? null : var.admin_password
  manage_master_user_password = var.manage_master_user_password
  storage_encrypted           = true
  kms_key_id                  = var.kms_key_id
  multi_az                    = var.multi_az
  publicly_accessible         = false
  skip_final_snapshot         = var.skip_final_snapshot

  tags = merge(var.tags, { Name = var.identifier })
}
