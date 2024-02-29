// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisesModel _$ExercisesModelFromJson(Map<String, dynamic> json) =>
    ExercisesModel(
      id: json['id'] as String,
      nameMuscle: json['nameMuscle'] as String,
      nameExercise: json['nameExercise'] as String,
      isExpanded: json['isExpanded'] as bool,
      days: (json['days'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : DayExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExercisesModelToJson(ExercisesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameMuscle': instance.nameMuscle,
      'nameExercise': instance.nameExercise,
      'isExpanded': instance.isExpanded,
      'days': instance.days,
    };
