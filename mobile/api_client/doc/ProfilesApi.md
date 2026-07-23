# staytraining_api.api.ProfilesApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addMyApportment**](ProfilesApi.md#addmyapportment) | **POST** /profiles/me/apportments | Adicionar apontamento (aluno)
[**getMyProfile**](ProfilesApi.md#getmyprofile) | **GET** /profiles/me | Meu perfil
[**removeMyApportment**](ProfilesApi.md#removemyapportment) | **DELETE** /profiles/me/apportments/{id} | Remover apontamento (aluno)
[**updateMyProfile**](ProfilesApi.md#updatemyprofile) | **PUT** /profiles/me | Atualizar meu perfil
[**uploadMyProfilePhoto**](ProfilesApi.md#uploadmyprofilephoto) | **POST** /profiles/me/photo | Enviar foto do perfil


# **addMyApportment**
> IdResponse addMyApportment(addApportmentRequest)

Adicionar apontamento (aluno)

O aluno adiciona um apontamento de saúde na própria ficha. *Autenticado.*

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getProfilesApi();
final AddApportmentRequest addApportmentRequest = ; // AddApportmentRequest | 

try {
    final response = api.addMyApportment(addApportmentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProfilesApi->addMyApportment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addApportmentRequest** | [**AddApportmentRequest**](AddApportmentRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyProfile**
> Profile getMyProfile()

Meu perfil

Perfil do usuário atual. `isStudent` indica se é ficha de aluno. *Autenticado.*

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getProfilesApi();

try {
    final response = api.getMyProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProfilesApi->getMyProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Profile**](Profile.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeMyApportment**
> removeMyApportment(id)

Remover apontamento (aluno)

O aluno remove um apontamento da própria ficha. *Autenticado.*

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getProfilesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.removeMyApportment(id);
} on DioException catch (e) {
    print('Exception when calling ProfilesApi->removeMyApportment: $e\n');
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

# **updateMyProfile**
> updateMyProfile(updateProfileRequest)

Atualizar meu perfil

Atualiza os dados do próprio perfil. *Autenticado.*

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getProfilesApi();
final UpdateProfileRequest updateProfileRequest = ; // UpdateProfileRequest | 

try {
    api.updateMyProfile(updateProfileRequest);
} on DioException catch (e) {
    print('Exception when calling ProfilesApi->updateMyProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProfileRequest** | [**UpdateProfileRequest**](UpdateProfileRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadMyProfilePhoto**
> UploadMyProfilePhoto200Response uploadMyProfilePhoto(file)

Enviar foto do perfil

Multipart, imagem ≤ 2 MB. Guarda no storage e devolve URL pré-assinada. *Autenticado.*

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getProfilesApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.uploadMyProfilePhoto(file);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProfilesApi->uploadMyProfilePhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**UploadMyProfilePhoto200Response**](UploadMyProfilePhoto200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

