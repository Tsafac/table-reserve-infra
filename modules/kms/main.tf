resource "aws_kms_key" "aurora_kms" {
  description             = "Clé KMS pour chiffrer Aurora et les secrets associés"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}

resource "aws_kms_alias" "aurora_alias" {
  name          = "alias/${var.project}-aurora-kms"
  target_key_id = aws_kms_key.aurora_kms.key_id
}

resource "aws_kms_key" "frontend_key" {
  description         = "Clé KMS pour chiffrer le bucket S3 du frontend"
  enable_key_rotation = true
  
  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-frontend-kms-key"
  })
}
