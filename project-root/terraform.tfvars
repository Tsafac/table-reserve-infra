aws_region  = "us-east-1"
aws_profile = "unify"
name_prefix = "unify"

project     = "reservation-app"
domain_name = "reservation-app"

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
