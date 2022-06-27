import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'institution.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum InstitutionType {
  Education,
  Healthcare,
  Company,
  Archive,
  Nonprofit,
  Government,
  Facility,
  Other,
}

abstract class InstitutionBase {
  final String id;
  final String displayName;
  final String ror;
  final String countryCode;
  final InstitutionType type;

  InstitutionBase({
    required this.id,
    required this.displayName,
    required this.ror,
    required this.countryCode,
    required this.type,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InstitutionDehydrated extends InstitutionBase {
  factory InstitutionDehydrated.fromJson(Map<String, dynamic> json) =>
      _$InstitutionDehydratedFromJson(json);

  InstitutionDehydrated({
    required super.id,
    required super.displayName,
    required super.ror,
    required super.countryCode,
    required super.type,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Institution extends InstitutionBase {
  Institution({
    required super.id,
    required super.ror,
    required super.displayName,
    required super.countryCode,
    required super.type,
    required this.homepageUrl,
    required this.imageUrl,
    required this.imageThumbnailUrl,
    required this.displayNameAcronyms,
    required this.displayNameAlternatives,
    required this.worksCount,
    required this.citedByCount,
    required this.geo,
    required this.international,
    required this.associatedInstitutions,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    this.magId,
    this.gridId,
    this.wikipediaId,
    this.wikidataId,
  });

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);

  final String homepageUrl;
  final String imageUrl;
  final String imageThumbnailUrl;
  final List<String> displayNameAcronyms;
  final List<String> displayNameAlternatives;
  final int worksCount;
  final int citedByCount;

  @JsonKey(readValue: _readId, name: "mag")
  final String? magId;
  @JsonKey(readValue: _readId, name: "grid")
  final String? gridId;
  @JsonKey(readValue: _readId, name: "wikipedia")
  final String? wikipediaId;
  @JsonKey(readValue: _readId, name: "wikidata")
  final String? wikidataId;

  final Geo geo;
  final International international;
  final List<InstitutionDehydrated>
      associatedInstitutions; // todo: add relationship
  final List<Year> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Geo {
  final String city;
  final String geonamesCityId;
  final String region;
  final String countryCode;
  final String country;
  final double latitude;
  final double longitude;

  Geo({
    required this.city,
    required this.geonamesCityId,
    required this.region,
    required this.countryCode,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}
