# staytraining_api.api.NotesApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSessionNotes**](NotesApi.md#getsessionnotes) | **GET** /sessions/{id}/notes | Notas de execução da sessão
[**listNotes**](NotesApi.md#listnotes) | **GET** /notes | Listar notas de execução


# **getSessionNotes**
> BuiltList<ExerciseNote> getSessionNotes(id)

Notas de execução da sessão

**Permissão:** `workout.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getNotesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getSessionNotes(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotesApi->getSessionNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BuiltList&lt;ExerciseNote&gt;**](ExerciseNote.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listNotes**
> BuiltList<ExerciseNote> listNotes(studentId, exerciseId)

Listar notas de execução

Filtrável por aluno/exercício. **Permissão:** `report.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getNotesApi();
final String studentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String exerciseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listNotes(studentId, exerciseId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotesApi->listNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studentId** | **String**|  | [optional] 
 **exerciseId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;ExerciseNote&gt;**](ExerciseNote.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

