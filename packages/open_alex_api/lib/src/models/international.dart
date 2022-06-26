import 'package:json_annotation/json_annotation.dart';

part 'international.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class International {
  International({
    required this.displayName,
  });

  final Map<String, String> displayName;

  factory International.fromJson(Map<String, dynamic> json) =>
      _$InternationalFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InternationalWithDescription extends International {
  InternationalWithDescription({
    required super.displayName,
    required this.description,
  });

  factory InternationalWithDescription.fromJson(Map<String, dynamic> json) =>
      _$InternationalWithDescriptionFromJson(json);

  final Map<String, String> description;
}
