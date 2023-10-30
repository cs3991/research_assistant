// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'x_concept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XConcept _$XConceptFromJson(Map<String, dynamic> json) => XConcept(
      id: json['id'] as String?,
      wikidata: json['wikidata'] as String?,
      displayName: json['display_name'] as String?,
      level: json['level'] as int?,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$XConceptToJson(XConcept instance) => <String, dynamic>{
      'id': instance.id,
      'wikidata': instance.wikidata,
      'display_name': instance.displayName,
      'level': instance.level,
      'score': instance.score,
    };
