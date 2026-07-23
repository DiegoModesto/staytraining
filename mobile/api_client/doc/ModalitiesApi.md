# staytraining_api.api.ModalitiesApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createModality**](ModalitiesApi.md#createmodality) | **POST** /modalities | Criar modalidade
[**deleteModality**](ModalitiesApi.md#deletemodality) | **DELETE** /modalities/{id} | Excluir modalidade
[**listModalities**](ModalitiesApi.md#listmodalities) | **GET** /modalities | Listar modalidades
[**updateModality**](ModalitiesApi.md#updatemodality) | **PUT** /modalities/{id} | Atualizar modalidade


# **createModality**
> IdResponse createModality(modalityRequest)

Criar modalidade

**Permissão:** `modality.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getModalitiesApi();
final ModalityRequest modalityRequest = ; // ModalityRequest | 

try {
    final response = api.createModality(modalityRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ModalitiesApi->createModality: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **modalityRequest** | [**ModalityRequest**](ModalityRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteModality**
> deleteModality(id)

Excluir modalidade

Soft-delete. Bloqueado (409) se em uso. **Permissão:** `modality.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getModalitiesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteModality(id);
} on DioException catch (e) {
    print('Exception when calling ModalitiesApi->deleteModality: $e\n');
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

# **listModalities**
> BuiltList<Modality> listModalities()

Listar modalidades

**Permissão:** `modality.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getModalitiesApi();

try {
    final response = api.listModalities();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ModalitiesApi->listModalities: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Modality&gt;**](Modality.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateModality**
> updateModality(id, modalityRequest)

Atualizar modalidade

**Permissão:** `modality.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getModalitiesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ModalityRequest modalityRequest = ; // ModalityRequest | 

try {
    api.updateModality(id, modalityRequest);
} on DioException catch (e) {
    print('Exception when calling ModalitiesApi->updateModality: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **modalityRequest** | [**ModalityRequest**](ModalityRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

