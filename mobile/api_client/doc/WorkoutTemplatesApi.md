# staytraining_api.api.WorkoutTemplatesApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createWorkoutTemplate**](WorkoutTemplatesApi.md#createworkouttemplate) | **POST** /workout-templates | Criar modelo
[**getWorkoutTemplateById**](WorkoutTemplatesApi.md#getworkouttemplatebyid) | **GET** /workout-templates/{id} | Obter modelo
[**listWorkoutTemplates**](WorkoutTemplatesApi.md#listworkouttemplates) | **GET** /workout-templates | Listar modelos


# **createWorkoutTemplate**
> IdResponse createWorkoutTemplate(createWorkoutTemplateRequest)

Criar modelo

**Permissão:** `template.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutTemplatesApi();
final CreateWorkoutTemplateRequest createWorkoutTemplateRequest = ; // CreateWorkoutTemplateRequest | 

try {
    final response = api.createWorkoutTemplate(createWorkoutTemplateRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutTemplatesApi->createWorkoutTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createWorkoutTemplateRequest** | [**CreateWorkoutTemplateRequest**](CreateWorkoutTemplateRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWorkoutTemplateById**
> WorkoutTemplate getWorkoutTemplateById(id)

Obter modelo

**Permissão:** `template.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutTemplatesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getWorkoutTemplateById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutTemplatesApi->getWorkoutTemplateById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**WorkoutTemplate**](WorkoutTemplate.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWorkoutTemplates**
> BuiltList<WorkoutTemplateListItem> listWorkoutTemplates(onlySystemDefaults)

Listar modelos

**Permissão:** `template.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getWorkoutTemplatesApi();
final bool onlySystemDefaults = true; // bool | 

try {
    final response = api.listWorkoutTemplates(onlySystemDefaults);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WorkoutTemplatesApi->listWorkoutTemplates: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **onlySystemDefaults** | **bool**|  | [optional] 

### Return type

[**BuiltList&lt;WorkoutTemplateListItem&gt;**](WorkoutTemplateListItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

