import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'source.g.dart';

// String: The type of source, which will be one of: journal, repository, conference, ebook platform, or book series.
enum SourceType {
  journal,
  repository,
  conference,
  @JsonValue('ebook platform')
  ebookPlatform,
  @JsonValue('book series')
  bookSeries,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SummaryStat {
  final double twoYearMeanCitedness;
  final int hIndex;
  final int i10Index;

  SummaryStat({
    required this.twoYearMeanCitedness,
    required this.hIndex,
    required this.i10Index,
  });

  factory SummaryStat.fromJson(Map<String, dynamic> json) => _$SummaryStatFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Society {
  final String url;
  final String organization;

  Society({
    required this.url,
    required this.organization,
  });

  factory Society.fromJson(Map<String, dynamic> json) => _$SocietyFromJson(json);
}

abstract class SourceBase {
  SourceBase({
    required this.hostOrganization,
    required this.hostOrganizationLineage,
    required this.HostOrganizationName,
    required this.isInDoaj,
    required this.isOa,
    required this.id,
    required this.linkingIssn,
    required this.issn,
    required this.displayName,
    required this.type,
  });

  // todo: change this when fixed. Nullable because of a bug in the API
  //  (https://docs.openalex.org/about-the-data/work#alternate_host_venues)
  final String? id;
  final String displayName;
  @JsonKey(name: 'issn_l')
  final String? linkingIssn;
  final List<String>? issn;
  final String? hostOrganization;
  final List<String> hostOrganizationLineage;
  final String? HostOrganizationName;
  final bool isInDoaj;
  final bool isOa;
  final SourceType type;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SourceDehydrated extends SourceBase {
  SourceDehydrated({
    required super.id,
    required super.displayName,
    required super.linkingIssn,
    required super.issn,
    required super.hostOrganization,
    required super.hostOrganizationLineage,
    required super.HostOrganizationName,
    required super.isInDoaj,
    required super.isOa,
    required super.type,
  });

  factory SourceDehydrated.fromJson(Map<String, dynamic> json) => _$SourceDehydratedFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Source extends SourceBase {
  @JsonKey(readValue: _readId, name: 'mag')
  final String? magId;
  final int worksCount;
  final int citedByCount;
  final String homepageUrl;
  final Apc apcPrices;
  final int apcUsd;
  final String? abbreviatedTitle;
  final List<String>? alternateTitles;
  final String? countryCode;
  final List<Society>? societies;
  final List<SummaryStat>? summaryStats;
  final List<Year> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  Source({
    required super.id,
    required super.displayName,
    required super.linkingIssn,
    required super.issn,
    required super.hostOrganization,
    required super.hostOrganizationLineage,
    required super.HostOrganizationName,
    required super.isInDoaj,
    required super.isOa,
    required super.type,
    required this.worksCount,
    required this.citedByCount,
    required this.homepageUrl,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    required this.apcPrices,
    required this.apcUsd,
    this.abbreviatedTitle,
    this.alternateTitles,
    this.countryCode,
    this.societies,
    this.summaryStats,
    this.magId,
  });

  static Object? _readId(Map<dynamic, dynamic> json, String key) => json['ids'][key];

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
