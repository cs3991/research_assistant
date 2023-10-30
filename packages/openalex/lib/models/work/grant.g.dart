// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grant _$GrantFromJson(Map<String, dynamic> json) => Grant(
      funder: json['funder'] as String?,
      funderDisplayName: json['funder_display_name'] as String?,
      awardId: json['award_id'] as String?,
    );

Map<String, dynamic> _$GrantToJson(Grant instance) => <String, dynamic>{
      'funder': instance.funder,
      'funder_display_name': instance.funderDisplayName,
      'award_id': instance.awardId,
    };
