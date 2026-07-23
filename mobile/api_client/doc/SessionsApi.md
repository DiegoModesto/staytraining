# staytraining_api.api.SessionsApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**completeSession**](SessionsApi.md#completesession) | **POST** /sessions/{id}/complete | Concluir sessão
[**startSession**](SessionsApi.md#startsession) | **POST** /sessions | Iniciar sessão
[**upsertExerciseNote**](SessionsApi.md#upsertexercisenote) | **PUT** /sessions/{id}/notes | Registrar/atualizar nota de execução (upsert)


# **completeSession**
> completeSession(id, completeSessionRequest)

Concluir sessão

**Permissão:** `session.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getSessionsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CompleteSessionRequest completeSessionRequest = ; // CompleteSessionRequest | 

try {
    api.completeSession(id, completeSessionRequest);
} on DioException catch (e) {
    print('Exception when calling SessionsApi->completeSession: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **completeSessionRequest** | [**CompleteSessionRequest**](CompleteSessionRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **startSession**
> IdResponse startSession(startSessionRequest)

Iniciar sessão

Inicia a execução de um treino. **Permissão:** `session.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getSessionsApi();
final StartSessionRequest startSessionRequest = ; // StartSessionRequest | 

try {
    final response = api.startSession(startSessionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SessionsApi->startSession: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startSessionRequest** | [**StartSessionRequest**](StartSessionRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertExerciseNote**
> IdResponse upsertExerciseNote(id, upsertExerciseNoteRequest)

Registrar/atualizar nota de execução (upsert)

Upsert da nota de um exercício na sessão. Retorna **200**. **Permissão:** `note.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getSessionsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpsertExerciseNoteRequest upsertExerciseNoteRequest = ; // UpsertExerciseNoteRequest | 

try {
    final response = api.upsertExerciseNote(id, upsertExerciseNoteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SessionsApi->upsertExerciseNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **upsertExerciseNoteRequest** | [**UpsertExerciseNoteRequest**](UpsertExerciseNoteRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

