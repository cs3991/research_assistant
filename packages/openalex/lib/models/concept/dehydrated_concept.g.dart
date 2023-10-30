// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dehydrated_concept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DehydratedConcept _$DehydratedConceptFromJson(Map<String, dynamic> json) =>
    DehydratedConcept(
      displayName: json['display_name'] as String?,
      id: json['id'] as String?,
      level: json['level'] as int?,
      wikidata: json['wikidata'] as String?,
    );

Map<String, dynamic> _$DehydratedConceptToJson(DehydratedConcept instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'id': instance.id,
      'level': instance.level,
      'wikidata': instance.wikidata,
    };
