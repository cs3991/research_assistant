import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'concept.g.dart';

abstract class ConceptBase {
  final String id;
  final String displayName;
  final String? wikidata;
  final int level;

  ConceptBase({
    required this.id,
    required this.displayName,
    required this.wikidata,
    required this.level,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ConceptDehydrated extends ConceptBase {
  factory ConceptDehydrated.fromJson(Map<String, dynamic> json) =>
      _$ConceptDehydratedFromJson(json);

  ConceptDehydrated({
    required super.id,
    required super.displayName,
    required super.wikidata,
    required super.level,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Concept extends ConceptBase {
  factory Concept.fromJson(Map<String, dynamic> json) =>
      _$ConceptFromJson(json);

  final String description;
  final int worksCount;
  final int citedByCount;
  @JsonKey(readValue: _readIds, name: "mag")
  final String? magId;
  @JsonKey(readValue: _readIds, name: "wikipedia")
  final String? wikipediaId;
  final String imageUrl;
  final String imageThumbnailUrl;
  final InternationalWithDescription international;

  final List<ConceptDehydrated> ancestors;
  final List<ConceptDehydrated> relatedConcepts; // todo: add score
  final List<Year> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  Concept({
    required super.displayName,
    required super.id,
    required super.wikidata,
    required super.level,
    required this.description,
    required this.worksCount,
    required this.citedByCount,
    required this.imageUrl,
    required this.imageThumbnailUrl,
    required this.international,
    required this.ancestors,
    required this.relatedConcepts,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    this.magId,
    this.wikipediaId,
  });

  static Object? _readIds(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];
}
