provider "aws" {
  alias = "accepter"
}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_region   = var.peer_region
  auto_accept   = false
}

resource "aws_vpc_peering_connection_accepter" "peer_accept" {
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true
}

resource "aws_route" "requester_to_accepter" {
  route_table_id            = var.requester_route_table_id
  destination_cidr_block    = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "accepter_to_requester" {
  provider                  = aws.accepter
  route_table_id            = var.accepter_route_table_id
  destination_cidr_block    = var.requester_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
