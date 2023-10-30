// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Concept _$ConceptFromJson(Map<String, dynamic> json) => Concept(
      ancestors: (json['ancestors'] as List<dynamic>?)
          ?.map((e) => DehydratedConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      citedByCount: json['cited_by_count'] as int?,
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      description: json['description'] as String?,
      displayName: json['display_name'] as String?,
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
      level: json['level'] as int?,
      relatedConcepts: (json['related_concepts'] as List<dynamic>?)
          ?.map((e) => DehydratedConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      summaryStats: json['summary_stats'] == null
          ? null
          : SummaryStats.fromJson(
              json['summary_stats'] as Map<String, dynamic>),
      updatedDate: json['updated_date'] as String?,
      wikidata: json['wikidata'] as String?,
      worksApiUrl: json['works_api_url'] as String?,
      worksCount: json['works_count'] as int?,
    );

Map<String, dynamic> _$ConceptToJson(Concept instance) => <String, dynamic>{
      'ancestors': instance.ancestors?.map((e) => e.toJson()).toList(),
      'cited_by_count': instance.citedByCount,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate,
      'description': instance.description,
      'display_name': instance.displayName,
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'image_thumbnail_url': instance.imageThumbnailUrl,
      'image_url': instance.imageUrl,
      'international': instance.international?.toJson(),
      'level': instance.level,
      'related_concepts':
          instance.relatedConcepts?.map((e) => e.toJson()).toList(),
      'summary_stats': instance.summaryStats?.toJson(),
      'updated_date': instance.updatedDate,
      'wikidata': instance.wikidata,
      'works_api_url': instance.worksApiUrl,
      'works_count': instance.worksCount,
    };
