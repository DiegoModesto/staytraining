# staytraining_api.api.ExercisesApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addExerciseYoutubeMedia**](ExercisesApi.md#addexerciseyoutubemedia) | **POST** /exercises/{id}/media/youtube | Anexar link do YouTube
[**createExercise**](ExercisesApi.md#createexercise) | **POST** /exercises | Criar exercício
[**getExerciseById**](ExercisesApi.md#getexercisebyid) | **GET** /exercises/{id} | Obter exercício
[**listExercises**](ExercisesApi.md#listexercises) | **GET** /exercises | Listar exercícios
[**uploadExerciseMedia**](ExercisesApi.md#uploadexercisemedia) | **POST** /exercises/{id}/media | Enviar mídia (upload)


# **addExerciseYoutubeMedia**
> IdResponse addExerciseYoutubeMedia(id, addExerciseYoutubeMediaRequest)

Anexar link do YouTube

Anexa um link do YouTube como mídia. **Permissão:** `exercise.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getExercisesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AddExerciseYoutubeMediaRequest addExerciseYoutubeMediaRequest = ; // AddExerciseYoutubeMediaRequest | 

try {
    final response = api.addExerciseYoutubeMedia(id, addExerciseYoutubeMediaRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ExercisesApi->addExerciseYoutubeMedia: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **addExerciseYoutubeMediaRequest** | [**AddExerciseYoutubeMediaRequest**](AddExerciseYoutubeMediaRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createExercise**
> IdResponse createExercise(createExerciseRequest)

Criar exercício

Cria um exercício. Modalidade e músculo primário são obrigatórios. **Permissão:** `exercise.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getExercisesApi();
final CreateExerciseRequest createExerciseRequest = ; // CreateExerciseRequest | 

try {
    final response = api.createExercise(createExerciseRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ExercisesApi->createExercise: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createExerciseRequest** | [**CreateExerciseRequest**](CreateExerciseRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExerciseById**
> Exercise getExerciseById(id)

Obter exercício

Detalhe do exercício, com músculos, prescrição e mídias. **Permissão:** `exercise.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getExercisesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getExerciseById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ExercisesApi->getExerciseById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Exercise**](Exercise.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listExercises**
> BuiltList<ExerciseListItem> listExercises(modalityId)

Listar exercícios

Lista exercícios do tenant, opcionalmente por modalidade. **Permissão:** `exercise.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getExercisesApi();
final String modalityId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listExercises(modalityId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ExercisesApi->listExercises: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **modalityId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;ExerciseListItem&gt;**](ExerciseListItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadExerciseMedia**
> UploadExerciseMedia201Response uploadExerciseMedia(id, file, kind)

Enviar mídia (upload)

Envia uma mídia (GIF/vídeo/imagem) via multipart; vai para o object storage. **Permissão:** `exercise.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getExercisesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 
final ExerciseMediaKind kind = ; // ExerciseMediaKind | 

try {
    final response = api.uploadExerciseMedia(id, file, kind);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ExercisesApi->uploadExerciseMedia: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 
 **kind** | [**ExerciseMediaKind**](ExerciseMediaKind.md)|  | [optional] 

### Return type

[**UploadExerciseMedia201Response**](UploadExerciseMedia201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

