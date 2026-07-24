#!/usr/bin/env bash
# StayTraining — limpeza COMPLETA da base de dados de negócio (dev) + reseed.
#
# Apaga todos os dados da app (catálogo, treinos, agenda, sessões, notas, perguntas, perfis…)
# no Postgres de desenvolvimento e reinicia a Web.API, que re-semeia tudo (catálogo + Rita/Diego).
# NÃO toca no banco de autenticação (auth_db) — clientes OpenIddict/usuários permanecem.
#
# Uso: scripts/reset-db.sh [--yes]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BACKEND="$ROOT/backend"
COMPOSE="$BACKEND/compose.yaml"
DB_SERVICE="postgres"
DB_NAME="staytraining"
DB_USER="postgres"

log() { printf '\033[1;34m[reset-db]\033[0m %s\n' "$*"; }

if [ "${1:-}" != "--yes" ]; then
  printf '\033[1;33m[reset-db]\033[0m Isso APAGA todos os dados de negócio de "%s" (dev). Continuar? [y/N] ' "$DB_NAME"
  read -r ans
  case "$ans" in y|Y|s|S) ;; *) log "Cancelado."; exit 0 ;; esac
fi

log "Truncando tabelas de negócio (mantém __EFMigrationsHistory)..."
# TRUNCATE ... CASCADE resolve as FKs; RESTART IDENTITY zera sequências. Lista dinâmica de todas
# as tabelas do schema public exceto o histórico de migrations.
docker compose -f "$COMPOSE" exec -T "$DB_SERVICE" psql -U "$DB_USER" -d "$DB_NAME" -v ON_ERROR_STOP=1 <<'SQL'
DO $$
DECLARE
  stmt text;
BEGIN
  SELECT 'TRUNCATE TABLE '
       || string_agg(format('%I.%I', schemaname, tablename), ', ')
       || ' RESTART IDENTITY CASCADE'
    INTO stmt
    FROM pg_tables
   WHERE schemaname = 'public'
     AND tablename <> '__EFMigrationsHistory';
  IF stmt IS NOT NULL THEN
    EXECUTE stmt;
  END IF;
END $$;
SQL

log "Reiniciando a Web.API para re-semear (catálogo + Rita/Diego)..."
docker compose -f "$COMPOSE" restart web.api >/dev/null

# Aguarda ficar saudável.
for _ in $(seq 1 30); do
  st="$(docker inspect --format '{{.State.Health.Status}}' staytraining_api 2>/dev/null || echo starting)"
  [ "$st" = "healthy" ] && { log "Web.API saudável — base re-semeada."; exit 0; }
  sleep 3
done
log "Web.API reiniciada (health não confirmado a tempo; verifique 'docker compose logs web.api')."
