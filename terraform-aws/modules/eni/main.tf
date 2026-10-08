resource "aws_network_interface" "eni" {
  for_each        = var.enis
  subnet_id       = each.value.subnet_id
  private_ips     = lookup(each.value, "private_ips", null)
  security_groups = lookup(each.value, "security_groups", null)

  tags = merge(var.tags, { Name = each.key })
}
