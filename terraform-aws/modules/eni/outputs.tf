output "enis" {
  type = map(object({
    id          = string
    arn         = string
    private_ips = list(string)
  }))
  description = "Map of created ENIs."
  value = {
    for k, e in aws_network_interface.eni : k => {
      id          = e.id
      arn         = e.arn
      private_ips = tolist(e.private_ips)
    }
  }
}
