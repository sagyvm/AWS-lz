resource "aws_vpc_peering_connection" "peer" {
  provider = aws.networking
  vpc_id = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  peer_owner_id = var.application_account_id
  auto_accept = false
}

resource "aws_vpc_peering_connection_accepter" "peer_accept" {
  provider = aws.application
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept = true
}
