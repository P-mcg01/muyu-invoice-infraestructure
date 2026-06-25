# Reserved for future Terraform input variables.
variable "name" {
  type    = string
  default = "muyu"
}

variable "cidr" {
  type    = string
  default = "10.4.0.0/16"
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}
