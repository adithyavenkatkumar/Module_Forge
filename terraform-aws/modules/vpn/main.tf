resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.bgp_asn
  ip_address = var.ip_address
  type       = "ipsec.1"
  tags       = merge(var.tags, { Name = "${var.name}-cgw" })
}

resource "aws_vpn_gateway" "vgw" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = "${var.name}-vgw" })
}

resource "aws_vpn_connection" "vpn" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.cgw.id
  type                = "ipsec.1"
  static_routes_only  = var.static_routes_only
  tags                = merge(var.tags, { Name = "${var.name}-vpn" })
}
