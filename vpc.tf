module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "muyu"
  cidr = "10.4.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]

  public_subnets = ["10.4.1.0/24", "10.4.2.0/24"]

  private_subnets = ["10.4.3.0/24", "10.4.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true
}
