import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Topic {
  Topic({
    required this.id,
    required this.displayName,
    this.description,
    this.score,
    this.subfield,
    this.field,
    this.domain,
  });

  final String id;
  final String displayName;
  final String? description;
  final double? score;
  final TopicClassification? subfield;
  final TopicClassification? field;
  final TopicClassification? domain;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TopicClassification {
  TopicClassification({required this.id, required this.displayName});

  final String id;
  final String displayName;

  factory TopicClassification.fromJson(Map<String, dynamic> json) =>
      _$TopicClassificationFromJson(json);
}
