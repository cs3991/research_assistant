// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publisher _$PublisherFromJson(Map<String, dynamic> json) => Publisher(
      alternateTitles: (json['alternate_titles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      citedByCount: json['cited_by_count'] as int?,
      countryCodes: (json['country_codes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      displayName: json['display_name'] as String?,
      hierarchyLevel: json['hierarchy_level'] as int?,
      id: json['id'] as String?,
      ids: json['ids'] == null
          ? null
          : AlexIds.fromJson(json['ids'] as Map<String, dynamic>),
      imageThumbnailUrl: json['image_thumbnail_url'] as String?,
      imageUrl: json['image_url'] as String?,
      lineage:
          (json['lineage'] as List<dynamic>?)?.map((e) => e as String).toList(),
      parentPublisher: json['parent_publisher'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourcesApiUrl: json['sources_api_url'] as String?,
      summaryStats: json['summary_stats'] == null
          ? null
          : SummaryStats.fromJson(
              json['summary_stats'] as Map<String, dynamic>),
      updatedDate: json['updated_date'] as String?,
      worksCount: json['works_count'] as int?,
    );

Map<String, dynamic> _$PublisherToJson(Publisher instance) => <String, dynamic>{
      'alternate_titles': instance.alternateTitles,
      'cited_by_count': instance.citedByCount,
      'country_codes': instance.countryCodes,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate,
      'display_name': instance.displayName,
      'hierarchy_level': instance.hierarchyLevel,
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'image_thumbnail_url': instance.imageThumbnailUrl,
      'image_url': instance.imageUrl,
      'lineage': instance.lineage,
      'parent_publisher': instance.parentPublisher,
      'roles': instance.roles?.map((e) => e.toJson()).toList(),
      'sources_api_url': instance.sourcesApiUrl,
      'summary_stats': instance.summaryStats?.toJson(),
      'updated_date': instance.updatedDate,
      'works_count': instance.worksCount,
    };
