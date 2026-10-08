resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile
  user_data              = var.user_data

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required" # Enforce IMDSv2
  }

  root_block_device {
    volume_type           = lookup(var.root_block_device, "volume_type", "gp3")
    volume_size           = lookup(var.root_block_device, "volume_size", 20)
    encrypted             = true
    kms_key_id            = lookup(var.root_block_device, "kms_key_id", null)
    delete_on_termination = true
  }

  tags = merge(var.tags, { Name = var.name })
}

resource "aws_ebs_volume" "ebs" {
  for_each          = var.ebs_volumes
  availability_zone = aws_instance.ec2.availability_zone
  size              = each.value.size
  type              = lookup(each.value, "type", "gp3")
  encrypted         = true
  kms_key_id        = lookup(each.value, "kms_key_id", null)
  tags              = merge(var.tags, { Name = "${var.name}-ebs-${each.key}" })
}

resource "aws_volume_attachment" "ebs_att" {
  for_each    = var.ebs_volumes
  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.ebs[each.key].id
  instance_id = aws_instance.ec2.id
}
