output "bucket_name" {
  value       = aws_s3_bucket.frontend.bucket
  description = "Nom du bucket frontend"
}

output "cf_logs_bucket_name" {
  value       = aws_s3_bucket.cf_logs.bucket
  description = "Nom du bucket de logs CloudFront"
}

output "s3_block_public_access_config" {
  description = "Configuration du blocage d'accès public"
  value = {
    block_public_acls       = aws_s3_bucket_public_access_block.frontend_block.block_public_acls
    ignore_public_acls      = aws_s3_bucket_public_access_block.frontend_block.ignore_public_acls
    block_public_policy     = aws_s3_bucket_public_access_block.frontend_block.block_public_policy
    restrict_public_buckets = aws_s3_bucket_public_access_block.frontend_block.restrict_public_buckets
  }
}

output "cf_logs_bucket_arn" {
  description = "ARN du bucket de logs CloudFront"
  value       = aws_s3_bucket.cf_logs.arn
}

output "frontend_bucket_arn" {
  description = "ARN du bucket principal"
  value       = aws_s3_bucket.frontend.arn
}

output "logs_bucket_name" {
  description = "Nom du bucket de logs CloudFront"
  value       = aws_s3_bucket.cf_logs.bucket
}
