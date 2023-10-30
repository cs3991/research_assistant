// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Funder _$FunderFromJson(Map<String, dynamic> json) => Funder(
      alternateTitles: (json['alternate_titles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      citedByCount: json['cited_by_count'] as int?,
      countryCode: json['country_code'] as String?,
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      description: json['description'] as String?,
      displayName: json['display_name'] as String?,
      grantsCount: json['grants_count'] as int?,
      homepageUrl: json['homepage_url'] as String?,
      id: json['id'] as String?,
      ids: json['ids'] == null
          ? null
          : AlexIds.fromJson(json['ids'] as Map<String, dynamic>),
      imageThumbnailUrl: json['image_thumbnail_url'] as String?,
      imageUrl: json['image_url'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      summaryStats: json['summary_stats'] == null
          ? null
          : SummaryStats.fromJson(
              json['summary_stats'] as Map<String, dynamic>),
      updatedDate: json['updated_date'] as String?,
      worksCount: json['works_count'] as int?,
    );

Map<String, dynamic> _$FunderToJson(Funder instance) => <String, dynamic>{
      'alternate_titles': instance.alternateTitles,
      'cited_by_count': instance.citedByCount,
      'country_code': instance.countryCode,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate,
      'description': instance.description,
      'display_name': instance.displayName,
      'grants_count': instance.grantsCount,
      'homepage_url': instance.homepageUrl,
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'image_thumbnail_url': instance.imageThumbnailUrl,
      'image_url': instance.imageUrl,
      'roles': instance.roles?.map((e) => e.toJson()).toList(),
      'summary_stats': instance.summaryStats?.toJson(),
      'updated_date': instance.updatedDate,
      'works_count': instance.worksCount,
    };
