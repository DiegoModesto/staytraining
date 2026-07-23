# staytraining_api.api.WorkoutsApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addWorkoutItem**](WorkoutsApi.md#addworkoutitem) | **POST** /workouts/{id}/items | Adicionar exercício ao treino
[**createWorkout**](WorkoutsApi.md#createworkout) | **POST** /workouts | Criar treino
[**createWorkoutFromTemplate**](WorkoutsApi.md#createworkoutfromtemplate) | **POST** /workouts/from-template | Criar treino de um modelo
[**deleteWorkout**](WorkoutsApi.md#deleteworkout) | **DELETE** /workouts/{id} | Excluir treino
[**getWorkoutById**](WorkoutsApi.md#getworkoutbyid) | **GET** /workouts/{id} | Obter treino
[**listWorkouts**](WorkoutsApi.md#listworkouts) | **GET** /workouts | Listar treinos
[**removeWorkoutItem**](WorkoutsApi.md#removeworkoutitem) | **DELETE** /workouts/{id}/items/{itemId} | Remover exercício do treino
[**renameWorkout**](WorkoutsApi.md#renameworkout) | **PUT** /workouts/{id}/name | Renomear treino
[**reorderWorkoutItems**](WorkoutsApi.md#reorderworkoutitems) | **PUT** /workouts/{id}/items/order | Reordenar itens


# **addWorkoutItem**
> IdResponse addWorkoutItem(id, workoutItemInput)

Adicionar exercício ao treino

Corpo = item de prescrição. **Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final WorkoutItemInput workoutItemInput = ; // WorkoutItemInput | 

try {
    final response = api.addWorkoutItem(id, workoutItemInput);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->addWorkoutItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **workoutItemInput** | [**WorkoutItemInput**](WorkoutItemInput.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createWorkout**
> IdResponse createWorkout(createWorkoutRequest)

Criar treino

Cria um treino do zero para um aluno. **Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final CreateWorkoutRequest createWorkoutRequest = ; // CreateWorkoutRequest | 

try {
    final response = api.createWorkout(createWorkoutRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->createWorkout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createWorkoutRequest** | [**CreateWorkoutRequest**](CreateWorkoutRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createWorkoutFromTemplate**
> IdResponse createWorkoutFromTemplate(createWorkoutFromTemplateRequest)

Criar treino de um modelo

**Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final CreateWorkoutFromTemplateRequest createWorkoutFromTemplateRequest = ; // CreateWorkoutFromTemplateRequest | 

try {
    final response = api.createWorkoutFromTemplate(createWorkoutFromTemplateRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->createWorkoutFromTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createWorkoutFromTemplateRequest** | [**CreateWorkoutFromTemplateRequest**](CreateWorkoutFromTemplateRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteWorkout**
> deleteWorkout(id)

Excluir treino

Soft-delete. **Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteWorkout(id);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->deleteWorkout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWorkoutById**
> Workout getWorkoutById(id)

Obter treino

Detalhe com itens ordenados. **Permissão:** `workout.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getWorkoutById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->getWorkoutById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Workout**](Workout.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWorkouts**
> BuiltList<WorkoutListItem> listWorkouts(ownerStudentId)

Listar treinos

**Permissão:** `workout.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String ownerStudentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listWorkouts(ownerStudentId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->listWorkouts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ownerStudentId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;WorkoutListItem&gt;**](WorkoutListItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeWorkoutItem**
> removeWorkoutItem(id, itemId)

Remover exercício do treino

**Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String itemId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.removeWorkoutItem(id, itemId);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->removeWorkoutItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **itemId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **renameWorkout**
> renameWorkout(id, nameRequest)

Renomear treino

**Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final NameRequest nameRequest = ; // NameRequest | 

try {
    api.renameWorkout(id, nameRequest);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->renameWorkout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **nameRequest** | [**NameRequest**](NameRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reorderWorkoutItems**
> reorderWorkoutItems(id, reorderWorkoutItemsRequest)

Reordenar itens

**Permissão:** `workout.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ReorderWorkoutItemsRequest reorderWorkoutItemsRequest = ; // ReorderWorkoutItemsRequest | 

try {
    api.reorderWorkoutItems(id, reorderWorkoutItemsRequest);
} on DioException catch (e) {
    print('Exception when calling WorkoutsApi->reorderWorkoutItems: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **reorderWorkoutItemsRequest** | [**ReorderWorkoutItemsRequest**](ReorderWorkoutItemsRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

