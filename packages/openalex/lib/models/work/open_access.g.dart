// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAccess _$OpenAccessFromJson(Map<String, dynamic> json) => OpenAccess(
      anyRepositoryHasFulltext: json['any_repository_has_fulltext'] as bool?,
      oaStatus: json['oa_status'] as String?,
      oaUrl: json['oa_url'] as String?,
    );

Map<String, dynamic> _$OpenAccessToJson(OpenAccess instance) =>
    <String, dynamic>{
      'any_repository_has_fulltext': instance.anyRepositoryHasFulltext,
      'oa_status': instance.oaStatus,
      'oa_url': instance.oaUrl,
    };
