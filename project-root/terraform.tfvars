aws_region  = "us-east-1"
aws_profile = "unify"
name_prefix = "unify"

project     = "reservation-app"

default_tags = {
  Environment = "production"
  Owner       = "ronice"
}

environment = "production"

vpc1_cidr_block = "10.0.0.0/16"
vpc2_cidr_block = "10.1.0.0/16"

callback_urls         = ["https://www.reservation-app.com/callback"]
logout_urls           = ["https://www.reservation-app.com/logout"]
cognito_domain_prefix = "reservation-auth"

zone_name = "reservation-app.com"

budget_limit             = "25"
budget_notification_email = "admin@reservation-app.com"
availability_zone = "eu-west-3a"  
bastion_ami_id    = "ami-xxxxxxxxxxxxxxxxx"
db_password            = "MonMotDePasseSuperSecurisé"
domain_name            = "example.com"
domain_name_backend    = "api.example.com"
execution_role_arn     = "arn:aws:iam::123456789012:role/ecs-exec-role"
hosted_zone_id         = "ZXXXXXXXXXXXX"
integration_uri        = "https://your-api-id.execute-api.eu-west-3.amazonaws.com"
key_name               = "ma-cle-ssh"
private_subnet_1       = "10.0.2.0/24"
private_subnet_2       = "10.0.3.0/24"
public_subnet_1        = "10.0.0.0/24"
public_subnet_2        = "10.0.1.0/24"
kms_aurora_key_arn = "arn:aws:kms:eu-west-3:123456789012:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

