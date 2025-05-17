variable "bastion_sg_id" {
  description = "ID du SG bastion (fourni par le module sg)"
  type        = string
}
variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
}
