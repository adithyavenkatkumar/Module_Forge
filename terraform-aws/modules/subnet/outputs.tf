output "subnets" {
  type = map(object({
    id                = string
    arn               = string
    cidr_block        = string
    availability_zone = string
  }))
  description = "Map of created subnets."
  value = {
    for k, s in aws_subnet.subnets : k => {
      id                = s.id
      arn               = s.arn
      cidr_block        = s.cidr_block
      availability_zone = s.availability_zone
    }
  }
}
