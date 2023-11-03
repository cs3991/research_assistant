import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'work.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Work {
  final List<String> correspondingAuthorIds;
  final List<String> correspondingInstitutionIds;
  final int countriesDistinctCount;
  final String? fulltextOrigin;
  final List<Grant> grants;
  final bool hasFulltext;
  final int institutionsDistinctCount;
  final String? language;
  final String? license;
  final List<Location> locations;
  final int locationsCount;
  final String ngramsUrl;
  final Location primaryLocation;
  final DateTime publicationDate;
  final int publicationYear;
  final List<String> referencedWorks;
  final List<String> relatedWorks;
  final updatedDate;

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

  final String? title;
  final String? displayName;
  final WorkType type;

  // Open access
  @JsonKey(readValue: _readOpenAccess, name: 'is_oa')
  final bool isOpenAccess;
  @JsonKey(readValue: _readOpenAccess, name: 'oa_status')
  final OpenAccessStatus openAccessStatus;
  @JsonKey(readValue: _readOpenAccess, name: 'oa_url')
  final String? openAccessUrl;

  final List<Authorship> authorships;
  final Apc? apcList;
  final Apc? apcPaid;
  final int citedByCount;
  final Map<String, String?> biblio; // todo: add a model for this?
  final bool isRetracted;
  final bool isParatext;
  final List<ConceptDehydrated> concepts; // todo: add score
  final List<Map> mesh;
  final Map<String, List<int>>? abstractInvertedIndex;
  final String citedByApiUrl;
  @JsonKey(name: 'counts_by_year')
  final List<YearWork> countsByYear;
  final DateTime createdDate;
  final Location? bestOaLocation;

  Work({
    required this.abstractInvertedIndex,
    required this.authorships,
    required this.apcList,
    required this.apcPaid,
    required this.bestOaLocation,
    required this.biblio,
    required this.citedByApiUrl,
    required this.citedByCount,
    required this.concepts,
    required this.correspondingAuthorIds,
    required this.correspondingInstitutionIds,
    required this.countriesDistinctCount,
    required this.countsByYear,
    required this.createdDate,
    required this.displayName,
    required this.fulltextOrigin,
    required this.grants,
    required this.hasFulltext,
    required this.id,
    required this.doiId,
    required this.magId,
    required this.pmidId,
    required this.pmcId,
    required this.isParatext,
    required this.isRetracted,
    required this.mesh,
    required this.title,
    required this.type,
    required this.institutionsDistinctCount,
    required this.language,
    required this.license,
    required this.locations,
    required this.locationsCount,
    required this.ngramsUrl,
    required this.primaryLocation,
    required this.publicationDate,
    required this.publicationYear,
    required this.referencedWorks,
    required this.relatedWorks,
    required this.updatedDate,
    required this.isOpenAccess,
    required this.openAccessStatus,
    required this.openAccessUrl,
  });

  static Object? _readId(Map<dynamic, dynamic> json, String key) => json['ids'][key];

  static Object? _readOpenAccess(Map<dynamic, dynamic> json, String key) => json['open_access'][key];

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.kebab)
enum WorkType {
  article,
  bookChapter,
  dissertation,
  book,
  dataset,
  paratext,
  other,
  referenceEntry,
  report,
  peerReview,
  standard,
  editorial,
  erratum,
  grant,
  letter,
}

enum OpenAccessStatus {
  gold,
  green,
  hybrid,
  bronze,
  closed,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Location {
  final bool isOa;
  final String? landingPageUrl;
  final String? pdfUrl;
  final SourceDehydrated? source;
  final String? license;
  final String? version;
  final bool isAccepted;
  final bool isPublished;

  Location({
    required this.isOa,
    required this.landingPageUrl,
    required this.pdfUrl,
    required this.source,
    required this.license,
    required this.version,
    required this.isAccepted,
    required this.isPublished,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Grant {
  final String funder;
  final String funderDisplayName;
  final String? awardId;

  Grant({
    required this.funder,
    required this.funderDisplayName,
    required this.awardId,
  });

  factory Grant.fromJson(Map<String, dynamic> json) => _$GrantFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Apc {
  final int value;
  final String currency;
  final String? provenance;
  final int? valueUsd;

  Apc({
    required this.value,
    required this.currency,
    this.provenance,
    this.valueUsd,
  });

  factory Apc.fromJson(Map<String, dynamic> json) => _$ApcFromJson(json);
}

// enum HostVenueVersion { publishedVersion, acceptedVersion, submittedVersion }
//
// @JsonSerializable(fieldRename: FieldRename.snake)
// class HostVenue extends SourceDehydrated {
//   HostVenue({
//     required super.displayName,
//     required super.linkingIssn,
//     required super.id,
//     required super.issn,
//     required super.publisher,
//     required this.url,
//     required this.isOpenAccess,
//     required this.version,
//     this.license,
//   });
//
//   factory HostVenue.fromJson(Map<String, dynamic> json) => _$HostVenueFromJson(json);
//
//   final String url;
//   @JsonKey(name: 'is_oa')
//   final bool isOpenAccess;
//   final HostVenueVersion version;
//   final String? license;
// }

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

  factory Authorship.fromJson(Map<String, dynamic> json) => _$AuthorshipFromJson(json);

  final AuthorshipPosition authorPosition;
  final AuthorDehydrated author;
  final List<InstitutionDehydrated> institutions;
  final String rawAffiliationString;
}
