# SG pour Aurora
resource "aws_security_group" "aurora_sg" {
  name        = "${var.name_prefix}-aurora-sg"
  description = "Permet les connexions PostgreSQL depuis ECS Fargate"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL depuis ECS Fargate"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]  
  }

  egress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"] # ou IP de destination spécifique
  description = "Sortie HTTPS vers services internes"
}


  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-aurora-sg"
  })
}

# SG pour le Bastion
resource "aws_security_group" "bastion_sg" {
  name        = "${var.name_prefix}-bastion-sg"
  description = "Accès SSH limité pour le bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.authorized_cidr
    description = "SSH access from allowed IPs"
  }

  egress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"] # ou IP de destination spécifique
  description = "Sortie HTTPS vers services internes"
}


  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-bastion-sg"
  })
}

# SG pour ECS
resource "aws_security_group" "ecs_sg" {
  name        = "${var.name_prefix}-ecs-sg"
  description = "SG pour ECS Fargate"
  vpc_id      = var.vpc_id

  ingress {
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  security_groups = [aws_security_group.alb.id]
  description     = "HTTP depuis ALB uniquement"
}

ingress {
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  security_groups = [aws_security_group.alb.id]
  description     = "HTTPS depuis ALB uniquement"
}


 egress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"] # ou IP de destination spécifique
  description = "Sortie HTTPS vers services internes"
}


  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-ecs-sg"
  })
}

# SG pour ALB
resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-alb-sg"
  description = "SG pour ALB (HTTP/HTTPS depuis l’extérieur)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.authorized_cidr
    description = "Acces HTTP depuis IP autorisees"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.authorized_cidr
    description = "Acces HTTPS depuis IP autorisees"
  }

 egress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"] # ou IP de destination spécifique
  description = "Sortie HTTPS vers services internes"
}


  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-alb-sg"
  })
}

