// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearWork _$YearWorkFromJson(Map<String, dynamic> json) => $checkedCreate(
      'YearWork',
      json,
      ($checkedConvert) {
        final val = YearWork(
          year: $checkedConvert('year', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'citedByCount': 'cited_by_count'},
    );

Year _$YearFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Year',
      json,
      ($checkedConvert) {
        final val = Year(
          year: $checkedConvert('year', (v) => v as int),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count'
      },
    );
