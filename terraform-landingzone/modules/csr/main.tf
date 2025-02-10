# Create Elastic IPs for Primary Interface
resource "aws_eip" "router_eip" {
  count = var.instance_count

  domain = "vpc"

  tags = {
    Name = "cisco-router-eip-${count.index}"
  }
}

# Find Cisco 8000 Router AMI from AWS Marketplace
data "aws_ami" "cisco_8000" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

# Create Cisco 8000 Router EC2 Instances
resource "aws_instance" "router" {
  count = var.instance_count

  ami           = data.aws_ami.cisco_8000.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  root_block_device {
    volume_size = var.volume_size
  }

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "cisco-router-${count.index}"
  }
}

# Create 4 Network Interfaces per Router
resource "aws_network_interface" "nic" {
  count = var.instance_count * 4

  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "cisco-router-nic-${count.index}"
  }
}

# Attach NICs to EC2 Instances
resource "aws_network_interface_attachment" "nic_attachment" {
  count = var.instance_count * 4

  instance_id          = aws_instance.router[floor(count.index / 4)].id
  network_interface_id = aws_network_interface.nic[count.index].id
  device_index         = count.index % 4 + 1
}

# Associate EIP to Primary NIC (Only first NIC of each router)
resource "aws_eip_association" "eip_assoc" {
  count = var.instance_count

  allocation_id        = aws_eip.router_eip[count.index].id
  network_interface_id = aws_network_interface.nic[count.index * 4].id
}
