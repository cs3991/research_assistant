import 'package:json_annotation/json_annotation.dart';

part 'international.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class International {
  final Map<String, String> displayName;

  International({
    required this.displayName,
  });

  factory International.fromJson(Map<String, dynamic> json) =>
      _$InternationalFromJson(json);
}
