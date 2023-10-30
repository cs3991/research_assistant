import 'package:json_annotation/json_annotation.dart';

part 'grant.g.dart';

@JsonSerializable(explicitToJson: true)
class Grant {
  @JsonKey(name: 'funder')
  String? funder;

  @JsonKey(name: 'funder_display_name')
  String? funderDisplayName;

  @JsonKey(name: 'award_id')
  String? awardId;

  Grant({
    this.funder,
    this.funderDisplayName,
    this.awardId,
  });

  factory Grant.fromJson(Map<String, dynamic> json) => _$GrantFromJson(json);

  Map<String, dynamic> toJson() => _$GrantToJson(this);
}

/*
   {
        funder: "https://openalex.org/F4320306076",
        funder_display_name: "National Science Foundation",
        award_id: "ABI 1661218",
    },
 */
