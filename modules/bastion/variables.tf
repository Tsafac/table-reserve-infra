variable "ami_id" {
  description = "AMI utilisée pour l'instance Bastion"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2 pour le Bastion"
  type        = string
}

variable "subnet_id" {
  description = "ID du subnet public pour le Bastion"
  type        = string
}

variable "bastion_sg_id" {
  description = "ID du Security Group à associer à l'instance Bastion"
  type        = string
}

variable "key_name" {
  description = "Nom de la paire de clés SSH"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine utilisé pour nommer l'instance"
  type        = string
}

variable "default_tags" {
  description = "Tags par défaut"
  type        = map(string)
}

