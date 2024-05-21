// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisesModel _$ExercisesModelFromJson(Map<String, dynamic> json) =>
    ExercisesModel(
      id: json['id'] as int,
      nameMuscle: json['nameMuscle'] as String,
      nameExercise: json['nameExercise'] as String,
    );

Map<String, dynamic> _$ExercisesModelToJson(ExercisesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameMuscle': instance.nameMuscle,
      'nameExercise': instance.nameExercise,
    };
