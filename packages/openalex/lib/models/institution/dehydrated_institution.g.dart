// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dehydrated_institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DehydratedInstitution _$DehydratedInstitutionFromJson(
        Map<String, dynamic> json) =>
    DehydratedInstitution(
      countryCode: json['country_code'] as String?,
      displayName: json['display_name'] as String?,
      id: json['id'] as String?,
      ror: json['ror'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DehydratedInstitutionToJson(
        DehydratedInstitution instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'display_name': instance.displayName,
      'id': instance.id,
      'ror': instance.ror,
      'type': instance.type,
    };
