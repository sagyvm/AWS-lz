# Create VPCs
resource "aws_vpc" "this" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc }

  cidr_block           = each.value.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = each.value.name }
}

# Create Subnets for Each VPC
resource "aws_subnet" "this" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc.subnets }

  vpc_id     = aws_vpc.this[each.key].id
  cidr_block = each.value.cidr

  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = { Name = each.value.name }
}

# Internet Gateway (Only if a public subnet exists)
resource "aws_internet_gateway" "igw" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc if length([for s in vpc.subnets : s if s.type == "public"]) > 0 }

  vpc_id = aws_vpc.this[each.key].id

  tags = { Name = "${each.key}-igw" }
}

# Elastic IP for NAT Gateway (Only if enabled)
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? length(var.vpcs) : 0
  domain = "vpc"
}

# NAT Gateway (One per VPC)
resource "aws_nat_gateway" "nat" {
  count = var.enable_nat_gateway ? length(var.vpcs) : 0
  subnet_id = aws_subnet.this[values(var.vpcs)[count.index].subnets[0].name].id
  allocation_id = aws_eip.nat[count.index].id

  tags = { Name = "nat-${count.index}" }
}
