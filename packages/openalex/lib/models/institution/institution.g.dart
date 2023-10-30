// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) => Institution(
      associatedInstitutions: (json['associated_institutions']
              as List<dynamic>?)
          ?.map(
              (e) => DehydratedInstitution.fromJson(e as Map<String, dynamic>))
          .toList(),
      citedByCount: json['cited_by_count'] as int?,
      countryCode: json['country_code'] as String?,
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      displayName: json['display_name'] as String?,
      displayNameAcronyms: (json['display_name_acronyms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      displayNameAlternatives:
          (json['display_name_alternatives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      geo: json['geo'] == null
          ? null
          : Geo.fromJson(json['geo'] as Map<String, dynamic>),
      homepageUrl: json['homepage_url'] as String?,
      id: json['id'] as String?,
      ids: json['ids'] == null
          ? null
          : AlexIds.fromJson(json['ids'] as Map<String, dynamic>),
      imageThumbnailUrl: json['image_thumbnail_url'] as String?,
      imageUrl: json['image_url'] as String?,
      international: json['international'] == null
          ? null
          : International.fromJson(
              json['international'] as Map<String, dynamic>),
      repositories: (json['repositories'] as List<dynamic>?)
          ?.map((e) => Repository.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      ror: json['ror'] as String?,
      summaryStats: json['summary_stats'] == null
          ? null
          : SummaryStats.fromJson(
              json['summary_stats'] as Map<String, dynamic>),
      type: json['type'] as String?,
      updatedDate: json['updated_date'] as String?,
      worksApiUrl: json['works_api_url'] as String?,
      worksCount: json['works_count'] as int?,
      xConcepts: (json['x_concepts'] as List<dynamic>?)
          ?.map((e) => XConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstitutionToJson(Institution instance) =>
    <String, dynamic>{
      'associated_institutions':
          instance.associatedInstitutions?.map((e) => e.toJson()).toList(),
      'cited_by_count': instance.citedByCount,
      'country_code': instance.countryCode,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate,
      'display_name': instance.displayName,
      'display_name_acronyms': instance.displayNameAcronyms,
      'display_name_alternatives': instance.displayNameAlternatives,
      'geo': instance.geo?.toJson(),
      'homepage_url': instance.homepageUrl,
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'image_thumbnail_url': instance.imageThumbnailUrl,
      'image_url': instance.imageUrl,
      'international': instance.international?.toJson(),
      'repositories': instance.repositories?.map((e) => e.toJson()).toList(),
      'roles': instance.roles?.map((e) => e.toJson()).toList(),
      'ror': instance.ror,
      'summary_stats': instance.summaryStats?.toJson(),
      'type': instance.type,
      'updated_date': instance.updatedDate,
      'works_api_url': instance.worksApiUrl,
      'works_count': instance.worksCount,
      'x_concepts': instance.xConcepts?.map((e) => e.toJson()).toList(),
    };
