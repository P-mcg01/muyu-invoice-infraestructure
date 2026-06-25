# Reserved for future Terraform outputs such as VPC and subnet identifiers.
output "vpc_id" {
  value = module.muyu_vpc.vpc_id
}

output "public_subnets" {
  value = module.muyu_vpc.public_subnets
}

output "private_subnets" {
  value = module.muyu_vpc.private_subnets
}

output "nat_public_ips" {
  value = module.muyu_vpc.nat_public_ips
}
