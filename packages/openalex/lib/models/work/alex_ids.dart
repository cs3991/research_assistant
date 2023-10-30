import 'package:json_annotation/json_annotation.dart';

part 'alex_ids.g.dart';

@JsonSerializable(explicitToJson: true)
class AlexIds {
  /// The DOI. Same as Work.doi
  String? doi;

  /// the Microsoft Academic Graph ID
  String? mag;

  /// The OpenAlex ID. Same as Work.id
  String? openalex;

  /// The PubMed ID
  String? pmid;

  /// The PubMed Central ID
  String? pmcid;

  AlexIds({
    this.doi,
    this.mag,
    this.openalex,
    this.pmid,
    this.pmcid,
  });

  factory AlexIds.fromJson(Map<String, dynamic> json) =>
      _$AlexIdsFromJson(json);

  Map<String, dynamic> toJson() => _$AlexIdsToJson(this);
}
