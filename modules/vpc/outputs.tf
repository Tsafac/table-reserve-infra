output "vpc_1_id" {
  value = aws_vpc.vpc-1.id
}

output "vpc_2_id" {
  value = aws_vpc.vpc-2.id
}

output "public_subnet_1" {
  value = aws_subnet.public-1.id
}

output "public_subnet_2" {
  value = aws_subnet.public-2.id
}

output "private_subnet_1" {
  value = aws_subnet.private-1.id
}

output "private_subnet_2" {
  value = aws_subnet.private-2.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.ngw-1.id
}

output "vpc_1_route_table_id" {
  value       = aws_route_table.rt-1.id
}

output "vpc_2_route_table_id" {
  value = aws_route_table.rt-2.id
}

output "private_subnets" {
  value = [
    aws_subnet.private-1.id,
    aws_subnet.private-2.id
  ]
}

output "public_subnets" {
  value = [
    aws_subnet.public-1.id,
    aws_subnet.public-2.id
  ]
}

