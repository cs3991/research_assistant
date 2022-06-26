import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'venue.g.dart';

abstract class VenueBase {
  VenueBase({
    required this.id,
    required this.linkingIssn,
    required this.issn,
    required this.displayName,
    required this.publisher,
  });

  final String id;
  final String displayName;
  @JsonKey(name: 'issn_l')
  final String linkingIssn;
  final List<String> issn;
  final String publisher;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VenueDehydrated extends VenueBase {
  VenueDehydrated({
    required super.id,
    required super.displayName,
    required super.linkingIssn,
    required super.issn,
    required super.publisher,
  });

  factory VenueDehydrated.fromJson(Map<String, dynamic> json) =>
      _$VenueDehydratedFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Venue extends VenueBase {
  final int worksCount;
  final int citedByCount;
  final bool isOa;
  final bool isInDoaj;
  final String homepageUrl;

  // ids
  @JsonKey(readValue: _readId, name: 'mag')
  final String? magId;

  // counts_by_year
  final List<Year> countsByYear;
  final String worksApiUrl;
  final DateTime updatedDate;
  final DateTime createdDate;

  Venue({
    required super.id,
    required super.displayName,
    required super.linkingIssn,
    required super.issn,
    required super.publisher,
    required this.worksCount,
    required this.citedByCount,
    required this.isOa,
    required this.isInDoaj,
    required this.homepageUrl,
    required this.countsByYear,
    required this.worksApiUrl,
    required this.updatedDate,
    required this.createdDate,
    this.magId,
  });

  static Object? _readId(Map<dynamic, dynamic> json, String key) =>
      json['ids'][key];

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
}
