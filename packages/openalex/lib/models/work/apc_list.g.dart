// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apc_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApcList _$ApcListFromJson(Map<String, dynamic> json) => ApcList(
      value: json['value'] as int?,
      currency: json['currency'] as String?,
      provenance: json['provenance'] as String?,
      valueUsd: json['value_usd'] as int?,
    );

Map<String, dynamic> _$ApcListToJson(ApcList instance) => <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
      'provenance': instance.provenance,
      'value_usd': instance.valueUsd,
    };
