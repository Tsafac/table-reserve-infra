variable "vpc1_cidr_block" {
  description = "CIDR block for VPC 1"
  type        = string
}

variable "vpc2_cidr_block" {
  description = "CIDR block for VPC 2"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "private_subnet_1" {
  description = "CIDR block for private subnet 1"
  type        = string
}

variable "private_subnet_2" {
  description = "CIDR block for private subnet 2"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to use for subnets"
  type        = string
}

variable "name_prefix" {
  description = "Prefix to apply to resource names"
  type        = string
}

variable "default_tags" {
  description = "Default tags to apply to resources"
  type        = map(string)
}

variable "vpc_flow_logs_role_arn" {
  description = "ARN du rôle IAM pour VPC Flow Logs"
  type        = string
}
