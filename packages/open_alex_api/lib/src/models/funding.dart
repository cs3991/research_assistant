import 'package:json_annotation/json_annotation.dart';

part 'funding.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Funder {
  Funder({required this.id, required this.displayName});

  final String id;
  final String displayName;

  factory Funder.fromJson(Map<String, dynamic> json) => _$FunderFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Award {
  Award({
    required this.id,
    this.displayName,
    this.funderAwardId,
    this.funderId,
    this.funderDisplayName,
  });

  final String id;
  final String? displayName;
  final String? funderAwardId;
  final String? funderId;
  final String? funderDisplayName;

  factory Award.fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);
}
