// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counts_by_year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountByYear _$CountByYearFromJson(Map<String, dynamic> json) => CountByYear(
      year: json['year'] as int?,
      worksCount: json['works_count'] as int?,
      citedByCount: json['cited_by_count'] as int?,
    );

Map<String, dynamic> _$CountByYearToJson(CountByYear instance) =>
    <String, dynamic>{
      'year': instance.year,
      'works_count': instance.worksCount,
      'cited_by_count': instance.citedByCount,
    };
