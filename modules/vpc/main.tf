
resource "aws_vpc" "vpc-1" {
    cidr_block = var.vpc1_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-vpc-1"
    })
}

resource "aws_flow_log" "vpc1" {
  vpc_id               = aws_vpc.vpc-1.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  iam_role_arn         = var.vpc_flow_logs_role_arn

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-vpc1-flow-logs"
  })
}


resource "aws_vpc" "vpc-2" {
    cidr_block = var.vpc2_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-vpc-2"
    })
}

resource "aws_flow_log" "vpc2" {
  vpc_id               = aws_vpc.vpc-2.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  iam_role_arn         = var.vpc_flow_logs_role_arn

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-vpc2-flow-logs"
  })
}

resource "aws_eip" "eip-nat" {
  domain = "vpc"
}

# creation des subnets

resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = var.public_subnet_1
    availability_zone = var.availability_zone
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-public-1"
    })
}

resource "aws_subnet" "private-1" {
    vpc_id = aws_vpc.vpc-2.id
    cidr_block = var.private_subnet_1
    availability_zone = var.availability_zone
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-private-1"
    })
}

resource "aws_subnet" "private-2" {
    vpc_id = aws_vpc.vpc-2.id
    cidr_block = var.private_subnet_2
    availability_zone = var.availability_zone
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-private-2"
    })
}

resource "aws_subnet" "public-2" {
    vpc_id = aws_vpc.vpc-2.id
    cidr_block = var.public_subnet_2
    availability_zone = var.availability_zone
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-public-2"
    })
}

resource "aws_internet_gateway" "igw-1" {
    vpc_id = aws_vpc.vpc-1.id
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-igw-1"
    })
}

resource "aws_internet_gateway" "igw-2" {
    vpc_id = aws_vpc.vpc-2.id
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-igw-2"
    })
}

resource "aws_route_table" "rt-1" {
    vpc_id = aws_vpc.vpc-1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-1.id
    }
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-rt-1"
    })
}

resource "aws_route_table" "rt-2" {
    vpc_id = aws_vpc.vpc-2.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-2.id
    }
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-rt-2"
    })
}
resource "aws_route_table_association" "public-1" {
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.rt-1.id
}
resource "aws_route_table_association" "public-2" {
    subnet_id = aws_subnet.public-2.id
    route_table_id = aws_route_table.rt-2.id
}
resource "aws_nat_gateway" "ngw-1" {
    subnet_id = aws_subnet.public-2.id
    allocation_id = aws_eip.eip-nat.id
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-ngw-1"
    })
}

resource "aws_route_table" "rt-3" {
    vpc_id = aws_vpc.vpc-2.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw-1.id
    }
    tags = merge(var.default_tags, {
        Name = "${var.name_prefix}-rt-3"
    })
}

resource "aws_route_table_association" "private-1" {
    subnet_id = aws_subnet.private-1.id
    route_table_id = aws_route_table.rt-3.id
}

resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/vpc/${var.name_prefix}/flow-logs"
  retention_in_days = 14

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-vpc-flow-logs"
  })
}
