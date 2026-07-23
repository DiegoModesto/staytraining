# staytraining_api.api.ScheduleApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getWeekSchedule**](ScheduleApi.md#getweekschedule) | **GET** /schedule/week | Agenda da semana
[**scheduleWorkout**](ScheduleApi.md#scheduleworkout) | **POST** /schedule | Agendar treino


# **getWeekSchedule**
> BuiltList<WeekScheduleItem> getWeekSchedule(weekStart, studentId)

Agenda da semana

**Permissão:** `workout.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getScheduleApi();
final Date weekStart = 2013-10-20; // Date | Início da semana (yyyy-MM-dd)
final String studentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getWeekSchedule(weekStart, studentId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ScheduleApi->getWeekSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **weekStart** | **Date**| Início da semana (yyyy-MM-dd) | 
 **studentId** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;WeekScheduleItem&gt;**](WeekScheduleItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **scheduleWorkout**
> IdResponse scheduleWorkout(scheduleWorkoutRequest)

Agendar treino

**Permissão:** `session.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getScheduleApi();
final ScheduleWorkoutRequest scheduleWorkoutRequest = ; // ScheduleWorkoutRequest | 

try {
    final response = api.scheduleWorkout(scheduleWorkoutRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ScheduleApi->scheduleWorkout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scheduleWorkoutRequest** | [**ScheduleWorkoutRequest**](ScheduleWorkoutRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

