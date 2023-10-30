import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/institution/institution.dart';
import 'package:openalex/models/work/meta.dart';

part 'meta_institutions.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaInstitutions {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Institution>? institutions;

  MetaInstitutions({
    this.meta,
    this.institutions,
  });

  factory MetaInstitutions.fromJson(Map<String, dynamic> json) =>
      _$MetaInstitutionsFromJson(json);

  Map<String, dynamic> toJson() => _$MetaInstitutionsToJson(this);
}
