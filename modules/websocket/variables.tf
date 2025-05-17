variable "tags" {
  description = "Map de tags généraux (ex: project, environment, owner, etc.)"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Nom de domaine utilisé pour taguer les ressources"
  type        = string
}
