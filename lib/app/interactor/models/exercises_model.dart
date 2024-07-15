import 'package:json_annotation/json_annotation.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:equatable/equatable.dart';
part 'exercises_model.g.dart';

@JsonSerializable()
class ExercisesModel extends Equatable {
  final int id;
  final String nameMuscle;
  final String nameExercise;

  const ExercisesModel({
    required this.id,
    required this.nameMuscle,
    required this.nameExercise,
  });

  factory ExercisesModel.fromJson(Map<String, dynamic> json) =>
      _$ExercisesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesModelToJson(this);

  ExercisesModel copyWith({
    int? id,
    String? nameMuscle,
    String? nameExercise,
    bool? isExpanded,
    List<DayExerciseModel?>? days,
  }) {
    return ExercisesModel(
      id: id ?? this.id,
      nameMuscle: nameMuscle ?? this.nameMuscle,
      nameExercise: nameExercise ?? this.nameExercise,
    );
  }

  @override
  List<Object?> get props => [id, nameMuscle, nameExercise];
}
