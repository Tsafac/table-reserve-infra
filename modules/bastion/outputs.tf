output "bastion_id" {
  description = "ID de l'instance EC2 du bastion"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Adresse IP publique de l'instance bastion"
  value       = aws_instance.bastion.public_ip
}
