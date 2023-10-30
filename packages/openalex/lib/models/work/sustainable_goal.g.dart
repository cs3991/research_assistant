// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sustainable_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SustainableGoal _$SustainableGoalFromJson(Map<String, dynamic> json) =>
    SustainableGoal(
      id: json['id'] as String?,
      displayName: json['display_name'] as String?,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SustainableGoalToJson(SustainableGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'score': instance.score,
    };
