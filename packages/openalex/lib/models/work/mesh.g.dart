// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeSH _$MeSHFromJson(Map<String, dynamic> json) => MeSH(
      descriptorUi: json['descriptor_id'] as String?,
      descriptorName: json['descriptor_name'] as String?,
      qualifierName: json['qualifier_name'] as String?,
      qualifierUi: json['qualifier_id'] as String?,
      isMajorTopic: json['is_major_topic'] as bool?,
    );

Map<String, dynamic> _$MeSHToJson(MeSH instance) => <String, dynamic>{
      'descriptor_id': instance.descriptorUi,
      'descriptor_name': instance.descriptorName,
      'qualifier_name': instance.qualifierName,
      'qualifier_id': instance.qualifierUi,
      'is_major_topic': instance.isMajorTopic,
    };
