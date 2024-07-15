// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesModel _$SeriesModelFromJson(Map<String, dynamic> json) => SeriesModel(
      id: json['id'] as int,
      series: json['series'] as int,
      repetitions: json['repetitions'] as int,
    );

Map<String, dynamic> _$SeriesModelToJson(SeriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series': instance.series,
      'repetitions': instance.repetitions,
    };
