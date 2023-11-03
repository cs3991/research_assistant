// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryStat _$SummaryStatFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SummaryStat',
      json,
      ($checkedConvert) {
        final val = SummaryStat(
          twoYearMeanCitedness: $checkedConvert('two_year_mean_citedness', (v) => (v as num).toDouble()),
          hIndex: $checkedConvert('h_index', (v) => v as int),
          i10Index: $checkedConvert('i10_index', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'twoYearMeanCitedness': 'two_year_mean_citedness',
        'hIndex': 'h_index',
        'i10Index': 'i10_index'
      },
    );

Society _$SocietyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Society',
      json,
      ($checkedConvert) {
        final val = Society(
          url: $checkedConvert('url', (v) => v as String),
          organization: $checkedConvert('organization', (v) => v as String),
        );
        return val;
      },
    );

SourceDehydrated _$SourceDehydratedFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SourceDehydrated',
      json,
      ($checkedConvert) {
        final val = SourceDehydrated(
          id: $checkedConvert('id', (v) => v as String?),
          displayName: $checkedConvert('display_name', (v) => v as String),
          linkingIssn: $checkedConvert('issn_l', (v) => v as String?),
          issn: $checkedConvert('issn', (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          hostOrganization: $checkedConvert('host_organization', (v) => v as String?),
          hostOrganizationLineage: $checkedConvert(
              'host_organization_lineage', (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          HostOrganizationName: $checkedConvert('host_organization_name', (v) => v as String?),
          isInDoaj: $checkedConvert('is_in_doaj', (v) => v as bool),
          isOa: $checkedConvert('is_oa', (v) => v as bool),
          type: $checkedConvert('type', (v) => $enumDecode(_$SourceTypeEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayName': 'display_name',
        'linkingIssn': 'issn_l',
        'hostOrganization': 'host_organization',
        'hostOrganizationLineage': 'host_organization_lineage',
        'HostOrganizationName': 'host_organization_name',
        'isInDoaj': 'is_in_doaj',
        'isOa': 'is_oa'
      },
    );

const _$SourceTypeEnumMap = {
  SourceType.journal: 'journal',
  SourceType.repository: 'repository',
  SourceType.conference: 'conference',
  SourceType.ebookPlatform: 'ebook platform',
  SourceType.bookSeries: 'book series',
};

Source _$SourceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Source',
      json,
      ($checkedConvert) {
        final val = Source(
          id: $checkedConvert('id', (v) => v as String?),
          displayName: $checkedConvert('display_name', (v) => v as String),
          linkingIssn: $checkedConvert('issn_l', (v) => v as String?),
          issn: $checkedConvert('issn', (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          hostOrganization: $checkedConvert('host_organization', (v) => v as String?),
          hostOrganizationLineage: $checkedConvert(
              'host_organization_lineage', (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          HostOrganizationName: $checkedConvert('host_organization_name', (v) => v as String?),
          isInDoaj: $checkedConvert('is_in_doaj', (v) => v as bool),
          isOa: $checkedConvert('is_oa', (v) => v as bool),
          type: $checkedConvert('type', (v) => $enumDecode(_$SourceTypeEnumMap, v)),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          homepageUrl: $checkedConvert('homepage_url', (v) => v as String),
          countsByYear: $checkedConvert('counts_by_year',
              (v) => (v as List<dynamic>).map((e) => Year.fromJson(e as Map<String, dynamic>)).toList()),
          worksApiUrl: $checkedConvert('works_api_url', (v) => v as String),
          updatedDate: $checkedConvert('updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert('created_date', (v) => DateTime.parse(v as String)),
          apcPrices: $checkedConvert('apc_prices', (v) => Apc.fromJson(v as Map<String, dynamic>)),
          apcUsd: $checkedConvert('apc_usd', (v) => v as int),
          abbreviatedTitle: $checkedConvert('abbreviated_title', (v) => v as String?),
          alternateTitles: $checkedConvert(
              'alternate_titles', (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          countryCode: $checkedConvert('country_code', (v) => v as String?),
          societies: $checkedConvert('societies',
              (v) => (v as List<dynamic>?)?.map((e) => Society.fromJson(e as Map<String, dynamic>)).toList()),
          summaryStats: $checkedConvert(
              'summary_stats',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => SummaryStat.fromJson(e as Map<String, dynamic>))
                  .toList()),
          magId: $checkedConvert(
            'mag',
            (v) => v as String?,
            readValue: Source._readId,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayName': 'display_name',
        'linkingIssn': 'issn_l',
        'hostOrganization': 'host_organization',
        'hostOrganizationLineage': 'host_organization_lineage',
        'HostOrganizationName': 'host_organization_name',
        'isInDoaj': 'is_in_doaj',
        'isOa': 'is_oa',
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count',
        'homepageUrl': 'homepage_url',
        'countsByYear': 'counts_by_year',
        'worksApiUrl': 'works_api_url',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'apcPrices': 'apc_prices',
        'apcUsd': 'apc_usd',
        'abbreviatedTitle': 'abbreviated_title',
        'alternateTitles': 'alternate_titles',
        'countryCode': 'country_code',
        'summaryStats': 'summary_stats',
        'magId': 'mag'
      },
    );
