import 'package:json_annotation/json_annotation.dart';
import 'package:registry_pull/app/interactor/models/day_exercise_model.dart';
import 'package:equatable/equatable.dart';
part 'exercises_model.g.dart';

@JsonSerializable()
class ExercisesModel extends Equatable {
  final String id;
  final String nameMuscle;
  final String nameExercise;
  final bool isExpanded;
  final List<DayExerciseModel?> days;

  const ExercisesModel({
    required this.id,
    required this.nameMuscle,
    required this.nameExercise,
    this.isExpanded = false,
    required this.days,
  });

  factory ExercisesModel.fromJson(Map<String, dynamic> json) =>
      _$ExercisesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesModelToJson(this);

  ExercisesModel copyWith({
    String? id,
    String? nameMuscle,
    String? nameExercise,
    bool? isExpanded,
    List<DayExerciseModel?>? days,
  }) {
    return ExercisesModel(
      id: id ?? this.id,
      nameMuscle: nameMuscle ?? this.nameMuscle,
      nameExercise: nameExercise ?? this.nameExercise,
      isExpanded: isExpanded ?? this.isExpanded,
      days: days ?? this.days,
    );
  }

  @override
  List<Object?> get props => [id, nameMuscle, nameExercise, isExpanded, days];
}
