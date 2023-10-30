// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_publishers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaPublishers _$MetaPublishersFromJson(Map<String, dynamic> json) =>
    MetaPublishers(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      publishers: (json['results'] as List<dynamic>?)
          ?.map((e) => Publisher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaPublishersToJson(MetaPublishers instance) =>
    <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'results': instance.publishers?.map((e) => e.toJson()).toList(),
    };
