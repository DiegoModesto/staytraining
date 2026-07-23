# staytraining_api.api.StudentsApi

## Load the API package
```dart
import 'package:staytraining_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addStudentApportment**](StudentsApi.md#addstudentapportment) | **POST** /students/{id}/apportments | Adicionar apontamento (admin, auditado)
[**addStudentNote**](StudentsApi.md#addstudentnote) | **POST** /students/{id}/notes | Adicionar anotação
[**getStudentById**](StudentsApi.md#getstudentbyid) | **GET** /students/{id} | Obter ficha do aluno
[**listStudentEditLogs**](StudentsApi.md#liststudenteditlogs) | **GET** /students/{id}/edit-logs | Histórico de edições da ficha
[**listStudentNotes**](StudentsApi.md#liststudentnotes) | **GET** /students/{id}/notes | Listar anotações do aluno
[**listStudents**](StudentsApi.md#liststudents) | **GET** /students | Listar alunos
[**registerStudent**](StudentsApi.md#registerstudent) | **POST** /students | Cadastrar aluno
[**removeStudentApportment**](StudentsApi.md#removestudentapportment) | **DELETE** /students/{id}/apportments/{apportmentId} | Remover apontamento (admin, auditado)
[**updateStudentFicha**](StudentsApi.md#updatestudentficha) | **PUT** /students/{id}/ficha | Editar ficha (admin, auditado)


# **addStudentApportment**
> IdResponse addStudentApportment(id, addApportmentRequest)

Adicionar apontamento (admin, auditado)

**Permissão:** `studentficha.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AddApportmentRequest addApportmentRequest = ; // AddApportmentRequest | 

try {
    final response = api.addStudentApportment(id, addApportmentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->addStudentApportment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **addApportmentRequest** | [**AddApportmentRequest**](AddApportmentRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addStudentNote**
> IdResponse addStudentNote(id, addStudentNoteRequest)

Adicionar anotação

Anotação do professor (nunca visível ao aluno). Com `workoutId`, fica vinculada a um treino. **Permissão:** `health.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AddStudentNoteRequest addStudentNoteRequest = ; // AddStudentNoteRequest | 

try {
    final response = api.addStudentNote(id, addStudentNoteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->addStudentNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **addStudentNoteRequest** | [**AddStudentNoteRequest**](AddStudentNoteRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStudentById**
> StudentDetail getStudentById(id)

Obter ficha do aluno

Dados pessoais, foto e apontamentos de saúde. **Permissão:** `student.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getStudentById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->getStudentById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**StudentDetail**](StudentDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listStudentEditLogs**
> BuiltList<StudentEditLog> listStudentEditLogs(id)

Histórico de edições da ficha

**Permissão:** `studentficha.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listStudentEditLogs(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->listStudentEditLogs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BuiltList&lt;StudentEditLog&gt;**](StudentEditLog.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listStudentNotes**
> BuiltList<StudentNote> listStudentNotes(id)

Listar anotações do aluno

Anotações do professor (gerais e por treino). **Permissão:** `student.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listStudentNotes(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->listStudentNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BuiltList&lt;StudentNote&gt;**](StudentNote.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listStudents**
> BuiltList<StudentListItem> listStudents()

Listar alunos

**Permissão:** `student.read`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();

try {
    final response = api.listStudents();
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->listStudents: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;StudentListItem&gt;**](StudentListItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerStudent**
> IdResponse registerStudent(registerStudentRequest)

Cadastrar aluno

**Permissão:** `student.manage`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final RegisterStudentRequest registerStudentRequest = ; // RegisterStudentRequest | 

try {
    final response = api.registerStudent(registerStudentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->registerStudent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerStudentRequest** | [**RegisterStudentRequest**](RegisterStudentRequest.md)|  | 

### Return type

[**IdResponse**](IdResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeStudentApportment**
> removeStudentApportment(id, apportmentId)

Remover apontamento (admin, auditado)

**Permissão:** `studentficha.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String apportmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.removeStudentApportment(id, apportmentId);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->removeStudentApportment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **apportmentId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateStudentFicha**
> updateStudentFicha(id, updateStudentFichaRequest)

Editar ficha (admin, auditado)

Admin edita os dados da ficha; a edição é registrada em edit-logs. **Permissão:** `studentficha.write`.

### Example
```dart
import 'package:staytraining_api/api.dart';

final api = StaytrainingApi().getStudentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateStudentFichaRequest updateStudentFichaRequest = ; // UpdateStudentFichaRequest | 

try {
    api.updateStudentFicha(id, updateStudentFichaRequest);
} on DioException catch (e) {
    print('Exception when calling StudentsApi->updateStudentFicha: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateStudentFichaRequest** | [**UpdateStudentFichaRequest**](UpdateStudentFichaRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/problem+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

