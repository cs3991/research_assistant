// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_funders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaFunders _$MetaFundersFromJson(Map<String, dynamic> json) => MetaFunders(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      funders: (json['results'] as List<dynamic>?)
          ?.map((e) => Funder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaFundersToJson(MetaFunders instance) =>
    <String, dynamic>{
      'meta': instance.meta?.toJson(),
      'results': instance.funders?.map((e) => e.toJson()).toList(),
    };
