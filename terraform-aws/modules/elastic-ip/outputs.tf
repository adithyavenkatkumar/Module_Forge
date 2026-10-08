output "eips" {
  type = map(object({
    id         = string
    public_ip  = string
    allocation = string
  }))
  description = "Map of created EIPs."
  value = {
    for k, e in aws_eip.eips : k => {
      id         = e.id
      public_ip  = e.public_ip
      allocation = e.allocation_id
    }
  }
}
