// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'international.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

International _$InternationalFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'International',
      json,
      ($checkedConvert) {
        final val = International(
          displayName: $checkedConvert(
              'display_name', (v) => Map<String, String>.from(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {'displayName': 'display_name'},
    );

InternationalWithDescription _$InternationalWithDescriptionFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'InternationalWithDescription',
      json,
      ($checkedConvert) {
        final val = InternationalWithDescription(
          displayName: $checkedConvert(
              'display_name', (v) => Map<String, String>.from(v as Map)),
          description: $checkedConvert(
              'description', (v) => Map<String, String>.from(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {'displayName': 'display_name'},
    );
