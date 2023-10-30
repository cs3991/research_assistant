import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable(explicitToJson: true)
class Repository {
  /// The repository's unique identifier.
  String? id;

  /// The repository's display name.
  @JsonKey(name: 'display_name')
  String? displayName;

  /// The repository's host organization, as a DehydratedOrganization object.
  @JsonKey(name: 'host_organization')
  String? hostOrganization;

  /// The repository's host organization's name.
  @JsonKey(name: 'host_organization_name')
  String? hostOrganizationName;

  /// The repository's host organization's lineage, as a list of DehydratedOrganization objects.
  @JsonKey(name: 'host_organization_lineage')
  List<String>? hostOrganizationLineage;

  Repository({
    this.id,
    this.displayName,
    this.hostOrganization,
    this.hostOrganizationName,
    this.hostOrganizationLineage,
  });

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}
/*
id: "https://openalex.org/S4306402521",
        display_name: "University of Minnesota Digital Conservancy (University of Minnesota)",
        host_organization: "https://openalex.org/I130238516",
        host_organization_name: "University of Minnesota",
        host_organization_lineage: ["https://openalex.org/I130238516"]

 */
