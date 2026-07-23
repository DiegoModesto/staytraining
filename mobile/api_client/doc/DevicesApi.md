# staytraining_api.api.DevicesApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**registerDeviceToken**](DevicesApi.md#registerdevicetoken) | **POST** /devices/token | Registrar token de push


# **registerDeviceToken**
> IdResponse registerDeviceToken(registerDeviceTokenRequest)

Registrar token de push

Registra o token de push (Platform: 0=Android, 1=iOS). Retorna **200**. *Autenticado.*

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getDevicesApi();
final RegisterDeviceTokenRequest registerDeviceTokenRequest = ; // RegisterDeviceTokenRequest | 

try {
    final response = api.registerDeviceToken(registerDeviceTokenRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DevicesApi->registerDeviceToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDeviceTokenRequest** | [**RegisterDeviceTokenRequest**](RegisterDeviceTokenRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

