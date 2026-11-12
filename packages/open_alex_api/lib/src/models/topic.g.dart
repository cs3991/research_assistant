// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Topic', json, ($checkedConvert) {
      final val = Topic(
        id: $checkedConvert('id', (v) => v as String),
        displayName: $checkedConvert('display_name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        score: $checkedConvert('score', (v) => (v as num?)?.toDouble()),
        subfield: $checkedConvert(
          'subfield',
          (v) => v == null
              ? null
              : TopicClassification.fromJson(v as Map<String, dynamic>),
        ),
        field: $checkedConvert(
          'field',
          (v) => v == null
              ? null
              : TopicClassification.fromJson(v as Map<String, dynamic>),
        ),
        domain: $checkedConvert(
          'domain',
          (v) => v == null
              ? null
              : TopicClassification.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'displayName': 'display_name'});

TopicClassification _$TopicClassificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TopicClassification', json, ($checkedConvert) {
      final val = TopicClassification(
        id: $checkedConvert('id', (v) => v as String),
        displayName: $checkedConvert('display_name', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'displayName': 'display_name'});
