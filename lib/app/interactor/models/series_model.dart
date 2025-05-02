import 'package:json_annotation/json_annotation.dart';

part 'series_model.g.dart';

@JsonSerializable()
class SeriesModel {
  final int series;
  final int repetitions;

  SeriesModel({
    required this.series,
    required this.repetitions,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) =>
      _$SeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesModelToJson(this);

  SeriesModel copyWith({
    int? series,
    int? repetitions,
  }) {
    return SeriesModel(
      series: series ?? this.series,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}