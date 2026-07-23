# staytraining_api.api.HealthCatalogApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createBodyPart**](HealthCatalogApi.md#createbodypart) | **POST** /health-catalog/body-parts | Criar parte do corpo
[**createProblemType**](HealthCatalogApi.md#createproblemtype) | **POST** /health-catalog/problem-types | Criar tipo de problema
[**deleteBodyPart**](HealthCatalogApi.md#deletebodypart) | **DELETE** /health-catalog/body-parts/{id} | Excluir parte do corpo
[**deleteProblemType**](HealthCatalogApi.md#deleteproblemtype) | **DELETE** /health-catalog/problem-types/{id} | Excluir tipo de problema
[**getHealthCatalog**](HealthCatalogApi.md#gethealthcatalog) | **GET** /health-catalog | Listar catálogo de saúde
[**updateBodyPart**](HealthCatalogApi.md#updatebodypart) | **PUT** /health-catalog/body-parts/{id} | Renomear parte do corpo
[**updateProblemType**](HealthCatalogApi.md#updateproblemtype) | **PUT** /health-catalog/problem-types/{id} | Renomear tipo de problema


# **createBodyPart**
> IdResponse createBodyPart(nameRequest)

Criar parte do corpo

**Permissão:** `healthcatalog.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();
final NameRequest nameRequest = ; // NameRequest | 

try {
    final response = api.createBodyPart(nameRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->createBodyPart: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **nameRequest** | [**NameRequest**](NameRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createProblemType**
> IdResponse createProblemType(createProblemTypeRequest)

Criar tipo de problema

**Permissão:** `healthcatalog.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();
final CreateProblemTypeRequest createProblemTypeRequest = ; // CreateProblemTypeRequest | 

try {
    final response = api.createProblemType(createProblemTypeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->createProblemType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProblemTypeRequest** | [**CreateProblemTypeRequest**](CreateProblemTypeRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBodyPart**
> deleteBodyPart(id)

Excluir parte do corpo

Bloqueado (409) se houver apontamentos. **Permissão:** `healthcatalog.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteBodyPart(id);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->deleteBodyPart: $e\n');
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

# **deleteProblemType**
> deleteProblemType(id)

Excluir tipo de problema

Bloqueado (409) se referenciado por apontamentos. **Permissão:** `healthcatalog.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteProblemType(id);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->deleteProblemType: $e\n');
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

# **getHealthCatalog**
> BuiltList<BodyPart> getHealthCatalog()

Listar catálogo de saúde

Partes do corpo com seus tipos de problema. **Permissão:** `healthcatalog.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();

try {
    final response = api.getHealthCatalog();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->getHealthCatalog: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;BodyPart&gt;**](BodyPart.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBodyPart**
> updateBodyPart(id, nameRequest)

Renomear parte do corpo

**Permissão:** `healthcatalog.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final NameRequest nameRequest = ; // NameRequest | 

try {
    api.updateBodyPart(id, nameRequest);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->updateBodyPart: $e\n');
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

# **updateProblemType**
> updateProblemType(id, nameRequest)

Renomear tipo de problema

**Permissão:** `healthcatalog.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getHealthCatalogApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final NameRequest nameRequest = ; // NameRequest | 

try {
    api.updateProblemType(id, nameRequest);
} on DioException catch (e) {
    print('Exception when calling HealthCatalogApi->updateProblemType: $e\n');
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

