# StayTraining

App de treinos de **musculação**, **treino funcional** e **boxe**, com **app mobile (Aluno)** em
Flutter e **backoffice web (Professor)** em Blazor, sobre um backend .NET 10.

---

## Funcionalidades

**Aluno (mobile)**
- Montar treino do zero (exercícios, séries, repetições) e editar (inserir/remover/reordenar).
- Usar treinos **pré-montados** (padrão, não editáveis) — copiar gera um treino próprio editável.
- Cada exercício com **GIF / vídeo do YouTube / vídeo enviado**, músculo afetado e exemplo de uso.
- Escolher em que **dia** fazer cada treino (agenda semanal).
- Executar o treino vendo séries/reps/**descanso sugerido** e comentários do professor.
- **Timer de intervalo** para aeróbicos (ex.: 60s / 30s × 5).
- **Anotações por dia/exercício** (carga, dor, comentário) + nota de execução ao concluir.
- **Relatório semanal** sintetizado; **notificação** de treino pendente há mais de X dias.
- **Offline-first** com sincronização (push de sessões + pull de mudanças).

**Professor (backoffice)**
- Cadastrar e selecionar **alunos**; manter **ficha** (observações privadas + problemas de saúde).
- Catálogo de **exercícios** (CRUD + upload de mídia), **modelos** de treino (incl. padrão).
- Criar/atribuir treinos ao aluno (do zero ou a partir de modelo).
- Comentários por treino/exercício exibidos ao aluno na execução.
- Diferença de papéis **Aluno × Professor** por permissões.

---

## Estrutura

```
StayTraining/
├── Plans/SPEC.md     # especificação do produto + stack
├── backend/          # .NET 10: API, Auth, Worker, CronJobs, Gateway + backoffice Blazor
└── mobile/           # app Flutter (Aluno)
```

## Stack

| Camada | Tecnologia |
|---|---|
| Mobile | Flutter, Riverpod, go_router, dio, sqflite (offline), flutter_appauth, flutter_local_notifications, youtube_player_flutter |
| Backend | .NET 10, ASP.NET Minimal APIs, Clean Architecture + CQRS, FluentValidation, EF Core 10 |
| Banco | PostgreSQL (snake_case, soft-delete, multi-tenant) |
| Auth | OpenIddict (introspection) + permissões/roles |
| Mídia | MinIO (S3-compatível) via `IFileStorage` |
| Backoffice | Blazor Server + MudBlazor (`Web.Blazor`) |
| Jobs/Msg | RabbitMQ (Worker) + Cronos (CronJobs) |
| Push | Firebase Cloud Messaging (FCM) |

## Rodar o backend (dev)

```bash
cd backend
docker compose up -d postgres rabbitmq minio seq
dotnet ef database update --project src/Infra --startup-project src/EntryPoints/Web.API
dotnet run --project src/EntryPoints/Web.API      # + Auth.API, Gateway, Web.Blazor, CronJobs conforme necessário
```

A Web.API fica atrás do Gateway (porta 5200) em `/api/v1/*`. Swagger disponível na Web.API.

## Rodar o app (mobile)

```bash
cd mobile
flutter create .          # gera android/ios (não sobrescreve lib/ nem pubspec)
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5200 \
            --dart-define=AUTH_ISSUER=http://10.0.2.2:5100 \
            --dart-define=AUTH_CLIENT_ID=mobile-app
```

Veja `mobile/README.md` para detalhes (login OIDC/token dev, FCM opcional).

## Dados de seed (mock)

Ao subir a Web.API com `Seed:TenantId` configurado, o `SeedDataHostedService` popula
(idempotente): grupos musculares, catálogo de exercícios, 4 modelos padrão (Costas e Ombro,
Peito e Bíceps, Funcional Full Body, Boxe Iniciante) e **usuários mock**:

| Usuário | Papel | UserId (`sub`) |
|---|---|---|
| **Rita Sibele Modesto** | Aluno | `33333333-3333-3333-3333-333333333333` |
| **Diego Modesto** | Administrador / Professor | `22222222-2222-2222-2222-222222222222` |

Rita já vem com uma observação de saúde e um treino inicial ("Costas e Ombro").
Tenant de seed padrão: `11111111-1111-1111-1111-111111111111`.
Use esses ids como claim `sub` (e `tenant_id`) ao emitir um token de dev.

## Testes & cobertura

```bash
cd backend
dotnet test tests/Application.UnitTests/Application.UnitTests.csproj \
  --collect:"XPlat Code Coverage" --settings coverlet.runsettings
```

- **68 testes** unitários cobrindo handlers e validators (Exercises, Templates, Workouts,
  Execution, Sync, Students, Devices), usando o `ApplicationDbContext` real (EF InMemory).
- Cobertura das camadas de negócio (Application + Domain): **~94%** (meta ≥ 85%).
  A `Infra` (plumbing/migrations) é exercida pelos testes de integração e fica fora do gate unitário.

## Papéis

- **Aluno** — app mobile: treinos, execução com timer, anotações, agenda, relatório, offline+sync.
- **Professor** — backoffice web: alunos, ficha de saúde, catálogo, modelos, criação de treinos.
