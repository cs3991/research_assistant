// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryStats _$SummaryStatsFromJson(Map<String, dynamic> json) => SummaryStats(
      twoYearMeanCitedness: (json['2yr_mean_citedness'] as num?)?.toDouble(),
      hIndex: json['h_index'] as int?,
      i10Index: json['i10_index'] as int?,
    );

Map<String, dynamic> _$SummaryStatsToJson(SummaryStats instance) =>
    <String, dynamic>{
      '2yr_mean_citedness': instance.twoYearMeanCitedness,
      'h_index': instance.hIndex,
      'i10_index': instance.i10Index,
    };
