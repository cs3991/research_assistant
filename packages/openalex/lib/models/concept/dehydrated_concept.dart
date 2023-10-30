import 'package:json_annotation/json_annotation.dart';

part 'dehydrated_concept.g.dart';

@JsonSerializable(explicitToJson: true)
class DehydratedConcept {
  @JsonKey(name: 'display_name')
  String? displayName;

  String? id;

  int? level;

  String? wikidata;

  DehydratedConcept({
    this.displayName,
    this.id,
    this.level,
    this.wikidata,
  });

  factory DehydratedConcept.fromJson(Map<String, dynamic> json) =>
      _$DehydratedConceptFromJson(json);

  Map<String, dynamic> toJson() => _$DehydratedConceptToJson(this);
}

/*
 The DehydratedConcept is stripped-down Concept object, with most of its properties removed to save weight. Its only remaining properties are:
[`display_name`](concept-object.md#display\_name)
[`id`](concept-object.md#id)
[`level`](concept-object.md#level)
[`wikidata`](concept-object.md#wikidata)
  */
