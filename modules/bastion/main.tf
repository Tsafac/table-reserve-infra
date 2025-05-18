resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-bastion"
  })
  metadata_options {
  http_endpoint = "enabled"
  http_tokens   = "required"
}

root_block_device {
  volume_type = "gp3" 
  volume_size = 8      
  encrypted   = true
}

}
