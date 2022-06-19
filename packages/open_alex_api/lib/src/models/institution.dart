import 'package:json_annotation/json_annotation.dart';

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

@JsonSerializable(fieldRename: FieldRename.snake)
class Institution {
  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);

  final String id;
  final String ror;
  // final String displayName;
  final String countryCode;
  final InstitutionType type;
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
  @JsonKey(readValue: _readInternational, name: "display_name")
  final Map<String, String> internationalDisplayName;
  // final List<Institution> associatedInstitutions;
  final List<YearInstitution> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  Institution({
    required this.id,
    required this.ror,
    // required this.displayName,
    required this.countryCode,
    required this.type,
    required this.homepageUrl,
    required this.imageUrl,
    required this.imageThumbnailUrl,
    required this.displayNameAcronyms,
    required this.displayNameAlternatives,
    required this.worksCount,
    required this.citedByCount,
    required this.geo,
    required this.internationalDisplayName,
    // required this.associatedInstitutions,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    this.magId,
    this.gridId,
    this.wikipediaId,
    this.wikidataId,
  });

  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];

  static Object? _readInternational(Map<dynamic, dynamic> json, String key) =>
      json['international'][key];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class YearInstitution {
  final int year;
  final int worksCount;
  final int citedByCount;

  YearInstitution({
    required this.year,
    required this.worksCount,
    required this.citedByCount,
  });

  factory YearInstitution.fromJson(Map<String, dynamic> json) =>
      _$YearInstitutionFromJson(json);
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
