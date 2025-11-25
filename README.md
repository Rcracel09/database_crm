# 🗄️ database_crm

**PostgreSQL database with Portuguese PII data for CRM demo**

Part of LTPLabs E-Catalog - Requisitos e Arquiteturas de Software (MEI, UMinho 2025/2026)

---

## 📋 Overview

Base de dados PostgreSQL pré-populada com **10 clientes portugueses** e **18 interações comerciais** contendo dados PII para demonstração e teste de anonimização.

---

## 🏗️ Structure

```
database_crm/
├── Dockerfile          # PostgreSQL 15 Alpine
├── init-db.sql        # 10 customers + 18 interactions (PII)
└── k8s/
    └── values.yaml    # K8s configuration
```

---

## 📊 Database Schema

### Table: `customers`
- id, name (PII), email (PII), phone (PII), address (PII)
- company, notes (PII - free text), created_at

### Table: `interactions`
- id, customer_id, interaction_type, subject
- description (PII - free text), created_by (PII), created_at

---

## 🚀 Deploy (via catalog_claudio)

```bash
cd catalog_claudio/

# Build and deploy
./scripts/build-deploy.sh database_crm local default

# Verify
kubectl get pods -l app=database-crm
kubectl logs -l app=database-crm
```

---

## 🔧 Configuration (k8s/values.yaml)

```yaml
image: database_crm:local
port: 5432
serviceType: ClusterIP          # Internal only
requiresAuth: false             # Database doesn't need auth

env:
  POSTGRES_DB: "demo_db"
  POSTGRES_USER: "postgres"
  POSTGRES_PASSWORD: "postgres123"
```

---

## 🔗 Service Discovery

The Helm chart automatically creates a Service named `database-crm` that other apps can connect to:

```yaml
# Other apps connect via:
env:
  DB_HOST: "database-crm"  # ← Resolves automatically in K8s
```

---

## 📝 Data Included

- **10 Portuguese customers** with realistic PII
- **18 commercial interactions** with rich free-text PII
- All names, emails, phones in Portuguese format
- Ready for anonymization testing

---

## ✅ Ready for Deployment

This database is 100% ready to work with the catalog_claudio umbrella chart deployment system.

**Status**: ✅ Production Ready