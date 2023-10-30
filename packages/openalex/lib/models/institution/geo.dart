import 'package:json_annotation/json_annotation.dart';

part 'geo.g.dart';

@JsonSerializable(explicitToJson: true)
class Geo {
  /// The city where this institution lives.
  String? city;

  /// The city where this institution lives, as a GeoNames database ID.
  @JsonKey(name: 'geonames_city_id')
  String? geonamesCityId;

  /// The sub-national region (state, province) where this institution lives.
  String? region;

  /// The country where this institution lives, represented as an ISO two-letter country code.
  @JsonKey(name: 'country_code')
  String? countryCode;

  /// The country where this institution lives.
  String? country;

  /// Does what it says.
  double? latitude;

  /// Does what it says.
  double? longitude;

  Geo({
    this.city,
    this.geonamesCityId,
    this.region,
    this.countryCode,
    this.country,
    this.latitude,
    this.longitude,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}

/*
city (String): The city where this institution lives.
geonames_city_id (String): The city where this institution lives, as a GeoNames database ID.
region (String): The sub-national region (state, province) where this institution lives.
country_code (String): The country where this institution lives, represented as an ISO two-letter country code.
country (String): The country where this institution lives.
latitude (Float): Does what it says.
longitude (Float): Does what it says.
 */
