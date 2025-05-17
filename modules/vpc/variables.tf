variable "vpc1_cidr_block" {
  type        = string
  description = "CIDR block pour le VPC 1 (public)"
}

variable "vpc2_cidr_block" {
  type        = string
  description = "CIDR block pour le VPC 2 (privé)"
}

variable "public_subnet_1" {
  type        = string
  description = "CIDR block du subnet public 1"
}

variable "public_subnet_2" {
  type        = string
  description = "CIDR block du subnet public 2"
}

variable "private_subnet_1" {
  type        = string
  description = "CIDR block du subnet privé 1"
}

variable "private_subnet_2" {
  type        = string
  description = "CIDR block du subnet privé 2"
}

variable "availability_zone" {
  type        = string
  description = "Zone de disponibilité AWS (ex: eu-west-3a)"
}

variable "name_prefix" {
  type        = string
  description = "Préfixe pour nommer les ressources"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags communs à toutes les ressources"
}


