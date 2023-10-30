// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geo _$GeoFromJson(Map<String, dynamic> json) => Geo(
      city: json['city'] as String?,
      geonamesCityId: json['geonames_city_id'] as String?,
      region: json['region'] as String?,
      countryCode: json['country_code'] as String?,
      country: json['country'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'city': instance.city,
      'geonames_city_id': instance.geonamesCityId,
      'region': instance.region,
      'country_code': instance.countryCode,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
