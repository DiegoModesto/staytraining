#!/usr/bin/env bash
# StayTraining — helper de desenvolvimento.
# Uso: scripts/dev.sh <comando>
#   infra    Sobe apenas a infraestrutura (Postgres, Auth-DB, Redis, RabbitMQ, MinIO, Seq)
#   migrate  Aplica as migrations do EF (ApplicationDbContext + AuthDbContext)
#   backend  Sobe TODOS os serviços do backend via docker compose (build)
#   mobile   Roda o app Flutter (uso: scripts/dev.sh mobile [android|ios] [deviceId])
#   all      infra + migrate + backend  (stack completa)
#   stop     Derruba todos os containers (docker compose down)
#   status   Mostra containers e devices Flutter
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BACKEND="$ROOT/backend"
MOBILE="$ROOT/mobile"

log() { printf '\033[1;34m[dev]\033[0m %s\n' "$*"; }

wait_pg() {
  log "Aguardando o Postgres ficar pronto..."
  for _ in $(seq 1 30); do
    if docker compose -f "$BACKEND/compose.yaml" exec -T postgres pg_isready -U postgres >/dev/null 2>&1; then
      log "Postgres pronto."; return 0
    fi
    sleep 2
  done
  log "Postgres não respondeu a tempo (seguindo mesmo assim)."
}

infra() {
  cd "$BACKEND"
  log "Subindo infraestrutura..."
  docker compose up -d postgres auth-postgres redis rabbitmq minio seq
  wait_pg
}

migrate() {
  export PATH="$PATH:$HOME/.dotnet/tools"
  cd "$BACKEND"
  log "Aplicando migrations (ApplicationDbContext)..."
  dotnet ef database update --project src/Infra --startup-project src/EntryPoints/Web.API
  log "Aplicando migrations (AuthDbContext)..."
  dotnet ef database update --project src/Auth.Infra --startup-project src/EntryPoints/Auth.API || \
    log "AuthDbContext: verifique se o projeto Auth.Infra tem migrations."
}

backend() {
  cd "$BACKEND"
  log "Subindo o backend completo (build pode demorar na 1ª vez)..."
  docker compose up -d --build auth.api gateway web.api web.blazor worker cronjobs
  log "Backend no ar: Gateway http://localhost:5200 | Web.API http://localhost:5010 | Auth http://localhost:5100 | Backoffice http://localhost:5002 | Seq http://localhost:5341 | MinIO http://localhost:9001"
}

mobile() {
  local platform="${1:-ios}" device="${2:-}"
  local api_host="localhost"
  [ "$platform" = "android" ] && api_host="10.0.2.2"
  cd "$MOBILE"
  local defs=(
    "--dart-define=API_BASE_URL=http://${api_host}:5200"
    "--dart-define=AUTH_ISSUER=http://${api_host}:5100"
    "--dart-define=AUTH_CLIENT_ID=mobile-app"
    "--dart-define=AUTH_REDIRECT_URI=com.staytraining.app://oauth"
  )
  log "flutter run (${platform}) contra http://${api_host}:5200"
  if [ -n "$device" ]; then
    flutter run -d "$device" "${defs[@]}"
  else
    flutter run "${defs[@]}"
  fi
}

all() { infra; migrate; backend; }

stop() { cd "$BACKEND"; log "Derrubando containers..."; docker compose down; }

status() {
  cd "$BACKEND"
  docker compose ps
  echo "--- flutter devices ---"
  flutter devices || true
}

case "${1:-help}" in
  infra) infra ;;
  migrate) migrate ;;
  backend) backend ;;
  mobile) shift; mobile "$@" ;;
  all) all ;;
  stop) stop ;;
  status) status ;;
  *) sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//' ;;
esac
