# StayTraining — Especificação do Produto

> App de treinos de **musculação**, **treino funcional** e **boxe**, com app mobile para o Aluno
> e backoffice web para o Professor. Documento vivo — atualizar conforme a implementação evolui.

---

## 1. Visão

Plataforma para montar, executar e acompanhar treinos. O **Aluno** treina pelo celular/tablet
(com suporte offline), registra anotações por exercício e recebe lembretes. O **Professor** gerencia
alunos, monta treinos (do zero ou a partir de modelos), mantém a ficha de saúde e acompanha a evolução
pelo backoffice web.

## 2. Personas

- **Aluno** — acessa apenas os próprios treinos e o catálogo de exercícios; executa treinos, insere
  anotações (carga, dor, comentários) e vê observações/comentários do Professor. Não edita catálogo nem modelos.
- **Professor** — seleciona alunos, cria/edita treinos e exercícios, define modelos padrão, mantém a
  **ficha de observação** (comentários privados sobre o aluno e problemas de saúde) e vê relatórios.

## 3. Requisitos funcionais

### Aluno
1. Montar treino particular: escolher exercícios, séries e repetições.
2. Usar treinos pré-montados (padrão). O padrão **não é editável**; ao editar, gera-se uma **cópia** com os mesmos exercícios.
3. Editar o próprio treino: inserir e remover exercícios.
4. Ao selecionar exercício, ver **GIF ou vídeo (YouTube/enviado)**, **localização do músculo** afetado e **exemplo de uso**.
5. Anotações por exercício no treino do dia (ex.: treino "Costas e Ombro" com 3 de costas + 4 de ombro;
   cada exercício aceita comentário de carga, dor em local específico, etc.).
6. Escolher em que dia realizar cada treino (segunda = Costas e Ombro; terça = Peito e Bíceps; …).
7. Notificação de **treino pendente há mais de X dias**.
8. **Relatório semanal** sintetizado dos exercícios executados.
9. Ao escolher um treino, ver todos os exercícios com **séries, repetições e tempo de descanso sugerido**.
10. Durante a execução, inserir anotações **segmentadas por dia/exercício** (apanhado histórico).
11. Para exercícios aeróbicos, **timer de intervalo** (ex.: polichinelo 60s ativo / 30s descanso × 5 séries),
    com comentário e **nota de execução** ao finalizar.

### Professor / Backoffice
12. Sistema **backoffice** para gerenciar treinos; os dispositivos recebem apenas os treinos pertinentes,
    podendo **baixar atualizações** de treinos, comentários de quem montou e observações de saúde.
13. Criar treinos para pessoas cadastradas — a partir de **modelos prontos** ou **do zero**.
14. Inserir **comentários e observações** por treino e por exercício, exibidos ao Aluno durante a execução.
15. **Aluno x Professor**: Aluno só vê treinos/exercícios e insere comentários; Professor seleciona aluno,
    insere comentários que ficam **só na ficha de observação**, registra **problemas de saúde**, cria treinos,
    escolhe exercícios, etc.

### Não-funcionais
- Responsivo em **Android, iOS e tablets**.
- **Offline-first** no mobile com sincronização.
- Multi-tenant (academia/professor) e autorização por permissões.

---

## 4. Stack

| Camada | Tecnologia |
|---|---|
| **Mobile (Aluno)** | Flutter (Dart), Riverpod, go_router, Drift (SQLite offline), dio, firebase_messaging, flutter_local_notifications, youtube_player_flutter, video_player, cached_network_image, flutter_adaptive_scaffold |
| **Backend/API** | .NET 10, ASP.NET Minimal APIs, Clean Architecture + CQRS custom (Scrutor), FluentValidation, EF Core 10 |
| **Banco** | PostgreSQL (snake_case, soft-delete, multi-tenant por TenantId) |
| **Auth** | OpenIddict (introspection), contexto de Auth dedicado, autorização por permissões/roles |
| **Storage de mídia** | MinIO (self-hosted, S3-compatível) via abstração `IFileStorage` |
| **Backoffice (Professor)** | Blazor Server + MudBlazor (entrypoint `Web.Blazor`) |
| **Mensageria/Jobs** | RabbitMQ (Worker) + Cronos (CronJobs) |
| **Push** | Firebase Cloud Messaging (FCM) |
| **Observabilidade** | OpenTelemetry + Serilog (Seq) |
| **Base** | Fork do scaffold `BaseProjectScaffold` |

---

## 5. Arquitetura do repositório

```
StayTraining/
├── Plans/SPEC.md          # este documento
├── backend/               # fork do scaffold (.NET) — API, Auth, Worker, CronJobs, Gateway, Web.Blazor
├── mobile/                # app Flutter (Aluno)
└── README.md
```

O **backoffice do Professor** é o entrypoint `backend/src/EntryPoints/Web.Blazor`.

---

## 6. Modelo de domínio

**Catálogo/Referência**
- `MuscleGroup` — grupo muscular (reference/seed).
- `Exercise` — nome, descrição, categoria (Musculação/Funcional/Boxe/Aeróbico), músculo primário + secundários,
  exemplo de uso, defaults (séries/reps/descanso), `IsAerobic`, config de intervalo padrão, e mídias
  (`ExerciseMedia`: Gif | UploadedVideo | YoutubeUrl | MuscleImage).

**Treinos**
- `WorkoutTemplate` (+`TemplateItem`) — modelo pré-montado; `IsSystemDefault` (não editável, só copiável).
- `Workout` (+`WorkoutItem`) — treino do Aluno (cópia de modelo ou do zero); editável; `SectionLabel` agrupa
  exercícios (ex.: Costas/Ombro); `ProfessorComment` por item (read-only na execução).

**Agenda/Execução**
- `WorkoutSchedule` — treino atribuído a um dia.
- `WorkoutSession` — execução (início/fim, nota).
- `ExerciseNote` — anotação por dia/exercício (carga, dor, comentário, séries realizadas).

**Pessoas/Saúde**
- `StudentProfile`, `HealthObservation` (ficha), `DeviceToken` (FCM).

**Auth** — Roles `Aluno`/`Professor`; permissões `exercise.*`, `template.*`, `workout.*`, `student.*`,
`health.*`, `session.write`, `note.write`, `report.read`.

---

## 7. API (principais casos de uso)

- **Exercises**: CRUD, List paginado, UploadMedia.
- **Templates**: CRUD, CopyTemplateToWorkout.
- **Workouts**: CreateFromScratch/FromTemplate, Update, Add/Remove/ReorderItems, GetById, List.
- **Schedule**: ScheduleWorkoutForDay, GetWeek.
- **Sessions**: Start, UpsertExerciseNote, Complete; GetSessionNotes, GetAllNotes.
- **Students/Health** (Professor): Register/List/Get, AssignWorkout, Upsert/GetHealthObservations.
- **Reports**: GetWeeklyReport.
- **Sync**: PullChanges(since), PushSessions. **Devices**: RegisterDeviceToken.

---

## 8. Sincronização offline

- Mobile lê tudo do Drift (SQLite). `SyncService` faz `PullChanges` (workouts/exercises/templates/schedule/health
  alterados desde `since`, incluindo soft-deletes via `UpdatedAt`/`IsDeleted`) e `PushSessions` (sessões/anotações
  criadas offline). Estratégia de conflito: last-write-wins nas anotações do próprio Aluno.

## 9. Notificações

- **Servidor**: CronJob diário detecta pendência (> X dias sem sessão do treino agendado) → RabbitMQ → Worker →
  FCM push. CronJob semanal gera relatório e envia push do resumo.
- **App**: `flutter_local_notifications` calcula pendência localmente (offline); `firebase_messaging` recebe pushes.

---

## 10. Roadmap por fases

1. Fork do scaffold + SPEC.
2. Auth: permissões + roles Aluno/Professor.
3. Domínio+API núcleo: MuscleGroup, Exercise (+MinIO), Templates, Workouts.
4. Execução: Schedule, Session, Notes, Relatório semanal.
5. Sync + Notificações (FCM/CronJobs).
6. Backoffice Web.Blazor.
7. App Flutter (base → treinos → execução/timer → agenda/notificações → sync → tablet).
8. Seed de treinos padrão (musculação/funcional/boxe).

---

## 11. Verificação

- Backend: `docker compose up -d postgres rabbitmq minio seq` + `dotnet ef database update` +
  `dotnet run --project src/EntryPoints/Web.API`; Swagger + `dotnet test`.
- Mobile: `flutter run` em Android/iOS/tablet; testar montar/copiar treino, execução com timer,
  anotações por dia/exercício, offline + sync, notificações.
- Backoffice: `dotnet run --project src/EntryPoints/Web.Blazor`.
