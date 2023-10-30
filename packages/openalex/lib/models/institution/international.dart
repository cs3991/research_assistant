import 'package:json_annotation/json_annotation.dart';

part 'international.g.dart';

@JsonSerializable(explicitToJson: true)
class International {
  @JsonKey(name: 'display_name')
  Map<String, String> displayName;

  International({
    required this.displayName,
  });

  factory International.fromJson(Map<String, dynamic> json) =>
      _$InternationalFromJson(json);

  Map<String, dynamic> toJson() => _$InternationalToJson(this);
}
