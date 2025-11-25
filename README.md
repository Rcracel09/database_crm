# 🗄️ Customer Database

**PostgreSQL database with Portuguese PII data for anonymization testing**

Part of LTPLabs E-Catalog - Requisitos e Arquiteturas de Software (MEI, UMinho 2025/2026)

---

## 📋 Overview

Esta é uma base de dados PostgreSQL pré-populada com **dados PII portugueses** para demonstração e teste de anonimização.

### Dados Incluídos
- **10 clientes** portugueses
- **18 interações** comerciais
- **PII rico**: nomes, emails, telefones, moradas, texto livre

---

## 🏗️ Estrutura

```
customer-db/
├── Dockerfile           # PostgreSQL com dados
├── init-db.sql         # Script de inicialização
├── .env                # Credenciais
├── k8s/
│   └── values.yaml     # Configuração K8s
└── README.md
```

---

## 🚀 Quick Start

### Local (Docker)

```bash
# Build
docker build -t customer-db:local .

# Run
docker run -d \
  --name customer-db \
  -p 5432:5432 \
  customer-db:local

# Connect
psql -h localhost -U postgres -d demo_db
# Password: postgres123
```

### Minikube (Kubernetes)

```bash
# Build for Minikube
eval $(minikube docker-env)
docker build -t customer-db:local .

# Deploy (via umbrella chart ou manual)
kubectl apply -f k8s/deployment.yaml

# Check
kubectl get pods | grep customer-db
```

---

## 📊 Database Schema

### Table: `customers`
```sql
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),        -- PII
    email VARCHAR(255),       -- PII
    phone VARCHAR(50),        -- PII
    address TEXT,             -- PII
    company VARCHAR(255),
    notes TEXT,               -- PII (texto livre)
    created_at TIMESTAMP
);
```

### Table: `interactions`
```sql
CREATE TABLE interactions (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    interaction_type VARCHAR(50),
    subject VARCHAR(255),
    description TEXT,         -- PII (texto livre)
    created_by VARCHAR(255),  -- PII
    created_at TIMESTAMP
);
```

---

## 🔒 PII Fields

### Direct PII
- `customers.name` - Nome completo
- `customers.email` - Email .pt
- `customers.phone` - Telefone +351
- `customers.address` - Morada completa
- `interactions.created_by` - Nome do agente

### Free Text PII
- `customers.notes` - Notas com nomes/emails
- `interactions.description` - Descrições ricas em PII

---

## 🧪 Testing

```bash
# Connect to database
docker exec -it customer-db psql -U postgres -d demo_db

# Check data
SELECT COUNT(*) FROM customers;    -- Should be 10
SELECT COUNT(*) FROM interactions; -- Should be 18

# View sample data
SELECT name, email, phone FROM customers LIMIT 3;
```

---

## 🔧 Configuration

### Environment Variables (.env)
```
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DB=demo_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres123
```

### Kubernetes (k8s/values.yaml)
```yaml
image: customer-db:local
port: 5432
persistence:
  enabled: true
  size: 2Gi
```

---

## 📝 Sample Data

```sql
-- Customer example
João Silva Santos
joao.silva@techcorp.pt
+351 912 345 678
Rua das Flores, 123, 4º Andar, 4000-230 Porto

-- Interaction example
Type: email
Description: "Enviado email com proposta para joao.silva@techcorp.pt. 
             Cópia para Maria Costa (maria.costa@ltplabs.pt)."
Created by: João Silva (Account Manager)
```

---

## ✅ Ready for Anonymization

Esta database está pronta para ser processada pelo script de anonimização do E-Catalog.

**Campos a anonimizar**: ver `init-db.sql` para detalhes completos.

---

## 📞 Connection Info

**Host**: `customer-db` (service name no K8s)  
**Port**: `5432`  
**Database**: `demo_db`  
**User**: `postgres`  
**Password**: `postgres123`

---

**Status**: ✅ Ready for deployment