// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      isAccepted: json['is_accepted'] as bool?,
      isOa: json['is_oa'] as bool?,
      isPublished: json['is_published'] as bool?,
      landingPageUrl: json['landing_page_url'] as String?,
      license: json['license'] as String?,
      source: json['source'] == null
          ? null
          : DehydratedSource.fromJson(json['source'] as Map<String, dynamic>),
      pdfUrl: json['pdf_url'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'is_accepted': instance.isAccepted,
      'is_oa': instance.isOa,
      'is_published': instance.isPublished,
      'landing_page_url': instance.landingPageUrl,
      'license': instance.license,
      'source': instance.source?.toJson(),
      'pdf_url': instance.pdfUrl,
      'version': instance.version,
    };
