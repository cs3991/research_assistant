import 'package:json_annotation/json_annotation.dart';

part 'work.g.dart';

// @JsonSerializable()
// class Work {
//   Work({
//     required this.title,
//   });
//
//   final String title;
//
//   factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
// }

@JsonEnum(fieldRename: FieldRename.kebab)
enum WorkType {
  // @JsonValue('book-section')
  bookSection,
  monograph,
  report,
  // @JsonValue('peer-review')
  peerReview,
  // @JsonValue('book-track')
  bookTrack,
  // @JsonValue('book-article')
  journalArticle,
  // @JsonValue('book-part')
  bookPart,
  other,
  book,
  // @JsonValue('journal-volume')
  journalVolume,
  // @JsonValue('book-set')
  bookSet,
  // @JsonValue('reference-entry')
  referenceEntry,
  // @JsonValue('proceedings-article')
  proceedingsArticle,
  journal,
  component,
  // @JsonValue('book-chapter')
  bookChapter,
  // @JsonValue('proceedings-series')
  proceedingsSeries,
  // @JsonValue('report-series')
  reportSeries,
  proceedings,
  standard,
  // @JsonValue('reference-book')
  referenceBook,
  // @JsonValue('posted-content')
  postedContent,
  // @JsonValue('journal-issue')
  journalIssue,
  dissertation,
  grant,
  dataset,
  // @JsonValue('book-series')
  bookSeries,
  // @JsonValue('edited-book')
  editedBook,
  // @JsonValue('standard-series')
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
  final String? openAlexId;
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
  static Object? _readOpenAccess(Map<dynamic, dynamic> json, String key) =>
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
      toJson: _writeCountsByYear)
  final Map<int, int> citedByCountsByYear;

  static Map<int, int> _readCountsByYear(List<Map<dynamic, dynamic>> list) {
    final Map<int, int> result = {};
    for (final element in list) {
      result[element['year']] = element['cited_by_count'];
    }
    return result;
  }

  static List<Map<dynamic, dynamic>> _writeCountsByYear(Map<int, int> map) {
    final List<Map<dynamic, dynamic>> result = [];
    for (final element in map.entries) {
      result.add({
        'year': element.key,
        'cited_by_count': element.value,
      });
    }
    return result;
  }

  final bool isRetracted;
  final bool isParatext;

  final DateTime updatedDate;
  final DateTime createdDate;

  Work({
    this.openAlexId,
    this.doiId,
    this.magId,
    this.pmidId,
    this.pmcId,
    required this.type,
    required this.title,
    required this.displayName,
    required this.publicationYear,
    required this.publicationDate,
    required this.citedByCount,
    required this.isOpenAccess,
    required this.openAccessStatus,
    this.openAccessUrl,
    required this.isRetracted,
    required this.isParatext,
    required this.citedByApiUrl,
    required this.citedByCountsByYear,
    required this.updatedDate,
    required this.createdDate,
  });

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

}
