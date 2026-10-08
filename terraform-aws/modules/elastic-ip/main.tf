resource "aws_eip" "eips" {
  for_each = var.eips
  domain   = lookup(each.value, "domain", "vpc")

  tags = merge(var.tags, { Name = each.key })
}

resource "aws_eip_association" "assoc" {
  for_each             = { for k, v in var.eips : k => v if lookup(v, "instance_id", null) != null || lookup(v, "network_interface_id", null) != null }
  allocation_id        = aws_eip.eips[each.key].id
  instance_id          = lookup(each.value, "instance_id", null)
  network_interface_id = lookup(each.value, "network_interface_id", null)
}
