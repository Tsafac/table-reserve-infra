# 📦 Projet Terraform – Infrastructure AWS pour Application de Réservation

Bienvenue ! Ce dépôt contient le code Terraform permettant de déployer une infrastructure **cloud-native**, **scalable** et **sécurisée** sur AWS, destinée à héberger une application web de réservation de tables dans un restaurant. Le projet est modulaire, reproductible et conforme aux meilleures pratiques DevSecOps.

---

## ✨ Objectif

- Déployer une application web de réservation de tables avec frontend statique
- Backend déployé sur ECS Fargate
- Stockage des données via Aurora PostgreSQL
- Authentification utilisateur avec Cognito
- Sécurité, audit, supervision et chiffrement intégrés

---

## 🗂️ Arborescence du projet

```
TABLE-RESERVE-INFRA/
├── modules/
│   ├── acm                         # Certificats SSL
│   ├── alb                         # Application Load Balancer
│   ├── aurora                      # Cluster Aurora PostgreSQL
│   ├── bastion                     # Hôte Bastion EC2
│   ├── cloudfront                  # CDN pour le frontend
│   ├── cloudwatch                  # Logs & monitoring
│   ├── cognito                     # Authentification utilisateurs
│   ├── ecr                         # Registre Docker
│   ├── ecs-fargate                 # Services backend sur Fargate
│   ├── iam                         # Rôles et politiques IAM
│   ├── kms                         # Chiffrement avec KMS
│   ├── Route53                     # DNS
│   ├── s3                          # Buckets S3 (frontend & logs)
│   ├── security                    # CloudTrail, GuardDuty, Budgets
│   ├── sg                          # Groupes de sécurité
│   ├── vpc                         # Réseaux VPC publics/privés
│   ├── vpc-peering                 # Peering entre VPCs
│   ├── waf                         # Web Application Firewall
│   └── websocket                   # API Gateway WebSocket
│
├── project-root/
│   ├── main.tf                     # Assemblage des modules
│   ├── variables.tf                # Variables globales
│   ├── outputs.tf                  # Outputs Terraform
│   ├── provider.tf                 # Fournisseur AWS
│   ├── terraform.tfvars            # Valeurs concrètes
│   └── terraform.lock.hcl          # Lockfile
```

---

## ☁️ Services AWS utilisés

- **VPC** (2 régions, peering)
- **ALB** en HTTPS pour le backend
- **ECS Fargate** pour les conteneurs applicatifs
- **Aurora PostgreSQL** (multi-AZ)
- **S3 + CloudFront** pour le frontend statique
- **Cognito** pour la gestion des utilisateurs
- **WAF**, **IAM**, **CloudWatch**, **GuardDuty**, **Budgets** pour la sécurité
- **API Gateway WebSocket** pour le temps réel

---

## 🔐 Sécurité & Bonnes pratiques

- Accès sécurisé via `aws-vault`
- IAM en principe du moindre privilège
- Chiffrement KMS des données sensibles
- Journaux avec CloudTrail et alertes avec GuardDuty
- Segmentation réseau avec subnets publics/privés
- Gestion proactive des coûts via AWS Budgets

---

## ✅ Scan tfsec – Sécurité Infra

| Niveau   | Description                                                            | Statut |
|----------|------------------------------------------------------------------------|--------|
| HIGH     | ALB exposé (protégé par WAF)                                          | ✅ OK |
| MEDIUM   | Absence logs WebSocket en test                                        | ✅ OK |
| LOW      | Clés KMS gérées par AWS (CMK recommandé en prod)                      | ✅ OK |
| LOW      | Performance Insights désactivé sur Aurora                             | ✅ OK |
| LOW      | Logs CloudWatch non chiffrés avec CMK                                 | ✅ OK |

---

## ⚠️ Problème Route53

Erreur possible :
```bash
Error: no matching Route 53 Hosted Zone found
```
**Solution** :
- Créer manuellement la zone DNS via la console AWS
- Ou commenter le module `route53` dans `main.tf`

---

## 🚀 Déploiement local avec aws-vault

```bash
aws-vault exec unify -- terraform init
aws-vault exec unify -- terraform validate
aws-vault exec unify -- terraform plan -out=tfplan
```

---

## 🔁 Intégration CI/CD GitLab

Le pipeline CI/CD inclut :

- `tfsec` pour la sécurité Terraform
- `tflint` pour les bonnes pratiques
- `snyk`, `trivy` pour la sécurité des conteneurs
- Étapes de `plan` et `apply` avec approbation manuelle

---

## 📝 Auteur

**Fabrice TSAFACK**  
DevSecOps | Cloud | Terraform | Kubernetes  
📧 ronicefabrice@gmail.com