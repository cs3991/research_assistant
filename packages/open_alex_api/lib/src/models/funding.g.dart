// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'funding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Funder _$FunderFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Funder', json, ($checkedConvert) {
      final val = Funder(
        id: $checkedConvert('id', (v) => v as String),
        displayName: $checkedConvert('display_name', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'displayName': 'display_name'});

Award _$AwardFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Award',
  json,
  ($checkedConvert) {
    final val = Award(
      id: $checkedConvert('id', (v) => v as String),
      displayName: $checkedConvert('display_name', (v) => v as String?),
      funderAwardId: $checkedConvert('funder_award_id', (v) => v as String?),
      funderId: $checkedConvert('funder_id', (v) => v as String?),
      funderDisplayName: $checkedConvert(
        'funder_display_name',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'displayName': 'display_name',
    'funderAwardId': 'funder_award_id',
    'funderId': 'funder_id',
    'funderDisplayName': 'funder_display_name',
  },
);
