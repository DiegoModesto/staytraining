# StayTraining — App do Aluno (Flutter)

App mobile (Android/iOS/tablet) para o Aluno: ver treinos, executar com timer de intervalo,
anotar carga/dor/comentários por exercício, agenda semanal, relatório e uso offline com sync.

## Stack

- **Flutter** + **Riverpod** (providers manuais — sem codegen), **go_router**.
- **dio** (HTTP), **sqflite** (cache/fila offline — SQL manual, sem codegen).
- **flutter_appauth** (login OIDC no Auth.API/OpenIddict) + **flutter_secure_storage**.
- **youtube_player_flutter** / **cached_network_image** / **video_player** (mídia dos exercícios).
- **flutter_local_notifications** (lembrete offline de treino pendente).

> Decisões pragmáticas para rodar só com `flutter pub get` (sem etapa de build_runner):
> Riverpod/JSON/DB são todos manuais. **FCM push é opcional** (veja abaixo) porque exige
> arquivos de configuração de plataforma.

## Como rodar

1. Instale o Flutter SDK (3.24+). Confirme com `flutter doctor`.
2. Gere os arquivos de plataforma (esta pasta contém apenas `lib/` e `pubspec.yaml`):
   ```bash
   cd mobile
   flutter create .        # cria android/ ios/ etc. sem sobrescrever lib/ e pubspec
   flutter pub get
   ```
3. Suba o backend (na pasta `../backend`): `docker compose up -d postgres rabbitmq minio seq`
   e `dotnet run --project src/EntryPoints/Web.API` (+ Gateway/Auth.API conforme necessário).
4. Rode o app apontando para o seu backend:
   ```bash
   flutter run \
     --dart-define=API_BASE_URL=http://10.0.2.2:5200 \
     --dart-define=AUTH_ISSUER=http://10.0.2.2:5100 \
     --dart-define=AUTH_CLIENT_ID=mobile-app \
     --dart-define=AUTH_REDIRECT_URI=com.staytraining.app://oauth
   ```
   `10.0.2.2` é o host visto pelo emulador Android. Em iOS use `http://localhost:...`.

### Login

- **OIDC**: requer um cliente OpenIddict `mobile-app` (public/PKCE) cadastrado no Auth.API com o
  redirect `com.staytraining.app://oauth`, e o esquema registrado no `AndroidManifest`/`Info.plist`
  (o `flutter_appauth` documenta como). O usuário precisa ter o papel **Aluno**.
- **Dev**: a tela de login tem "Usar token (dev)" para colar um Bearer token e testar rápido
  (o token precisa carregar `tenant_id` e as permissões de Aluno).

## Estrutura

```
lib/
├── main.dart
├── core/
│   ├── config/app_config.dart        # dart-defines (URLs, client id)
│   ├── auth/                         # AuthService (OIDC/token) + AuthController
│   ├── api/                          # ApiClient (dio) + TrainingApi (endpoints)
│   ├── db/local_store.dart           # sqflite: cache + fila de sessões offline
│   ├── sync/sync_service.dart        # push (sessões offline) + pull (deltas)
│   ├── notifications/                # lembretes locais
│   ├── router/app_router.dart        # go_router (+ redirect por auth)
│   ├── di/providers.dart             # providers Riverpod
│   └── util/                         # datas, guid
├── models/models.dart                # DTOs (JSON manual)
└── features/
    ├── auth/login_screen.dart
    ├── home/home_screen.dart          # agenda da semana + navegação (responsivo tablet)
    ├── workouts/                      # lista + detalhe (séries/reps/descanso, comentário do professor)
    ├── exercises/exercise_detail_screen.dart   # GIF/YouTube/vídeo + músculo + exemplo
    ├── execution/                     # sessão + timer de intervalo + anotações por exercício
    ├── notes/notes_screen.dart        # apanhado por dia/exercício
    └── reports/weekly_report_screen.dart
```

## Offline & sync

- Sessões concluídas sem rede vão para a fila `pending_sessions` (sqflite) e são enviadas por
  `SyncService.pushPending()` no próximo sync (idempotente no servidor).
- `SyncService.pull()` busca deltas (`/sync/pull?since=`) e guarda o watermark `serverTime`.
- O `HomeScreen` dispara `syncNow()` ao abrir e no botão de sincronizar.

## FCM push (opcional — não incluído por padrão)

O servidor já envia push (pendência/relatório) via FCM. **A fiação de registro do token já está pronta**
(`PushRegistrationService`), atrás da flag `PUSH_ENABLED` e de um `PushTokenProvider` plugável — hoje um
no-op. Para receber no app:

1. Adicione `firebase_core` e `firebase_messaging` ao `pubspec.yaml`.
2. Configure o projeto Firebase (`google-services.json` / `GoogleService-Info.plist`).
3. Implemente `PushTokenProvider` usando `FirebaseMessaging.instance.getToken()` e injete-o no
   `pushRegistrationServiceProvider` (`lib/core/di/providers.dart`).
4. Rode com `--dart-define=PUSH_ENABLED=true`.

O restante já funciona: ao autenticar, o app chama `registerDeviceToken` (endpoint `/api/v1/devices/token`,
`platform`: Android=0, iOS=1), só re-registrando quando o token muda; ao sair, o cache é resetado.

Sem nada disso, os **lembretes locais** (treino pendente) continuam funcionando offline.

## Status

Estrutura completa e idiomática. **Não foi compilada nesta máquina** (Flutter não instalado no
ambiente de geração). Rode `flutter analyze` após `flutter create . && flutter pub get` e ajuste
versões de pacotes se necessário.
