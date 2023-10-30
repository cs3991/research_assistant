import 'package:json_annotation/json_annotation.dart';

part 'apc_paid.g.dart';

@JsonSerializable(explicitToJson: true)
class ApcPaid {
  @JsonKey(name: 'value')
  int? value;

  @JsonKey(name: 'currency')
  String? currency;

  @JsonKey(name: 'provenance')
  String? provenance;

  @JsonKey(name: 'value_usd')
  int? valueUsd;

  ApcPaid({
    this.value,
    this.currency,
    this.provenance,
    this.valueUsd,
  });

  factory ApcPaid.fromJson(Map<String, dynamic> json) =>
      _$ApcPaidFromJson(json);

  Map<String, dynamic> toJson() => _$ApcPaidToJson(this);
}

/*
value: Integer
currency: String
provenance: String — currently either openapc or doaj, but more will be added; see below for details.
value_usd: Integer — the APC converted into USD
 */
