# staytraining_api — client Dart gerado

Client **dio + built_value** gerado do `backend/docs/openapi.yaml` com
`openapi-generator` (`dart-dio`, v7.24). Inclui um `*Api` por tag
(`ExercisesApi`, `WorkoutsApi`, `StudentsApi`, `ProfilesApi`, …) e os models tipados.

## Regenerar

```bash
# da raiz do repo
npx @openapitools/openapi-generator-cli generate \
  -i backend/docs/openapi.yaml -g dart-dio -o mobile/api_client \
  --additional-properties=pubName=staytraining_api,pubAuthor=StayTraining
cd mobile/api_client && dart pub get && dart run build_runner build
```

> Os arquivos `*.g.dart` (built_value) **são versionados**, então quem consome só precisa de
> `dart pub get` — sem rodar o build_runner.

## Usar no app (reaproveitando o Dio autenticado)

O app já tem um `Dio` com o interceptor que injeta `Authorization: Bearer <token>`
(`lib/core/api/api_client.dart`). Basta passá-lo ao client gerado — sem duplicar auth:

```dart
// pubspec.yaml do app:
//   staytraining_api:
//     path: api_client

import 'package:staytraining_api/staytraining_api.dart';

// provider (Riverpod), reutilizando o Dio autenticado do app:
final generatedApiProvider = Provider<StaytrainingApi>((ref) {
  final dio = ref.read(apiClientProvider).dio; // Dio com bearer + baseUrl
  return StaytrainingApi(dio: dio); // não recria interceptors; usa os do app
});

// uso:
final api = ref.read(generatedApiProvider);
final res = await api.getExercisesApi().listExercises();
final List<ExerciseListItem> exercises = res.data!.toList();

final me = (await api.getProfilesApi().getMyProfile()).data!;
```

Observações:
- `baseUrl` deve terminar em `/api/v1` (o Dio do app já aponta para o host; ajuste o `BaseOptions.baseUrl`
  para incluir `/api/v1`, ou use `basePathOverride`).
- Enums chegam como inteiros no JSON e são desserializados nos enums built_value do client.
- Este pacote é **opcional/incremental**: o app continua funcionando com o `TrainingApi` manual atual;
  adote o gerado por área quando quiser.
