# staytraining_api.api.MuscleGroupsApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createMuscleGroup**](MuscleGroupsApi.md#createmusclegroup) | **POST** /muscle-groups | Criar grupo muscular
[**deleteMuscleGroup**](MuscleGroupsApi.md#deletemusclegroup) | **DELETE** /muscle-groups/{id} | Excluir grupo muscular
[**listMuscleGroups**](MuscleGroupsApi.md#listmusclegroups) | **GET** /muscle-groups | Listar grupos musculares
[**updateMuscleGroup**](MuscleGroupsApi.md#updatemusclegroup) | **PUT** /muscle-groups/{id} | Atualizar grupo muscular


# **createMuscleGroup**
> IdResponse createMuscleGroup(muscleGroupRequest)

Criar grupo muscular

**Permissão:** `muscle.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getMuscleGroupsApi();
final MuscleGroupRequest muscleGroupRequest = ; // MuscleGroupRequest | 

try {
    final response = api.createMuscleGroup(muscleGroupRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MuscleGroupsApi->createMuscleGroup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **muscleGroupRequest** | [**MuscleGroupRequest**](MuscleGroupRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMuscleGroup**
> deleteMuscleGroup(id)

Excluir grupo muscular

Soft-delete. Bloqueado (409) se em uso por exercícios. **Permissão:** `muscle.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getMuscleGroupsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteMuscleGroup(id);
} on DioException catch (e) {
    print('Exception when calling MuscleGroupsApi->deleteMuscleGroup: $e\n');
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

# **listMuscleGroups**
> BuiltList<MuscleGroup> listMuscleGroups()

Listar grupos musculares

Lista os grupos musculares. **Permissão:** `exercise.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getMuscleGroupsApi();

try {
    final response = api.listMuscleGroups();
    print(response);
} on DioException catch (e) {
    print('Exception when calling MuscleGroupsApi->listMuscleGroups: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;MuscleGroup&gt;**](MuscleGroup.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMuscleGroup**
> updateMuscleGroup(id, muscleGroupRequest)

Atualizar grupo muscular

**Permissão:** `muscle.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getMuscleGroupsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MuscleGroupRequest muscleGroupRequest = ; // MuscleGroupRequest | 

try {
    api.updateMuscleGroup(id, muscleGroupRequest);
} on DioException catch (e) {
    print('Exception when calling MuscleGroupsApi->updateMuscleGroup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **muscleGroupRequest** | [**MuscleGroupRequest**](MuscleGroupRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

