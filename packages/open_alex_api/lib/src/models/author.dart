import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'author.g.dart';

abstract class AuthorBase {
  AuthorBase({required this.displayName, this.orcid});

  String? get id;
  final String displayName;
  final String? orcid;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthorDehydrated extends AuthorBase {
  // OpenAlex can retain an author's name without a resolved author ID.
  @override
  final String? id;

  factory AuthorDehydrated.fromJson(Map<String, dynamic> json) =>
      _$AuthorDehydratedFromJson(json);

  AuthorDehydrated({required this.id, required super.displayName, super.orcid});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Author extends AuthorBase {
  @override
  final String id;

  Author({
    required this.id,
    required super.displayName,
    required this.displayNameAlternatives,
    required this.worksCount,
    required this.citedByCount,
    required this.countsByYear,
    required this.worksApiUrl,
    this.lastKnownInstitution,
    this.lastKnownInstitutions = const [],
    required this.updatedDate,
    required this.createdDate,
    super.orcid,
    this.magId,
    this.twitterId,
    this.wikipediaId,
    this.scopusId,
  });

  final InstitutionDehydrated? lastKnownInstitution;
  @JsonKey(defaultValue: [])
  final List<InstitutionDehydrated> lastKnownInstitutions;
  final List<String> displayNameAlternatives;
  final int worksCount;
  final int citedByCount;

  // ids
  @JsonKey(readValue: _readId, name: 'mag')
  final String? magId;
  @JsonKey(readValue: _readId, name: 'twitter')
  final String? twitterId;
  @JsonKey(readValue: _readId, name: 'wikipedia')
  final String? wikipediaId;
  @JsonKey(readValue: _readId, name: 'scopus')
  final String? scopusId;

  // @JsonKey(name: 'counts_by_year')
  final List<Year> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids']?[key];

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
