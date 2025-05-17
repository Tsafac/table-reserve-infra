resource "aws_security_group" "aurora_sg" {
  name        = "aurora-sg"
  description = "Permet les connexions PostgreSQL depuis Fargate"
  vpc_id      = aws_vpc.vpc-2.id

  ingress {
    description      = "PostgreSQL depuis ECS Fargate"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [var.ecs_service_sg_id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}
 

 # SG pour le bastion host
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.authorized_cidr]
    description = "SSH depuis IP autorisée"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-bastion-sg"
  })
}
