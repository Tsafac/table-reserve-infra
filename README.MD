# 🛠️ Projet Terraform : Unify Infrastructure (AWS)

Ce projet provisionne une architecture complète sur AWS pour une application web moderne, avec sécurité, scalabilité, CI/CD, et monitoring intégré.

---

## 📦 Modules inclus

| Module           | Description |
|------------------|-------------|
| `vpc`            | Crée deux VPC : public (`vpc-1`) et privé (`vpc-2`), avec NAT, IGW, subnets |
| `vpc_peering`    | Active le peering entre `vpc-1` et `vpc-2` |
| `sg`             | Définit tous les groupes de sécurité : ALB, Fargate, Aurora, WebSocket, Bastion |
| `kms`            | Clé KMS pour chiffrer Aurora et secrets |
| `iam`            | Rôles pour ECS Fargate (task + execution), avec accès ECR, logs, secrets |
| `ecr`            | Registre privé Docker pour l’image backend |
| `ecs-fargate`    | Déploie le backend dans ECS Fargate (subnets privés) |
| `aurora`         | Cluster Aurora PostgreSQL dans les subnets privés |
| `cognito`        | Authentification utilisateur via Cognito (frontend web) |
| `websocket`      | API Gateway WebSocket connecté au backend Fargate |
| `alb`            | Application Load Balancer (HTTPS + redirection HTTP) |
| `cloudfront`     | CDN sécurisé devant l’ALB |
| `s3`             | Héberge le frontend statique + logs CloudFront |
| `route53`        | DNS public pour le site (`zone_name`) |
| `waf`            | Web Application Firewall (CloudFront + ALB) |
| `cloudwatch`     | Logs ECS, alarmes sur Aurora, ALB, WAF, erreurs |
| `security`       | Active CloudTrail, GuardDuty et AWS Budgets |
| `bastion`        | Instance EC2 publique (SSH) pour administrer les ressources dans `vpc-2` |

---

## 🔧 Fichiers Terraform principaux

- `main.tf` → orchestre tous les modules
- `variables.tf` → centralise les variables globales
- `terraform.tfvars` → valeurs concrètes (ex: région, domaine, budget)
- `outputs.tf` → expose les valeurs clés (ALB DNS, IP bastion, secrets, etc.)

---

## ▶️ Déploiement

1. Configure ton profil AWS CLI (`~/.aws/credentials`)
2. Clone le projet et initialise Terraform :

```bash
terraform init
terraform apply -var-file="terraform.tfvars"
