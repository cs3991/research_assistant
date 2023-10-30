// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apc_paid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApcPaid _$ApcPaidFromJson(Map<String, dynamic> json) => ApcPaid(
      value: json['value'] as int?,
      currency: json['currency'] as String?,
      provenance: json['provenance'] as String?,
      valueUsd: json['value_usd'] as int?,
    );

Map<String, dynamic> _$ApcPaidToJson(ApcPaid instance) => <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
      'provenance': instance.provenance,
      'value_usd': instance.valueUsd,
    };
