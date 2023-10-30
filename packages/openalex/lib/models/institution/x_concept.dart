import 'package:json_annotation/json_annotation.dart';

part 'x_concept.g.dart';

@JsonSerializable(explicitToJson: true)
class XConcept {
  String? id;

  String? wikidata;

  @JsonKey(name: 'display_name')
  String? displayName;

  int? level;

  double? score;

  XConcept({
    this.id,
    this.wikidata,
    this.displayName,
    this.level,
    this.score,
  });

  factory XConcept.fromJson(Map<String, dynamic> json) =>
      _$XConceptFromJson(json);

  Map<String, dynamic> toJson() => _$XConceptToJson(this);
}

/*
 id: "https://openalex.org/C86803240",
        wikidata: null,
        display_name: "Biology",
        level: 0,
        score: 86.7
  */
