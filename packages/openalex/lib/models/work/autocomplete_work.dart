import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_work.g.dart';

@JsonSerializable(explicitToJson: true)
class AutocompleteWork {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'hint')
  String? hint;

  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  @JsonKey(name: 'works_count')
  int? worksCount;

  @JsonKey(name: 'entity_type')
  String? entityType;

  @JsonKey(name: 'external_id')
  String? externalId;

  AutocompleteWork({
    this.id,
    this.displayName,
    this.hint,
    this.citedByCount,
    this.worksCount,
    this.entityType,
    this.externalId,
  });

  factory AutocompleteWork.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteWorkFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteWorkToJson(this);
}

/*
 "id": "https://openalex.org/W2125098916",
      "display_name": "Crouching tigers, hidden prey: Sumatran tiger and prey populations in a tropical forest landscape",
      "hint": "Timothy G. O'Brien, Margaret F. Kinnaird, Hariyo T. Wibisono",
      "cited_by_count": 620,
      "works_count": null,
      "entity_type": "work",
      "external_id": "https://doi.org/10.1017/s1367943003003172"
  */
