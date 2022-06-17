import 'package:json_annotation/json_annotation.dart';

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
  // ids
  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];
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

  final WorkType type;
  final String title;
  final String displayName;
  final int publicationYear;
  final DateTime publicationDate;

  // Open access
  static Object _readOpenAccess(Map<dynamic, dynamic> json, String key) =>
      json['open_access'][key];
  @JsonKey(readValue: _readOpenAccess, name: 'is_oa')
  final bool isOpenAccess;
  @JsonKey(readValue: _readOpenAccess, name: 'oa_status')
  final OpenAccessStatus openAccessStatus;
  @JsonKey(readValue: _readOpenAccess, name: 'oa_url')
  final String? openAccessUrl;

  // Citations
  final int citedByCount;
  final String citedByApiUrl;
  @JsonKey(
    name: 'counts_by_year',
    fromJson: _readCountsByYear,
  )
  final Map<int, int> countsByYear;

  static Map<int, int> _readCountsByYear(List list) {
    final Map<int, int> result = {};
    for (var element in list) {
      element = element as Map<dynamic, dynamic>;
      result[element['year']] = element['cited_by_count'];
    }
    return result;
  }

  final bool isRetracted;
  final bool isParatext;

  final DateTime updatedDate;
  final DateTime createdDate;

  Work({
    required this.id,
    required this.type,
    required this.title,
    required this.displayName,
    required this.publicationYear,
    required this.publicationDate,
    required this.citedByCount,
    required this.isOpenAccess,
    required this.openAccessStatus,
    required this.isRetracted,
    required this.isParatext,
    required this.citedByApiUrl,
    required this.countsByYear,
    required this.updatedDate,
    required this.createdDate,
    this.doiId,
    this.magId,
    this.pmidId,
    this.pmcId,
    this.openAccessUrl,
  });

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

}
