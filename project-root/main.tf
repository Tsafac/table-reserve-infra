data "aws_caller_identity" "current" {}


# 1. Réseaux
module "vpc" {
  source             = "../modules/vpc"
  vpc1_cidr_block    = var.vpc1_cidr_block
  vpc2_cidr_block    = var.vpc2_cidr_block
  public_subnet_1    = var.public_subnet_1
  public_subnet_2    = var.public_subnet_2
  private_subnet_1   = var.private_subnet_1
  private_subnet_2   = var.private_subnet_2
  availability_zone  = var.availability_zone
  name_prefix        = var.name_prefix
  default_tags       = var.default_tags
  vpc_flow_logs_role_arn = module.iam.vpc_flow_logs_role_arn
}


module "vpc_peering" {
  source                 = "../modules/vpc-peering"
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
  source             = "../modules/sg"
  name_prefix        = var.name_prefix
  default_tags       = var.default_tags
  domain_name        = var.domain_name
  vpc_id             = module.vpc.vpc_2_id
  authorized_cidr    = ["192.168.1.0/24", "10.0.0.0/16"]  # Exemple IP autorisées SSH
}

module "bastion" {
  source           = "../modules/bastion"
  ami_id           = var.bastion_ami_id
  instance_type    = var.bastion_instance_type
  subnet_id        = module.vpc.public_subnet_1
  bastion_sg_id    = module.sg.bastion_sg_id
  key_name         = var.key_name
  domain_name      = var.domain_name
  default_tags     = var.default_tags
}


module "iam" {
  source        = "../modules/iam"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  aurora_secret_arn = module.aurora.aurora_secret_arn
  account_id          = data.aws_caller_identity.current.account_id
  region        = var.aws_region
  kms_aurora_key_arn   = module.kms.kms_key_id
  name_prefix          = var.name_prefix
}

module "kms" {
  project       = var.project
  source        = "../modules/kms"
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  

}

module "security" {
  source                   = "../modules/security"
  project                  = var.project
  domain_name              = var.domain_name
  default_tags             = var.default_tags
  budget_limit             = "20"
  budget_notification_email = "ton.email@exemple.com"
}

# 3. Backend (Base de données + Fargate)
module "aurora" {
  source              = "../modules/aurora"
  name_prefix         = var.name_prefix
  db_username         = "admin"
  db_password         = var.db_password
  db_name             = "reservation_db"
  db_instance_class   = "db.t3.medium"
  aurora_sg_id        = module.sg.aurora_sg_id
  kms_key_id          = module.kms.kms_key_id              
  domain_name         = var.domain_name
  default_tags        = var.default_tags
  aurora_subnet_ids   = [module.vpc.private_subnet_2]
}




module "ecr" {
  source        = "../modules/ecr"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  ecr_repo_name = "reservation-app"
}

module "ecs_fargate" {
  source              = "../modules/ecs-fargate"
  project             = var.project
  domain_name         = var.domain_name
  default_tags        = var.default_tags
  image_url           = "${module.ecr.repository_url}:latest"
  execution_role_arn  = module.iam.ecs_execution_role_arn
  task_role_arn       = module.iam.task_role_arn
  aurora_secret_arn = module.aurora.aurora_secret_arn
  private_subnets     = module.vpc.private_subnets
  service_sg_id       = module.sg.fargate_sg_id
  target_group_arn    = module.alb.target_group_arn
  ecs_sg_id           = module.sg.ecs_sg_id
  environment         = var.environment 
}

# 4. Authentification
module "cognito" {
  source                  = "../modules/cognito"
  project                 = var.project
  domain_name             = var.domain_name
  default_tags            = var.default_tags
  callback_urls           = var.callback_urls
  logout_urls             = var.logout_urls
  cognito_domain_prefix   = var.cognito_domain_prefix
  aws_region              = var.aws_region 
}

# 5. Communication temps réel
module "websocket" {
  source                  = "../modules/websocket"
  project                 = var.project
  domain_name             = var.domain_name
  default_tags            = var.default_tags
  integration_uri         = module.ecs_fargate.service_uri
  websocket_domain_name   = "ws.${var.domain_name}"
  websocket_cert_arn      = module.acm.cert_arn
}



# 6bis. Certificat ACM 
module "acm" {
  source              = "../modules/acm"
  domain_name         = var.domain_name
  alternate_names     = var.alternate_names          
  domain_name_backend = var.domain_name_backend
  alternate_names_backend = var.alternate_names_backend 
  hosted_zone_id      = var.hosted_zone_id
  default_tags        = var.default_tags
  providers = {
    aws = aws.us_east_1
  }
}




# 6. Frontend + Accès
module "s3" {
  source             = "../modules/s3"
  name_prefix        = var.name_prefix
  oac_policy_json    = data.aws_iam_policy_document.oac_policy.json
  default_tags       = var.default_tags
  kms_key_arn        = module.kms.frontend_key_arn
}


module "alb" {
  source              = "../modules/alb"
  name_prefix         = var.name_prefix
  vpc_id              = module.vpc.vpc_2_id
  public_subnets      = module.vpc.public_subnets
  security_group_ids  = [module.sg.alb_sg_id]
  default_tags        = var.default_tags
  certificate_arn     = module.acm.regional_cert_arn   
  domain_name         = var.domain_name                
}


module "cloudfront" {
  source                  = "../modules/cloudfront"

  alb_dns_name            = module.alb.alb_dns_name
  acm_cert_arn            = module.acm.cert_arn
  cloudfront_logs_bucket  = module.s3.logs_bucket_name
  cloudfront_domain_name  = "www.${var.domain_name}"
  name_prefix             = var.name_prefix
  project                 = var.project
  default_tags            = var.default_tags
  domain_name             = var.domain_name  
}



module "route53" {
  source                  = "../modules/Route53"
  project                 = var.project
  domain_name             = var.domain_name
  default_tags            = var.default_tags
  zone_name               = var.zone_name
  alb_dns_name            = module.alb.alb_dns_name
  alb_dns_zone_id         = module.alb.alb_zone_id
  websocket_domain_target = module.websocket.websocket_domain_target
  websocket_zone_id       = module.websocket.websocket_zone_id
}



# 7. Sécurité web
module "waf" {
  source        = "../modules/waf"
  project       = var.project
  domain_name   = var.domain_name
  default_tags  = var.default_tags
  alb_arn       = module.alb.alb_arn
}

# 8. Observabilité
module "cloudwatch" {
  source               = "../modules/cloudwatch"
  project              = var.project
  domain_name          = var.domain_name
  default_tags         = var.default_tags
  retention_in_days    = 14
  aurora_cluster_id    = module.aurora.cluster_id
  alb_metric_name      = module.alb.metric_name
  waf_metric_name      = module.waf.metric_name
}
