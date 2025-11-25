# Dockerfile for Customer Database
# PostgreSQL with pre-populated PII data for anonymization testing

FROM postgres:15-alpine

# Set environment variables from .env requirements
ENV POSTGRES_DB=demo_db
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres123

# Copy initialization script
COPY init-db.sql /docker-entrypoint-initdb.d/

# Health check
HEALTHCHECK --interval=10s --timeout=3s --start-period=30s --retries=3 \
    CMD pg_isready -U postgres -d demo_db || exit 1

# Expose PostgreSQL port
EXPOSE 5432