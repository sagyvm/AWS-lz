variable "networking_account_id" {}
variable "application_account_id" {}
variable "cidr_block" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "enable_nat_gateway" { type = bool }
variable "application_vpc_id" { type = string }
