#!/usr/bin/env bash
#
# run-stack.sh — bring up the full StayTraining local stack (infra + the 4 .NET apps).
#
# Usage:
#   scripts/run-stack.sh            # start infra + build + start all apps (default)
#   scripts/run-stack.sh stop       # stop the .NET apps (leaves infra containers running)
#   scripts/run-stack.sh restart    # stop then start
#   scripts/run-stack.sh status     # show what's listening
#   scripts/run-stack.sh down       # stop apps AND infra containers
#
# Ports:  Auth.API 5100 · Web.API 5010 · Gateway 5200 · Web.Blazor 5002 (the site).
# Apps run detached; logs live in .containers/logs/. Both Auth.API and Web.API auto-apply
# their EF migrations on startup in Development, so a fresh database just works.
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

LOGDIR="$ROOT/.containers/logs"
mkdir -p "$LOGDIR"
PIDFILE="$LOGDIR/stack.pids"

INFRA_SERVICES="postgres auth-postgres redis rabbitmq minio seq"

# Dev OpenIddict client secrets — must match the values the consumers expect
# (appsettings.Development.json of Web.API / Gateway / Web.Blazor). Override via env if needed.
export OPENIDDICT_BFF_SECRET="${OPENIDDICT_BFF_SECRET:-dev-only-bff-secret-change-me}"
export OPENIDDICT_WEB_API_SECRET="${OPENIDDICT_WEB_API_SECRET:-dev-only-web-api-secret-change-me}"
export OPENIDDICT_GATEWAY_SECRET="${OPENIDDICT_GATEWAY_SECRET:-dev-only-gateway-secret-change-me}"

# name | project | port | env-var name for the ASPNETCORE/DOTNET environment
APPS=(
  "auth.api|src/EntryPoints/Auth.API|5100|ASPNETCORE_ENVIRONMENT"
  "web.api|src/EntryPoints/Web.API|5010|ASPNETCORE_ENVIRONMENT"
  "gateway|src/EntryPoints/Gateway|5200|ASPNETCORE_ENVIRONMENT"
  "web.blazor|src/EntryPoints/Web.Blazor|5002|ASPNETCORE_ENVIRONMENT"
)

log()  { printf '\033[1;32m▶\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!\033[0m %s\n' "$*"; }

kill_port() {
  local port="$1"
  local pids
  pids="$(lsof -ti "tcp:${port}" -sTCP:LISTEN 2>/dev/null || true)"
  [ -n "$pids" ] && kill $pids 2>/dev/null || true
}

stop_apps() {
  log "Stopping .NET apps…"
  if [ -f "$PIDFILE" ]; then
    while read -r pid; do [ -n "$pid" ] && kill "$pid" 2>/dev/null || true; done < "$PIDFILE"
    rm -f "$PIDFILE"
  fi
  for entry in "${APPS[@]}"; do
    IFS='|' read -r _ _ port _ <<< "$entry"
    kill_port "$port"
  done
  sleep 1
  log "Apps stopped."
}

wait_http() {
  local url="$1" name="$2" tries=40
  for ((i=1; i<=tries; i++)); do
    local code
    code="$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "$url" 2>/dev/null || true)"
    code="${code:-000}"
    if [ "$code" != "000" ]; then
      log "$name is up (HTTP $code)."
      return 0
    fi
    sleep 3
  done
  warn "$name did not respond at $url after $((tries*3))s — check its log in $LOGDIR."
  return 1
}

start_app() {
  local name="$1" project="$2" port="$3" envkey="$4"
  local logfile="$LOGDIR/${name}.log"
  log "Starting ${name} on :${port} …"
  # Detached so the app survives this script exiting; ASPNETCORE_URLS pins the port,
  # appsettings.Development.json supplies the rest of the config. `env` lets us set the
  # environment variable whose name is held in $envkey. The port-based stop is the reliable
  # kill path, so recording the launcher PID here is just a convenience.
  env "${envkey}=Development" ASPNETCORE_URLS="http://localhost:${port}" \
    nohup dotnet run --project "$project" --no-build >"$logfile" 2>&1 &
  echo $! >> "$PIDFILE"
}

status() {
  printf '\n%-14s %-8s %s\n' "SERVICE" "PORT" "STATUS"
  for entry in "${APPS[@]}"; do
    IFS='|' read -r name _ port _ <<< "$entry"
    local code
    code="$(curl -s -o /dev/null -w '%{http_code}' --max-time 2 "http://localhost:${port}/" 2>/dev/null || true)"
    code="${code:-000}"
    [ "$code" = "000" ] && printf '%-14s %-8s \033[31mdown\033[0m\n' "$name" "$port" \
                        || printf '%-14s %-8s \033[32mup\033[0m (HTTP %s)\n' "$name" "$port" "$code"
  done
  printf '\n'
}

start() {
  stop_apps  # idempotent — free the ports first

  log "Bringing up infra containers…"
  docker compose up -d $INFRA_SERVICES

  log "Building the solution…"
  dotnet build "$ROOT/StayTraining.sln" --verbosity quiet

  : > "$PIDFILE"

  # Auth.API first — everyone else introspects tokens against it.
  start_app "auth.api" "src/EntryPoints/Auth.API" 5100 ASPNETCORE_ENVIRONMENT
  wait_http "http://localhost:5100/health/live" "auth.api"

  start_app "web.api"    "src/EntryPoints/Web.API"    5010 ASPNETCORE_ENVIRONMENT
  start_app "gateway"    "src/EntryPoints/Gateway"    5200 ASPNETCORE_ENVIRONMENT
  start_app "web.blazor" "src/EntryPoints/Web.Blazor" 5002 ASPNETCORE_ENVIRONMENT

  wait_http "http://localhost:5010/health" "web.api"
  wait_http "http://localhost:5200/"       "gateway"
  wait_http "http://localhost:5002/"       "web.blazor"

  status
  cat <<EOF
Stack ready. Open the app at:  http://localhost:5002
Log in via the local dev login → pick "Diego Modesto" (professor) or "Rita Sibele Modesto" (aluna).
Logs: $LOGDIR/*.log     Stop: scripts/run-stack.sh stop
EOF
}

case "${1:-start}" in
  start)   start ;;
  stop)    stop_apps ;;
  restart) stop_apps; start ;;
  status)  status ;;
  down)    stop_apps; log "Stopping infra containers…"; docker compose stop ;;
  *) echo "Usage: $0 {start|stop|restart|status|down}"; exit 1 ;;
esac
