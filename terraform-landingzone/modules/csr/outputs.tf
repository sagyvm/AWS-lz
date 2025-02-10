output "instance_ids" {
  value = aws_instance.router[*].id
}

output "private_ips" {
  value = aws_instance.router[*].private_ip
}

output "elastic_ips" {
  value = aws_eip.router_eip[*].public_ip
}
