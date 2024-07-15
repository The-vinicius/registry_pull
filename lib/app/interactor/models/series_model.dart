import 'package:json_annotation/json_annotation.dart';

part 'series_model.g.dart';

@JsonSerializable()
class SeriesModel {
  final int id;
  final int series;
  final int repetitions;

  SeriesModel({
    required this.id,
    required this.series,
    required this.repetitions,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) =>
      _$SeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesModelToJson(this);

  SeriesModel copyWith({
    int? id,
    int? series,
    int? repetitions,
  }) {
    return SeriesModel(
      id: id ?? this.id,
      series: series ?? this.series,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}
