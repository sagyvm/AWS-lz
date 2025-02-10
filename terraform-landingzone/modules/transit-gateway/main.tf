resource "aws_ec2_transit_gateway" "tgw" {
  description = "Transit Gateway"
  amazon_side_asn = 64512
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  tags = { Name = var.transit_gateway_name }
}
