import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'work.g.dart';

@JsonEnum(fieldRename: FieldRename.kebab)
enum WorkType {
  bookSection,
  monograph,
  report,
  peerReview,
  bookTrack,
  journalArticle,
  bookPart,
  other,
  book,
  journalVolume,
  bookSet,
  referenceEntry,
  proceedingsArticle,
  journal,
  component,
  bookChapter,
  proceedingsSeries,
  reportSeries,
  proceedings,
  standard,
  referenceBook,
  postedContent,
  journalIssue,
  dissertation,
  grant,
  dataset,
  bookSeries,
  editedBook,
  standardSeries,
}

enum OpenAccessStatus {
  gold,
  green,
  hybrid,
  bronze,
  closed,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Work {
  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(readValue: _readId, name: 'doi')
  final String? doiId;
  @JsonKey(readValue: _readId, name: 'mag')
  final String? magId;
  @JsonKey(readValue: _readId, name: 'pmid')
  final String? pmidId;
  @JsonKey(readValue: _readId, name: 'pmcid')
  final String? pmcId;

  final String title;
  final String displayName;
  final int publicationYear;
  final DateTime publicationDate;
  final HostVenue hostVenue;
  final WorkType type;

  // Open access
  @JsonKey(readValue: _readOpenAccess, name: 'is_oa')
  final bool isOpenAccess;
  @JsonKey(readValue: _readOpenAccess, name: 'oa_status')
  final OpenAccessStatus openAccessStatus;
  @JsonKey(readValue: _readOpenAccess, name: 'oa_url')
  final String? openAccessUrl;

  final List<Authorship> authorships;
  final int citedByCount;
  final Map<String, String?> biblio; // todo: add a model for this?
  final bool isRetracted;
  final bool isParatext;
  final List<ConceptDehydrated> concepts; // todo: add score
  final List<Map> mesh;
  final List<HostVenue> alternateHostVenues;
  final List<String> referencedWorks;
  final List<String> relatedWorks;
  final Map<String, List<int>> abstractInvertedIndex;
  final String citedByApiUrl;
  @JsonKey(name: 'counts_by_year')
  final List<YearWork> countsByYear;
  final DateTime updatedDate;
  final DateTime createdDate;

  Work({
    required this.id,
    required this.type,
    required this.title,
    required this.displayName,
    required this.publicationYear,
    required this.publicationDate,
    required this.hostVenue,
    required this.citedByCount,
    required this.isOpenAccess,
    required this.openAccessStatus,
    required this.isRetracted,
    required this.isParatext,
    required this.citedByApiUrl,
    required this.countsByYear,
    required this.updatedDate,
    required this.createdDate,
    required this.authorships,
    required this.concepts,
    required this.mesh,
    required this.alternateHostVenues,
    required this.referencedWorks,
    required this.relatedWorks,
    required this.abstractInvertedIndex,
    required this.biblio,
    this.doiId,
    this.magId,
    this.pmidId,
    this.pmcId,
    this.openAccessUrl,
  });

  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];

  static Object? _readOpenAccess(Map<dynamic, dynamic> json, String key) =>
      json['open_access'][key];
}

enum HostVenueVersion { publishedVersion, acceptedVersion, submittedVersion }

@JsonSerializable(fieldRename: FieldRename.snake)
class HostVenue extends VenueDehydrated {
  HostVenue({
    required super.displayName,
    required super.linkingIssn,
    required super.id,
    required super.issn,
    required super.publisher,
    required this.url,
    required this.isOpenAccess,
    required this.version,
    this.license,
  });

  factory HostVenue.fromJson(Map<String, dynamic> json) =>
      _$HostVenueFromJson(json);

  final String url;
  @JsonKey(name: 'is_oa')
  final bool isOpenAccess;
  final HostVenueVersion version;
  final String? license;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum AuthorshipPosition {
  First,
  Middle,
  Last,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Authorship {
  Authorship({
    required this.author,
    required this.authorPosition,
    required this.institutions,
    required this.rawAffiliationString,
  });

  factory Authorship.fromJson(Map<String, dynamic> json) =>
      _$AuthorshipFromJson(json);

  final AuthorshipPosition authorPosition;
  final AuthorDehydrated author;
  final List<InstitutionDehydrated> institutions;
  final String rawAffiliationString;
}
