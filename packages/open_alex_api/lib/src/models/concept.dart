import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'concept.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Concept {
  factory Concept.fromJson(Map<String, dynamic> json) =>
      _$ConceptFromJson(json);

  final String id;
  final String wikidata;
  // final String displayName;
  final int level;
  // final String description;
  final int worksCount;
  final int citedByCount;
  @JsonKey(readValue: _readIds, name: "mag")
  final String? magId;
  @JsonKey(readValue: _readIds, name: "wikipedia")
  final String? wikipediaId;
  final String imageUrl;
  final String imageThumbnailUrl;
  @JsonKey(readValue: _readInternational, name: "display_name")
  final Map<String, String> internationalDisplayName;
  @JsonKey(readValue: _readInternational, name: "description")
  final Map<String, String> internationalDescription;

  // final List<Concept> ancestors;
  // final List<Concept> relatedConcepts;
  final List<Year> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  Concept({
    // required this.displayName,
    // required this.description,
    required this.id,
    required this.wikidata,
    required this.level,
    required this.worksCount,
    required this.citedByCount,
    required this.imageUrl,
    required this.imageThumbnailUrl,
    required this.internationalDisplayName,
    required this.internationalDescription,
    // required this.ancestors,
    // required this.relatedConcepts,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    this.magId,
    this.wikipediaId,
  });

  static Object? _readIds(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];

  static Object? _readInternational(Map<dynamic, dynamic> json, String key) =>
      json['international'][key];
}

