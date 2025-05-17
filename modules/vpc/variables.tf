variable "default_tags" {
    description = " Tags à appliquer par défaut"
    type        = map(string)
}

variable "vpc1_cidr_block" {
    description = "CIDR pour le VPC 1"
    type        = string
}

variable "vpc2_cidr_block" {
    description = "CIDR pour le VPC 2"
    type        = string
}

variable "public_subnet_1" {
    description = "CIDR pour le sous-réseau public 1"
    type        = string
}

variable "public_subnet_2" {
    description = "CIDR pour le sous-réseau public 2"
    type        = string
}

variable "private_subnet_1" {
    description = "CIDR pour le sous-réseau privé 1"
    type        = string
}

variable "private_subnet_2" {
    description = "CIDR pour le sous-réseau privé 2"
    type        = string
}   

variable "availability_zone" {
    description = "Zone de disponibilité 1"
    type        = list(string)
}

