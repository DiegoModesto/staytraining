# StayTraining

App de treinos de **musculação**, **treino funcional**, **boxe** e **aeróbico**, com **app mobile
(Aluno)** em Flutter e **backoffice web (Professor)** em Blazor, sobre um backend .NET 10.

> O app é **exclusivo do aluno**. O professor também pode logar no app (vê a **visão de aluno**,
> acessando os próprios treinos), mas gerencia alunos/treinos/agenda pelo **backoffice**.

---

## Funcionalidades

**Aluno (mobile)**
- **Login por e-mail + senha** (OpenIddict password grant), sem navegador.
- **Navegação responsiva**: bottom nav no celular, navigation rail no tablet. **Tema claro/escuro**
  configurável (segue o sistema por padrão) no design system **"VOLT"**.
- **Meus treinos**: montar treino do zero (exercícios, séries, reps, descanso) e editar — cada aluno
  só cria/edita os **próprios** treinos.
- Cada exercício com **GIF / vídeo do YouTube / vídeo enviado**, músculo afetado e exemplo de uso.
- **Agenda semanal montada pelo professor**: treino pendente abre a execução; treino **concluído**
  fica **somente visualização**.
- Executar o treino vendo séries/reps/**descanso sugerido** e comentários do professor; **timer de
  intervalo** para aeróbicos; anotações (carga, dor, comentário) **salvas ao concluir** + nota de execução.
- **Perguntar ao professor** sobre um treino ou exercício e acompanhar as respostas ("Minhas perguntas").
- **Relatório semanal**; lembrete local de treino pendente; **offline-first** com sincronização.

**Professor (backoffice)**
- Cadastrar/selecionar **alunos**; manter **ficha** (observações privadas + problemas de saúde).
- Catálogo de **exercícios** (CRUD + upload de mídia) e **modelos** de treino (incl. padrão).
- Criar/atribuir treinos ao aluno (do zero ou a partir de modelo) e montar a **agenda semanal**.
- **Responder perguntas** dos alunos (fila de abertas com contador — a "notificação no sistema").
- Comentários por treino/exercício exibidos ao aluno na execução.
- Diferença de papéis **Aluno × Professor** por permissões.

---

## Estrutura

```
StayTraining/
├── Plans/SPEC.md     # especificação do produto + stack
├── artifacts/        # catálogos de treino/exercícios (referência) e TODOs (GIFs)
├── scripts/dev.sh    # sobe backend (docker) + roda o app
├── backend/          # .NET 10: API, Auth, Worker, CronJobs, Gateway + backoffice Blazor
└── mobile/           # app Flutter (Aluno) — android/ios versionados (NÃO rodar `flutter create .`)
```

## Stack

| Camada | Tecnologia |
|---|---|
| Mobile | Flutter, Riverpod, go_router, dio, sqflite (offline), google_fonts (VOLT), flutter_local_notifications, youtube_player_flutter |
| Backend | .NET 10, ASP.NET Minimal APIs, Clean Architecture + CQRS, FluentValidation, EF Core 10 |
| Banco | PostgreSQL (snake_case, soft-delete, multi-tenant) |
| Auth | OpenIddict — **password grant** (app) + Authorization Code/PKCE (backoffice) + introspection; permissões/roles |
| Mídia | MinIO (S3-compatível) via `IFileStorage` |
| Backoffice | Blazor Server + MudBlazor (`Web.Blazor`) |
| Jobs/Msg | RabbitMQ (Worker) + Cronos (CronJobs) |
| Push | Firebase Cloud Messaging (FCM) — opcional, fiação pronta |

## Rodar tudo (dev) — mais simples

```bash
scripts/dev.sh all           # infra + migrations + backend (docker)
scripts/dev.sh mobile ios    # ou: scripts/dev.sh mobile android
scripts/dev.sh stop          # derruba os containers
```

URLs: Gateway `:5200` · Web.API `:5010` · Auth.API `:5100` · Backoffice `:5002` · Seq `:5341` ·
MinIO `:9001`. O app aponta pro Gateway `:5200` e Auth `:5100`.

> **Não rode `flutter create .`** — as pastas `mobile/android` e `mobile/ios` são versionadas e
> carregam config essencial (redirect scheme do OIDC, cleartext/ATS de dev). Use `flutter pub get`.

## Login (dev)

Login no app é **e-mail + senha**. Usuários mock seedados (senha `@123mudar`):

| Usuário | Papel | E-mail | UserId (`sub`) |
|---|---|---|---|
| **Rita Sibele** | Aluno | `ritasouzamodesto@gmail.com` | `33333333-3333-3333-3333-333333333333` |
| **Diego Sanches** | Professor / Admin | `diegosanches89@gmail.com` | `22222222-2222-2222-2222-222222222222` |

Tenant de seed: `11111111-1111-1111-1111-111111111111`. O backoffice usa OIDC (Authorization Code
+ PKCE); em dev sem Microsoft Entra, a página `/dev-login` do Auth.API faz o stand-in.

## Dados de seed (mock)

`SeedDataHostedService` (idempotente, quando `Seed:TenantId` está configurado) popula grupos
musculares, catálogo de exercícios, modelos padrão (Costas e Ombro, Peito e Bíceps, Funcional Full
Body, Boxe Iniciante), os usuários mock e uma **semana completa da Rita**: treinos atribuídos,
agenda com **concluídos (com sessões + notas) e pendentes**, e **perguntas ao professor** (uma
respondida, uma aberta) — para toda a navegação do app ter dados.

## Testes

```bash
cd backend && dotnet test StayTraining.sln     # unit + arquitetura + integração (Testcontainers)
cd mobile  && flutter test
```

- **Backend: ~347 testes** — Domain/Application/Auth unit, arquitetura (NetArchTest), Web.API
  (WebApplicationFactory + EF InMemory), Auth.API/Gateway (Testcontainers Postgres/Redis + WireMock).
- **Mobile: ~39 testes** (models, API tipada, auth/refresh, push, builder, responsivo).

## Papéis

- **Aluno** — app mobile: treinos próprios, execução com timer, anotações, agenda (só-leitura),
  perguntas ao professor, relatório, offline+sync.
- **Professor** — backoffice web: alunos, ficha, catálogo, modelos, criação/atribuição de treinos,
  agenda do aluno, respostas às perguntas. No app, vê a visão de aluno com os próprios treinos.
