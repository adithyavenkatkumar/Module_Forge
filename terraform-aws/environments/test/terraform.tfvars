workload    = "core"
environment = "test"
region      = "us-east-1"
owner       = "devops-team"
cost_center = "cc-99120"
project     = "aws-enterprise"

vpc_cidr = "10.110.0.0/16"

subnets = {
  "public-1" = {
    cidr_block              = "10.110.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    type                    = "public"
  }
  "private-1" = {
    cidr_block              = "10.110.2.0/24"
    availability_zone       = "us-east-1b"
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
enable_multi_az = false
