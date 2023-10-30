import 'package:json_annotation/json_annotation.dart';

part 'sustainable_goal.g.dart';

@JsonSerializable(explicitToJson: true)
class SustainableGoal {
  String? id;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'score')
  double? score;

  SustainableGoal({
    this.id,
    this.displayName,
    this.score,
  });

  factory SustainableGoal.fromJson(Map<String, dynamic> json) =>
      _$SustainableGoalFromJson(json);

  Map<String, dynamic> toJson() => _$SustainableGoalToJson(this);
}

/*
 {
        id: "https://metadata.un.org/sdg/3",
        display_name: "Good health and well-being",
        score: 	0.95
    }
  */
