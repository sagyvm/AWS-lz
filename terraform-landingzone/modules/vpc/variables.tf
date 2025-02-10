variable "vpcs" {
  description = "List of VPCs with subnets"
  type = list(object({
    name   = string
    cidr   = string
    subnets = list(object({
      name = string
      cidr = string
      type = string # "public" or "private"
    }))
  }))
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway?"
  type        = bool
  default     = false
}
