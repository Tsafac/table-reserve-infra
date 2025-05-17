# Subnet group Aurora (private-2)
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${var.name_prefix}-aurora-subnet-group"
  subnet_ids = [aws_subnet.private-2.id]

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}

# Secret Manager : stocke identifiants Aurora
resource "aws_secretsmanager_secret" "aurora_secret" {
  name = "${var.name_prefix}-aurora-secret"

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}

resource "aws_secretsmanager_secret_version" "aurora_secret_version" {
  secret_id     = aws_secretsmanager_secret.aurora_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_rds_cluster.aurora.endpoint
    port     = 5432
    dbname   = var.db_name
  })
}

# Cluster Aurora PostgreSQL (chiffré avec KMS, SG via module)
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.name_prefix}-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "15.2"
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [var.aurora_sg_id]                        
  backup_retention_period = 7
  skip_final_snapshot     = true

  storage_encrypted = true
  kms_key_id        = var.kms_key_id

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })

  depends_on = [aws_secretsmanager_secret_version.aurora_secret_version]
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = var.aurora_instance_count
  identifier         = "${var.name_prefix}-aurora-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
  publicly_accessible = false

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}

