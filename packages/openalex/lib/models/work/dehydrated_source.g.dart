// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dehydrated_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DehydratedSource _$DehydratedSourceFromJson(Map<String, dynamic> json) =>
    DehydratedSource(
      displayName: json['display_name'] as String?,
      hostOrganization: json['host_organization'] as String?,
      hostOrganizationLineage:
          (json['host_organization_lineage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      hostOrganizationName: json['host_organization_name'] as String?,
      id: json['id'] as String?,
      isInDoaj: json['is_in_doaj'] as bool?,
      isOa: json['is_oa'] as bool?,
      issn: (json['issn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      issnL: json['issn_l'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DehydratedSourceToJson(DehydratedSource instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'host_organization': instance.hostOrganization,
      'host_organization_lineage': instance.hostOrganizationLineage,
      'host_organization_name': instance.hostOrganizationName,
      'id': instance.id,
      'is_in_doaj': instance.isInDoaj,
      'is_oa': instance.isOa,
      'issn': instance.issn,
      'issn_l': instance.issnL,
      'type': instance.type,
    };
