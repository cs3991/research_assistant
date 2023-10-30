// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_authors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaAuthors _$MetaAuthorsFromJson(Map<String, dynamic> json) => MetaAuthors(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      authors: (json['results'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaAuthorsToJson(MetaAuthors instance) =>
    <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'results': instance.authors?.map((e) => e.toJson()).toList(),
    };
