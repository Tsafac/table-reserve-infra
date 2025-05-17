output "vpc_peering_connection_id" {
  description = "ID de la connexion VPC peering"
  value       = aws_vpc_peering_connection.peer.id
}
