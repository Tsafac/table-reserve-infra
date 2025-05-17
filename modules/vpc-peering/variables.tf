variable "vpc1_id" {
  description = "ID du VPC-1 (source)"
  type        = string
}

variable "vpc2_id" {
  description = "ID du VPC-2 (cible)"
  type        = string
}

variable "vpc1_route_table_id" {
  description = "ID de la route table du VPC-1"
  type        = string
}

variable "vpc2_route_table_id" {
  description = "ID de la route table du VPC-2"
  type        = string
}

variable "vpc1_cidr_block" {
  description = "CIDR block de vpc-1 (ex: 10.0.0.0/16)"
  type        = string
}

variable "vpc2_cidr_block" {
  description = "CIDR block de vpc-2 (ex: 10.1.0.0/16)"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux à appliquer"
  type        = map(string)
}
