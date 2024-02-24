import 'package:json_annotation/json_annotation.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';

part 'exercises_model.g.dart';

@JsonSerializable()
class ExercisesModel {
  final int id;
  final String nameMuscle;
  final String nameExercise;
  final List<DayExerciseModel?> days;

  ExercisesModel({
    required this.id,
    required this.nameMuscle,
    required this.nameExercise,
    required this.days,
  });

  factory ExercisesModel.fromJson(Map<String, dynamic> json) =>
      _$ExercisesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesModelToJson(this);

  ExercisesModel copyWith({
    int? id,
    String? nameMuscle,
    String? nameExercise,
    List<DayExerciseModel?>? days,
  }) {
    return ExercisesModel(
      id: id ?? this.id,
      nameMuscle: nameMuscle ?? this.nameMuscle,
      nameExercise: nameExercise ?? this.nameExercise,
      days: days ?? this.days,
    );
  }
}
