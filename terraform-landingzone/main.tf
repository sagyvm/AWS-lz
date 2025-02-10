module "network" {
  source  = "./modules/network"
  providers = { aws = aws.networking }

  vpcs               = var.vpcs
  enable_nat_gateway = var.enable_nat_gateway
}


module "transit_gateway" {
  source              = "./modules/transit-gateway"
  providers           = { aws = aws.networking }
  transit_gateway_name = "my-tgw"
}

module "vpc_peering" {
  source              = "./modules/vpc-peering"
  providers           = { aws.networking = aws.networking, aws.application = aws.application }
  requester_vpc_id    = module.vpc.vpc_id
  accepter_vpc_id     = var.application_vpc_id
}

module "loadbalancer" {
  source             = "./modules/loadbalancer"
  providers         = { aws = aws.application }
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
}
