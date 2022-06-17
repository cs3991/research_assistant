import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Author {
  Author({
    required this.id,
    required this.displayName,
    required this.displayNameAlternatives,
    required this.worksCount,
    required this.citedByCount,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    this.orcidId,
    this.magId,
    this.twitterId,
    this.wikipediaId,
    this.scopusId,
  });

  @JsonKey(name: 'id')
  final String id;
  final String displayName;
  final List<String> displayNameAlternatives;
  final int worksCount;
  final int citedByCount;

  // ids
  @JsonKey(readValue: _readId, name: 'orcid')
  final String? orcidId;
  @JsonKey(readValue: _readId, name: 'mag')
  final String? magId;
  @JsonKey(readValue: _readId, name: 'twitter')
  final String? twitterId;
  @JsonKey(readValue: _readId, name: 'wikipedia')
  final String? wikipediaId;
  @JsonKey(readValue: _readId, name: 'scopus')
  final String? scopusId;

  @JsonKey(
    name: 'counts_by_year',
    fromJson: _readCountsByYear,
  )
  final Map<int, int> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];

  static Map<int, int> _readCountsByYear(List list) {
    final Map<int, int> result = {};
    for (var element in list) {
      element = element as Map<dynamic, dynamic>;
      result[element['year']] = element['cited_by_count'];
    }
    return result;
  }

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
