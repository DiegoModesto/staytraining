# staytraining_api.api.ReportsApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getWeeklyReport**](ReportsApi.md#getweeklyreport) | **GET** /reports/weekly | Relatório semanal


# **getWeeklyReport**
> WeeklyReport getWeeklyReport(weekStart, studentId)

Relatório semanal

Resumo da semana: sessões, médias e por exercício. **Permissão:** `report.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getReportsApi();
final Date weekStart = 2013-10-20; // Date | 
final String studentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getWeeklyReport(weekStart, studentId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReportsApi->getWeeklyReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **weekStart** | **Date**|  | 
 **studentId** | **String**|  | [optional] 

### Return type

[**WeeklyReport**](WeeklyReport.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

