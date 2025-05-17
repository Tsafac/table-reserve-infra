# VPC Peering entre vpc-1 et vpc-2
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.vpc1_id
  peer_vpc_id   = var.vpc2_id
  auto_accept   = true

  tags = merge(var.default_tags, {
    Name = "peering-vpc-1-to-vpc-2"
  })
}

# Route de vpc-1 vers vpc-2
resource "aws_route" "route_to_vpc2" {
  route_table_id         = var.vpc1_route_table_id
  destination_cidr_block = var.vpc2_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route de vpc-2 vers vpc-1
resource "aws_route" "route_to_vpc1" {
  route_table_id         = var.vpc2_route_table_id
  destination_cidr_block = var.vpc1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
