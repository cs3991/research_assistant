// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      abbreviatedTitle: json['abbreviated_title'] as String?,
      alternateTitles: (json['alternate_titles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      apcPrices: (json['apc_prices'] as List<dynamic>?)
          ?.map((e) => ApcPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
      apcUsd: json['apc_usd'] as int?,
      citedByCount: json['cited_by_count'] as int?,
      countryCode: json['country_code'] as String?,
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String?,
      displayName: json['display_name'] as String?,
      homepageUrl: json['homepage_url'] as String?,
      hostOrganization: json['host_organization'] as String?,
      hostOrganizationLineage:
          (json['host_organization_lineage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      hostOrganizationName: json['host_organization_name'] as String?,
      id: json['id'] as String?,
      ids: json['ids'] == null
          ? null
          : AlexIds.fromJson(json['ids'] as Map<String, dynamic>),
      isInDoaj: json['is_in_doaj'] as bool?,
      isOa: json['is_oa'] as bool?,
      issn: (json['issn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      issnL: json['issn_l'] as String?,
      societies: (json['societies'] as List<dynamic>?)
          ?.map((e) => Society.fromJson(e as Map<String, dynamic>))
          .toList(),
      summaryStats: json['summary_stats'] == null
          ? null
          : SummaryStats.fromJson(
              json['summary_stats'] as Map<String, dynamic>),
      type: json['type'] as String?,
      updatedDate: json['updated_date'] as String?,
      worksApiUrl: json['works_api_url'] as String?,
      worksCount: json['works_count'] as int?,
      xConcepts: (json['x_concepts'] as List<dynamic>?)
          ?.map((e) => DehydratedConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'abbreviated_title': instance.abbreviatedTitle,
      'alternate_titles': instance.alternateTitles,
      'apc_prices': instance.apcPrices?.map((e) => e.toJson()).toList(),
      'apc_usd': instance.apcUsd,
      'cited_by_count': instance.citedByCount,
      'country_code': instance.countryCode,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate,
      'display_name': instance.displayName,
      'homepage_url': instance.homepageUrl,
      'host_organization': instance.hostOrganization,
      'host_organization_lineage': instance.hostOrganizationLineage,
      'host_organization_name': instance.hostOrganizationName,
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'is_in_doaj': instance.isInDoaj,
      'is_oa': instance.isOa,
      'issn': instance.issn,
      'issn_l': instance.issnL,
      'societies': instance.societies?.map((e) => e.toJson()).toList(),
      'summary_stats': instance.summaryStats?.toJson(),
      'type': instance.type,
      'updated_date': instance.updatedDate,
      'works_api_url': instance.worksApiUrl,
      'works_count': instance.worksCount,
      'x_concepts': instance.xConcepts?.map((e) => e.toJson()).toList(),
    };
