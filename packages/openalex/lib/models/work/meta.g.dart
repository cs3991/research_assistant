// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      count: json['count'] as int?,
      dbResponseTimeMs: json['db_response_time_ms'] as int?,
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'count': instance.count,
      'db_response_time_ms': instance.dbResponseTimeMs,
      'page': instance.page,
      'per_page': instance.perPage,
    };
