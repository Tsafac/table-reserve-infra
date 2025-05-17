# VPCs
output "vpc_1_id" {
  description = "VPC 1 ID"
  value       = aws_vpc.vpc-1.id
}

output "vpc_2_id" {
  description = "VPC 2 ID"
  value       = aws_vpc.vpc-2.id
}

# Subnets
output "public_subnets" {
  description = "Liste des subnets publics"
  value       = [aws_subnet.public-1.id, aws_subnet.public-2.id]
}

output "private_subnets" {
  description = "Liste des subnets privés"
  value       = [aws_subnet.private-1.id, aws_subnet.private-2.id]
}

# Route Tables
output "vpc_1_route_table_id" {
  description = "Route Table principale pour VPC 1"
  value       = aws_route_table.rt-1.id
}

output "vpc_2_route_table_id" {
  description = "Route Table principale pour VPC 2"
  value       = aws_route_table.rt-2.id
}
