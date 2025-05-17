
variable "domain_name" {
  description = "Nom logique pour le tag Name"
  type        = string
}

variable "default_tags" {
  description = "Tags globaux à appliquer"
  type        = map(string)
}
