vpcs = [
  {
    name   = "vpc-main"
    cidr   = "10.0.0.0/16"
    subnets = [
      { name = "subnet-public-1",  cidr = "10.0.1.0/24", type = "public" },
      { name = "subnet-private-1", cidr = "10.0.2.0/24", type = "private" }
    ]
  },
  {
    name   = "vpc-secondary"
    cidr   = "10.1.0.0/16"
    subnets = [
      { name = "subnet-public-2",  cidr = "10.1.1.0/24", type = "public" },
      { name = "subnet-private-2", cidr = "10.1.2.0/24", type = "private" }
    ]
  }
]

enable_nat_gateway = true

instance_count   = 2
instance_type    = "c5.4xlarge"
key_name         = "my-key"
subnet_id        = "subnet-xxxxxxxx" # Replace with actual subnet
security_group_id = "sg-xxxxxxxx" # Replace with actual SG

volume_size = 50
ami_owner   = "aws-marketplace"
ami_name    = "cisco-8000-router-*"  # This should match AWS Marketplace AMI naming
