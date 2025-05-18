# 📦 Projet Terraform – Infrastructure AWS pour Application de Réservation

## ✨ Objectif
Ce projet met en place une infrastructure cloud complète et modulaire sur AWS pour une application de réservation. Elle est décrite à l'aide de Terraform, selon une architecture multi-AZ et conforme aux bonnes pratiques DevOps.

## 🗂️ Arborescence du projet

```
TABLE-RESERVE-INFRA/
├── modules/                        # Modules Terraform réutilisables
│   ├── acm                         # Certificats ACM (frontend/backend)
│   ├── alb                         # Load Balancer HTTP/HTTPS
│   ├── aurora                      # Cluster RDS Aurora PostgreSQL
│   ├── bastion                     # EC2 Bastion host pour accès SSH
│   ├── cloudfront                  # CDN pour le frontend
│   ├── cloudwatch                  # Logs ECS et métriques CloudWatch
│   ├── cognito                     # Authentification utilisateur
│   ├── ecr                         # Registry pour les images Docker
│   ├── ecs-fargate                 # Déploiement backend via ECS Fargate
│   ├── iam                         # Rôles IAM nécessaires
│   ├── kms                         # Clés de chiffrement (optionnel)
│   ├── Route53                     # Enregistrements DNS
│   ├── s3                          # Buckets S3 (frontend et logs)
│   ├── security                    # CloudTrail, GuardDuty, Budget
│   ├── sg                          # Security Groups (ECS, Bastion, ALB...)
│   ├── vpc                         # Création des VPCs publics/privés
│   ├── vpc-peering                 # Peering entre VPC 1 et VPC 2
│   ├── waf                         # Web Application Firewall (CloudFront)
│   └── websocket                   # API Gateway WebSocket
│
├── project-root/
│   ├── main.tf                     # Composition globale (appel modules)
│   ├── variables.tf                # Variables globales
│   ├── outputs.tf                  # Valeurs exportées
│   ├── provider.tf                 # Configuration AWS (multi-region)
│   ├── terraform.tfvars            # Valeurs concrètes des variables
│   ├── terraform.lock.hcl          # Lockfile provider
│   ├── tfplan                      # Plan terraform (binaire)
│   └── README.md                   # Ce fichier
```

## ☁️ Stack AWS utilisée

- **Amazon VPC** – Deux VPCs interconnectés (peering)
- **ALB** – Pour l'exposition du backend (HTTPS)
- **Amazon ECS (Fargate)** – Déploiement du backend
- **Amazon Aurora** – Base de données PostgreSQL
- **Amazon Cognito** – Authentification utilisateurs
- **Amazon CloudFront + S3** – Distribution frontend statique
- **Amazon WAF** – Protection contre attaques web courantes
- **API Gateway WebSocket** – Communication temps réel
- **IAM, CloudWatch, GuardDuty, Budgets** – Sécurité et monitoring

## 🔐 Sécurité

- Utilisation de `aws-vault` pour gérer les credentials AWS de façon sécurisée
- Les rôles IAM sont strictement définis pour les services nécessaires
- Sécurité réseau assurée par des SG bien cloisonnés et des subnets privés/publics

## ⚠️ Problème volontaire sur Route53

L'erreur suivante apparaît lors du `terraform plan` :

``
Error: no matching Route 53 Hosted Zone found
```

🎯 **Explication** :
Le module `Route53` tente de rechercher une zone DNS (`data "aws_route53_zone"`) correspondant au domaine `"example.com"` mais celle-ci **n’a pas été créée dans AWS**.

👉 Ce comportement est attendu et volontaire :
- Pour les besoins du test, il n’était **pas requis de provisionner une vraie zone Route53**.
- Il suffit de créer cette zone dans AWS ou de **commenter temporairement le module Route53** si non nécessaire.

## 🚀 Déploiement (local avec `aws-vault`)

```bash
# Initialisation
aws-vault exec unify -- terraform init

# Vérification de la validité
aws-vault exec unify -- terraform validate

# Génération du plan (sans apply)
aws-vault exec unify -- terraform plan -out=tfplan
```

## 📝 Auteur

**Fabrice TSAFACK**  
DevSecOps | Cloud | Sécurité | Terraform | Kubernetes  
> `ronicefabrice@gmail.com