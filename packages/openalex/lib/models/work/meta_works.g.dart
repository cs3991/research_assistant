// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_works.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaWorks _$MetaWorksFromJson(Map<String, dynamic> json) => MetaWorks(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      works: (json['results'] as List<dynamic>?)
          ?.map((e) => Work.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaWorksToJson(MetaWorks instance) => <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'results': instance.works?.map((e) => e.toJson()).toList(),
    };
