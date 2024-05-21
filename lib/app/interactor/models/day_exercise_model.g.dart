// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayExerciseModel _$DayExerciseModelFromJson(Map<String, dynamic> json) =>
    DayExerciseModel(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$DayExerciseModelToJson(DayExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
    };
