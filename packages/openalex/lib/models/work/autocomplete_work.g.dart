// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteWork _$AutocompleteWorkFromJson(Map<String, dynamic> json) =>
    AutocompleteWork(
      id: json['id'] as String?,
      displayName: json['display_name'] as String?,
      hint: json['hint'] as String?,
      citedByCount: json['cited_by_count'] as int?,
      worksCount: json['works_count'] as int?,
      entityType: json['entity_type'] as String?,
      externalId: json['external_id'] as String?,
    );

Map<String, dynamic> _$AutocompleteWorkToJson(AutocompleteWork instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'hint': instance.hint,
      'cited_by_count': instance.citedByCount,
      'works_count': instance.worksCount,
      'entity_type': instance.entityType,
      'external_id': instance.externalId,
    };
