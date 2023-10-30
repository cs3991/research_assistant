// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_concepts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaConcepts _$MetaConceptsFromJson(Map<String, dynamic> json) => MetaConcepts(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      concepts: (json['results'] as List<dynamic>?)
          ?.map((e) => Concept.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaConceptsToJson(MetaConcepts instance) =>
    <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'results': instance.concepts?.map((e) => e.toJson()).toList(),
    };
