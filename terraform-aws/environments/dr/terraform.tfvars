workload    = "core"
environment = "dr"
region      = "us-west-2"
owner       = "devops-team"
cost_center = "cc-99120"
project     = "aws-enterprise"

vpc_cidr = "10.140.0.0/16"

subnets = {
  "public-1" = {
    cidr_block              = "10.140.1.0/24"
    availability_zone       = "us-west-2a"
    map_public_ip_on_launch = true
    type                    = "public"
  }
  "private-1" = {
    cidr_block              = "10.140.2.0/24"
    availability_zone       = "us-west-2b"
    map_public_ip_on_launch = false
    type                    = "private"
  }
}

ingress_rules = [
  {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

instances = {
  "web-01" = {
    instance_type = "t3.micro"
    subnet_key    = "private-1"
  }
}

ami_id          = "ami-0c55b159cbfafe1f0"
enable_multi_az = true
