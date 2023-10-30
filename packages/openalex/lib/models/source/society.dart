import 'package:json_annotation/json_annotation.dart';

part 'society.g.dart';

@JsonSerializable(explicitToJson: true)
class Society {
  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'organization')
  String? organization;

  Society({
    this.url,
    this.organization,
  });

  factory Society.fromJson(Map<String, dynamic> json) =>
      _$SocietyFromJson(json);

  Map<String, dynamic> toJson() => _$SocietyToJson(this);
}

/*
 {
        "url": "http://www.counseling.org/",
        "organization": "American Counseling Association on behalf of the American College Counseling Association"
    }
  */
