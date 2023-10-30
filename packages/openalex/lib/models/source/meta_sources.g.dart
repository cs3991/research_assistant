// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_sources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaSources _$MetaSourcesFromJson(Map<String, dynamic> json) => MetaSources(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      sources: (json['results'] as List<dynamic>?)
          ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaSourcesToJson(MetaSources instance) =>
    <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'results': instance.sources?.map((e) => e.toJson()).toList(),
    };
