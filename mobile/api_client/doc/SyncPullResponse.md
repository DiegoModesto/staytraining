# staytraining_api.model.SyncPullResponse

## Load the model package
```dart
import 'package:staytraining_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**serverTime** | [**DateTime**](DateTime.md) |  | [optional] 
**muscleGroups** | [**BuiltList&lt;MuscleGroup&gt;**](MuscleGroup.md) |  | [optional] 
**deletedMuscleGroupIds** | **BuiltList&lt;String&gt;** |  | [optional] 
**exercises** | [**BuiltList&lt;Exercise&gt;**](Exercise.md) |  | [optional] 
**deletedExerciseIds** | **BuiltList&lt;String&gt;** |  | [optional] 
**templates** | [**BuiltList&lt;WorkoutTemplate&gt;**](WorkoutTemplate.md) |  | [optional] 
**deletedTemplateIds** | **BuiltList&lt;String&gt;** |  | [optional] 
**workouts** | [**BuiltList&lt;Workout&gt;**](Workout.md) |  | [optional] 
**deletedWorkoutIds** | **BuiltList&lt;String&gt;** |  | [optional] 
**schedules** | [**BuiltList&lt;ScheduleSyncItem&gt;**](ScheduleSyncItem.md) |  | [optional] 
**deletedScheduleIds** | **BuiltList&lt;String&gt;** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


