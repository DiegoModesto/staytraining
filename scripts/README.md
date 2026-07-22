# Scripts de desenvolvimento

`scripts/dev.sh` orquestra backend (docker) e app (Flutter).

```bash
scripts/dev.sh infra     # só a infraestrutura (Postgres, Auth-DB, Redis, RabbitMQ, MinIO, Seq)
scripts/dev.sh migrate   # aplica as migrations do EF (Application + Auth)
scripts/dev.sh backend   # sobe todos os serviços .NET via docker compose (build)
scripts/dev.sh all       # infra + migrate + backend (stack completa)
scripts/dev.sh mobile ios          # flutter run no simulador iOS (aponta p/ localhost:5200)
scripts/dev.sh mobile android      # flutter run no emulador Android (aponta p/ 10.0.2.2:5200)
scripts/dev.sh mobile ios <id>     # escolher um device específico
scripts/dev.sh status    # containers + devices Flutter
scripts/dev.sh stop      # docker compose down
```

## Dois modos de trabalho

### 1) Rodar tudo (sem debugar) — mais simples
```bash
scripts/dev.sh all         # backend completo em containers
scripts/dev.sh mobile ios  # (ou android)
```
URLs: Gateway `:5200` · Web.API `:5010` · Auth `:5100` · Backoffice `:5002` · Seq `:5341` · MinIO console `:9001`.

### 2) Debugar no VSCode — recomendado para desenvolvimento
1. Abra o arquivo **`StayTraining.code-workspace`** no VSCode (File ▸ Open Workspace from File).
   Instale as extensões recomendadas (C# Dev Kit, Flutter, Docker).
2. Suba a infra e migre: `scripts/dev.sh infra && scripts/dev.sh migrate`
   (ou use as tasks **infra (docker)** / **migrate (EF)** no VSCode).
3. **F5** → escolha o compound:
   - **🔧 Backend (Auth + API + Gateway)** — depura os 3 serviços com breakpoints.
   - **🖥️ Backend + Backoffice** — inclui o Web.Blazor.
   - **🚀 Full stack (Backend + Flutter iOS)** — sobe o backend e o app.
4. Para o app isolado: **📱 Flutter (Android)** ou **📱 Flutter (iOS)** (com um emulador aberto).

Portas em modo debug (local `dotnet`): Auth `:5100`, Web.API `:5078`, Gateway `:5200`, Blazor `:5275`.
O Gateway é configurado (via env no launch) para rotear para a Web.API/Auth locais.

## Login no app

- **OIDC**: precisa do cliente OpenIddict `mobile-app` (public/PKCE) cadastrado no Auth.API
  com redirect `com.staytraining.app://oauth` e o usuário com papel **Aluno** (ex.: Rita).
- **Dev**: na tela de login use "Usar token (dev)" e cole um Bearer token cujo `sub` seja o
  UserId da Rita (`33333333-…`) e `tenant_id` = `11111111-…`, com as permissões de Aluno.

## Pré-requisitos

- Docker, .NET 10 SDK, `dotnet-ef` (`dotnet tool install --global dotnet-ef`), Flutter 3.44+.
- Emulador iOS/Android configurado (`flutter emulators`).
