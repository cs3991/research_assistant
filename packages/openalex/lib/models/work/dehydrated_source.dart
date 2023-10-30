import 'package:json_annotation/json_annotation.dart';

part 'dehydrated_source.g.dart';

@JsonSerializable(explicitToJson: true)
class DehydratedSource {
  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'host_organization')
  String? hostOrganization;

  @JsonKey(name: 'host_organization_lineage')
  List<String>? hostOrganizationLineage;

  @JsonKey(name: 'host_organization_name')
  String? hostOrganizationName;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'is_in_doaj')
  bool? isInDoaj;

  @JsonKey(name: 'is_oa')
  bool? isOa;

  @JsonKey(name: 'issn')
  List<String>? issn;

  @JsonKey(name: 'issn_l')
  String? issnL;

  @JsonKey(name: 'type')
  String? type;

  DehydratedSource({
    this.displayName,
    this.hostOrganization,
    this.hostOrganizationLineage,
    this.hostOrganizationName,
    this.id,
    this.isInDoaj,
    this.isOa,
    this.issn,
    this.issnL,
    this.type,
  });

  factory DehydratedSource.fromJson(Map<String, dynamic> json) =>
      _$DehydratedSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DehydratedSourceToJson(this);
}

/*
display_name
host_organization
host_organization_lineage
host_organization_name
id
is_in_doaj
is_oa
issn
issn_l
type
 */
