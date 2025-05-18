# 📦 Projet Terraform – Infrastructure AWS pour Application de Réservation

## ✨ Objectif
Ce projet met en place une infrastructure cloud complète et modulaire sur AWS pour une application de réservation. Elle est décrite à l'aide de Terraform, selon une architecture multi-AZ et conforme aux bonnes pratiques DevOps et sécurité.

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
│   ├── kms                         # Clés de chiffrement KMS
│   ├── Route53                     # Enregistrements DNS
│   ├── s3                          # Buckets S3 (frontend et logs)
│   ├── security                    # CloudTrail, GuardDuty, Budget
│   ├── sg                          # Security Groups (ECS, Bastion, ALB...)
│   ├── vpc                         # Création des VPCs publics/privés
│   ├── vpc-peering                 # Peering entre VPC 1 et VPC 2
│   ├── waf                         # Web Application Firewall (CloudFront/ALB)
│   └── websocket                   # API Gateway WebSocket
│
├── project-root/
│   ├── main.tf                     # Composition globale (appel des modules)
│   ├── variables.tf                # Déclaration des variables globales
│   ├── outputs.tf                  # Valeurs exportées
│   ├── provider.tf                 # Configuration AWS (multi-région)
│   ├── terraform.tfvars            # Valeurs concrètes des variables
│   ├── terraform.lock.hcl          # Lockfile provider
│   └── README.md                   # Ce fichier
```

## ☁️ Stack AWS utilisée

- **Amazon VPC** – Deux VPC interconnectés (peering)
- **ALB** – Pour l'exposition du backend (HTTPS)
- **Amazon ECS (Fargate)** – Déploiement du backend
- **Amazon Aurora PostgreSQL** – Base de données managée
- **Amazon Cognito** – Authentification des utilisateurs
- **Amazon CloudFront + S3** – Distribution frontend statique
- **Amazon WAF** – Sécurité applicative en couche 7
- **API Gateway WebSocket** – Communication temps réel
- **IAM, CloudWatch, GuardDuty, Budgets** – Sécurité et observabilité

## 🔐 Sécurité et bonnes pratiques

- 🔑 Gestion sécurisée des identifiants via **aws-vault**
- 🔒 IAM : rôles les plus restrictifs possibles selon le principe de moindre privilège
- 🔐 Buckets S3 chiffrés, bloqués en accès public, avec versioning et logs activés
- 🧱 Architecture en **subnets privés et publics**
- 📜 **CloudTrail** et **GuardDuty** activés pour l’audit et la détection d’anomalies
- 📉 Budgets AWS configurés pour éviter les dérives de coûts
- 🔐 KMS utilisé pour le chiffrement des logs, secrets et données sensibles

## ✅ État de la sécurité (`tfsec`)

Un scan a été effectué avec [`tfsec`](https://github.com/aquasecurity/tfsec).

### Résumé :
- ✅ **0 findings critiques**
- ⚠️ **1 finding HIGH (justifié)**
- ⚠️ Quelques findings LOW/MEDIUM documentés

### Détails :
| Niveau   | Description                                                                                 | Statut |
|----------|----------------------------------------------------------------------------------------------|--------|
| HIGH     | **ALB exposé publiquement** – Justifié car protégé par un **WAF** en amont                  | ✔️ OK |
| MEDIUM   | **Absence de logs WebSocket** – Non bloquant pour un environnement de test                  | ✔️ OK |
| LOW      | **Clés KMS gérées par AWS** – Pas bloquant, améliorable avec des CMK personnalisées         | ✔️ OK |
| LOW      | **Performance Insights désactivé (Aurora)** – Activable si besoin en production              | ✔️ OK |
| LOW      | **CloudWatch log group non chiffré avec CMK** – Peu critique pour environnement temporaire  | ✔️ OK |

## ⚠️ Problème volontaire sur Route53

Une erreur peut apparaître à l’exécution :

```
Error: no matching Route 53 Hosted Zone found
```

🎯 **Explication** :  
Le module `Route53` recherche une zone DNS (`data "aws_route53_zone"`) qui **n’a pas été créée dans AWS**.

🛠️ **Solution** :
- Crée manuellement la zone DNS sur AWS (recommandé)
- Ou commente temporairement le module `route53` dans `main.tf` pour bypasser ce check

## 🚀 Déploiement local (via aws-vault)

```bash
# Initialisation du projet
aws-vault exec unify -- terraform init

# Validation de la syntaxe Terraform
aws-vault exec unify -- terraform validate

# Planification des changements
aws-vault exec unify -- terraform plan -out=tfplan
```

## 🧠 Notes supplémentaires

- ✅ Toutes les ressources critiques sont **versionnées**, **chiffrées**, et **monitorées**
- 📦 L’infrastructure est **100% modulaire** (reutilisable sur d'autres projets)
- 📊 Préparation à l’usage en **environnement de production** avec quelques ajustements mineurs

## 📝 Auteur

**Fabrice TSAFACK**  
DevSecOps | Cloud | Sécurité | Terraform | Kubernetes  
📧 `ronicefabrice@gmail.com`