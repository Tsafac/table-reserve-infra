# 1. Réseaux
module "vpc" {
  source        = "./modules/vpc"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
}

module "vpc_peering" {
  source                 = "./modules/vpc_peering"
  vpc1_id                = module.vpc.vpc_1_id
  vpc2_id                = module.vpc.vpc_2_id
  vpc1_route_table_id    = module.vpc.vpc_1_route_table_id
  vpc2_route_table_id    = module.vpc.vpc_2_route_table_id
  vpc1_cidr_block        = var.vpc1_cidr_block
  vpc2_cidr_block        = var.vpc2_cidr_block
  default_tags           = var.default_tags
}

# 2. Sécurité
module "sg" {
  source        = "./modules/sg"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  # autres variables (cidr SSH, etc.)
}

module "iam" {
  source        = "./modules/iam"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
}

module "kms" {
  source        = "./modules/kms"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
}

module "security" {
  source                   = "./modules/security"
  project                  = var.project
  domain_name              = var.domain_name
  default_tags             = var.default_tags
  budget_limit             = "20"
  budget_notification_email = "ton.email@exemple.com"
}

# 3. Backend (Base de données + Fargate)
module "aurora" {
  source                = "./modules/aurora"
  project               = var.project
  domain_name           = var.domain_name
  default_tags          = var.default_tags
  kms_key_arn           = module.kms.kms_key_arn
  ecs_service_sg_id     = module.sg.fargate_sg_id
  # autres variables...
}

module "ecr" {
  source        = "./modules/ecr"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  ecr_repo_name = "reservation-app"
}

module "ecs_fargate" {
  source              = "./modules/ecs-fargate"
  project             = var.project
  domain_name         = var.domain_name
  default_tags        = var.default_tags
  image_url           = "${module.ecr.repository_url}:latest"
  execution_role_arn  = module.iam.ecs_execution_role_arn
  task_role_arn       = module.iam.task_role_arn
  aurora_secret_arn   = module.aurora.secret_arn
  private_subnets     = module.vpc.private_subnets
  service_sg_id       = module.sg.fargate_sg_id
  target_group_arn    = module.alb.target_group_arn
}

# 4. Authentification
module "cognito" {
  source                  = "./modules/cognito"
  project                 = var.project
  domain_name             = var.domain_name
  default_tags            = var.default_tags
  callback_urls           = var.callback_urls
  logout_urls             = var.logout_urls
  cognito_domain_prefix   = var.cognito_domain_prefix
  environment             = var.environment
}

# 5. Communication temps réel
module "websocket" {
  source              = "./modules/websocket"
  project             = var.project
  domain_name         = var.domain_name
  default_tags        = var.default_tags
  integration_uri     = module.ecs_fargate.service_uri
  websocket_sg_id     = module.sg.websocket_sg_id
}

# 6. Frontend + Accès
module "s3" {
  source        = "./modules/s3"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
}

module "alb" {
  source              = "./modules/alb"
  project             = var.project
  domain_name         = var.domain_name
  default_tags        = var.default_tags
  vpc_id              = module.vpc.vpc_2_id
  public_subnets      = module.vpc.public_subnets
  security_group_ids  = [module.sg.alb_sg_id]
}

module "cloudfront" {
  source           = "./modules/cloudfront"
  project          = var.project
  domain_name      = var.domain_name
  default_tags     = var.default_tags
  alb_dns_name     = module.alb.alb_dns_name
  waf_acl_arn      = module.waf.waf_acl_arn
  acm_cert_arn     = module.acm.cert_arn
}

module "route53" {
  source            = "./modules/route53"
  project           = var.project
  domain_name       = var.domain_name
  default_tags      = var.default_tags
  zone_name         = var.zone_name
  alb_dns_name      = module.alb.alb_dns_name
  alb_dns_zone_id   = module.alb.alb_zone_id
}

# 7. Sécurité web
module "waf" {
  source        = "./modules/waf"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  alb_arn       = module.alb.alb_arn
}

# 8. Observabilité
module "cloudwatch" {
  source               = "./modules/cloudwatch"
  project              = var.project
  domain_name          = var.domain_name
  default_tags         = var.default_tags
  retention_in_days    = 14
  aurora_cluster_id    = module.aurora.cluster_id
  alb_metric_name      = module.alb.metric_name
  waf_metric_name      = module.waf.metric_name
}
