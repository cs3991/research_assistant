// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      citedByCount: json['cited_by_count'] as int?,
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      displayName: json['display_name'] as String?,
      displayNameAlternatives:
          (json['display_name_alternatives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      id: json['id'] as String?,
      ids: json['ids'] == null
          ? null
          : AlexIds.fromJson(json['ids'] as Map<String, dynamic>),
      lastKnownInstitution: json['last_known_institution'] == null
          ? null
          : DehydratedInstitution.fromJson(
              json['last_known_institution'] as Map<String, dynamic>),
      orcid: json['orcid'] as String?,
      summaryStats: json['summary_stats'] == null
          ? null
          : SummaryStats.fromJson(
              json['summary_stats'] as Map<String, dynamic>),
      updatedDate: json['updated_date'] as String?,
      worksApiUrl: json['works_api_url'] as String?,
      worksCount: json['works_count'] as int?,
      xConcepts: (json['x_concepts'] as List<dynamic>?)
          ?.map((e) => DehydratedConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'cited_by_count': instance.citedByCount,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate,
      'display_name': instance.displayName,
      'display_name_alternatives': instance.displayNameAlternatives,
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'last_known_institution': instance.lastKnownInstitution?.toJson(),
      'orcid': instance.orcid,
      'summary_stats': instance.summaryStats?.toJson(),
      'updated_date': instance.updatedDate,
      'works_api_url': instance.worksApiUrl,
      'works_count': instance.worksCount,
      'x_concepts': instance.xConcepts?.map((e) => e.toJson()).toList(),
    };
