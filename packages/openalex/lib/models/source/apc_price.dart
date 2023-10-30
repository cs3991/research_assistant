import 'package:json_annotation/json_annotation.dart';

part 'apc_price.g.dart';

@JsonSerializable(explicitToJson: true)
class ApcPrice {
  @JsonKey(name: 'price')
  int? price;

  @JsonKey(name: 'currency')
  String? currency;

  ApcPrice({
    this.price,
    this.currency,
  });

  factory ApcPrice.fromJson(Map<String, dynamic> json) =>
      _$ApcPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ApcPriceToJson(this);
}

/*
 {
        price: 3920,
        currency: "GBP"
    }
  */
