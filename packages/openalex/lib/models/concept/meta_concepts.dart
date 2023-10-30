import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/concept/concept.dart';
import 'package:openalex/models/work/meta.dart';

part 'meta_concepts.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaConcepts {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Concept>? concepts;

  MetaConcepts({
    this.meta,
    this.concepts,
  });

  factory MetaConcepts.fromJson(Map<String, dynamic> json) =>
      _$MetaConceptsFromJson(json);

  Map<String, dynamic> toJson() => _$MetaConceptsToJson(this);
}
