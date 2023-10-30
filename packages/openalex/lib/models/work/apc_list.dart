import 'package:json_annotation/json_annotation.dart';

part 'apc_list.g.dart';

@JsonSerializable(explicitToJson: true)
class ApcList {
  @JsonKey(name: 'value')
  int? value;

  @JsonKey(name: 'currency')
  String? currency;

  @JsonKey(name: 'provenance')
  String? provenance;

  @JsonKey(name: 'value_usd')
  int? valueUsd;

  ApcList({
    this.value,
    this.currency,
    this.provenance,
    this.valueUsd,
  });

  factory ApcList.fromJson(Map<String, dynamic> json) =>
      _$ApcListFromJson(json);

  Map<String, dynamic> toJson() => _$ApcListToJson(this);
}

/*
 value: Integer
currency: String
provenance: String — the source of this data. Currently the only value is “doaj” (DOAJ)
value_usd: Integer — the APC converted into USD
  */
