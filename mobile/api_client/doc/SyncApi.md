# staytraining_api.api.SyncApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**syncPull**](SyncApi.md#syncpull) | **GET** /sync/pull | Pull de mudanças (delta)
[**syncPushSessions**](SyncApi.md#syncpushsessions) | **POST** /sync/sessions | Push de sessões executadas


# **syncPull**
> SyncPullResponse syncPull(since)

Pull de mudanças (delta)

Puxa mudanças desde `since`. Sem `since`, devolve tudo. **Permissão:** `workout.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getSyncApi();
final DateTime since = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.syncPull(since);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SyncApi->syncPull: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **since** | **DateTime**|  | [optional] 

### Return type

[**SyncPullResponse**](SyncPullResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **syncPushSessions**
> SyncPushResult syncPushSessions(syncPushSessionsRequest)

Push de sessões executadas

Envia sessões offline (idempotente por id). **Permissão:** `session.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getSyncApi();
final SyncPushSessionsRequest syncPushSessionsRequest = ; // SyncPushSessionsRequest | 

try {
    final response = api.syncPushSessions(syncPushSessionsRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SyncApi->syncPushSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **syncPushSessionsRequest** | [**SyncPushSessionsRequest**](SyncPushSessionsRequest.md)|  | 

### Return type

[**SyncPushResult**](SyncPushResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

