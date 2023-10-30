// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repository _$RepositoryFromJson(Map<String, dynamic> json) => Repository(
      id: json['id'] as String?,
      displayName: json['display_name'] as String?,
      hostOrganization: json['host_organization'] as String?,
      hostOrganizationName: json['host_organization_name'] as String?,
      hostOrganizationLineage:
          (json['host_organization_lineage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$RepositoryToJson(Repository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'host_organization': instance.hostOrganization,
      'host_organization_name': instance.hostOrganizationName,
      'host_organization_lineage': instance.hostOrganizationLineage,
    };
