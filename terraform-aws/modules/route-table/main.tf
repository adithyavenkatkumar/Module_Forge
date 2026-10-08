resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = var.name })

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block           = lookup(route.value, "ipv6_cidr_block", null)
      gateway_id                = lookup(route.value, "gateway_id", null)
      nat_gateway_id            = lookup(route.value, "nat_gateway_id", null)
      network_interface_id      = lookup(route.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route.value, "transit_gateway_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }
}

resource "aws_route_table_association" "assoc" {
  for_each       = var.subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.rt.id
}
