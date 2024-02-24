import 'package:json_annotation/json_annotation.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

part 'day_exercise_model.g.dart';

@JsonSerializable()
class DayExerciseModel {
  final int id;
  final DateTime date;
  final List<SeriesModel> series;

  DayExerciseModel({
    required this.id,
    required this.date,
    required this.series,
  });

  factory DayExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$DayExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayExerciseModelToJson(this);

  DayExerciseModel copyWith({
    int? id,
    DateTime? date,
    List<SeriesModel>? series,
  }) {
    return DayExerciseModel(
      id: id ?? this.id,
      date: date ?? this.date,
      series: series ?? this.series,
    );
  }
}
