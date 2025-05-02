// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayExerciseModel _$DayExerciseModelFromJson(Map<String, dynamic> json) =>
    DayExerciseModel(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      series: (json['series'] as List<dynamic>)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayExerciseModelToJson(DayExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'series': instance.series,
    };
