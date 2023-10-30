import 'package:json_annotation/json_annotation.dart';

part 'mesh.g.dart';

@JsonSerializable(explicitToJson: true)
class MeSH {
  /// The MeSH descriptor ID for this MeSH term.
  @JsonKey(name: 'descriptor_id')
  String? descriptorUi;

  /// The name of this MeSH term.
  @JsonKey(name: 'descriptor_name')
  String? descriptorName;

  /// The qualifier name for this MeSH term.
  @JsonKey(name: 'qualifier_name')
  String? qualifierName;

  /// The qualifier ID for this MeSH term.
  @JsonKey(name: 'qualifier_id')
  String? qualifierUi;

  /// If this MeSH term is a major topic for the work, this field will be true; otherwise it will be false.
  @JsonKey(name: 'is_major_topic')
  bool? isMajorTopic;

  MeSH({
    this.descriptorUi,
    this.descriptorName,
    this.qualifierName,
    this.qualifierUi,
    this.isMajorTopic,
  });

  factory MeSH.fromJson(Map<String, dynamic> json) => _$MeSHFromJson(json);

  Map<String, dynamic> toJson() => _$MeSHToJson(this);
}
