#VPCs

output "vpc1_id" {
    description = "VPC 1 ID"
    value = aws_vpc.vpc-1.id
}

output "vpc2_id" {
    description = "VPC 2 ID"
    value = aws_vpc.vpc-2.id
}


#subnets

output "public_subnet_1" {
    description = "Public Subnet 1 ID"
    value = aws_subnet.public-1.id
}

output "public_subnet_2" {
    description = "Public Subnet 2 ID"
    value = aws_subnet.public-2.id
}

output "private_subnet_1" {
    description = "Private Subnet 1 ID"
    value = aws_subnet.private-1.id
}

output "private_subnet_2" {
    description = "Private Subnet 2 ID"
    value = aws_subnet.private-2.id
}

#internet_gateway

output "internet_gateway1_id" {
    description = "Internet Gateway ID"
    value = aws_internet_gateway.igw-1.id
}

output "internet_gateway2_id" {
    description = "Internet Gateway ID"
    value = aws_internet_gateway.igw-2.id
}

output "nat_gateway_id" {
    description = "NAT Gateway ID"
    value = aws_nat_gateway.ngw-1.id
}

#Elastic IP

output "elastic_ip_id" {
    description = "Elastic IP ID"
    value = aws_eip.eip-nat.id
}