import 'package:json_annotation/json_annotation.dart';

part 'dehydrated_institution.g.dart';

@JsonSerializable(explicitToJson: true)
class DehydratedInstitution {
  @JsonKey(name: 'country_code')
  String? countryCode;

  @JsonKey(name: 'display_name')
  String? displayName;

  String? id;

  String? ror;

  String? type;

  DehydratedInstitution({
    this.countryCode,
    this.displayName,
    this.id,
    this.ror,
    this.type,
  });

  factory DehydratedInstitution.fromJson(Map<String, dynamic> json) =>
      _$DehydratedInstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$DehydratedInstitutionToJson(this);
}

/*
 The DehydratedInstitution is stripped-down Institution object, with most of its properties removed to save weight. Its only remaining properties are:
[`country_code`](institution-object.md#country\_code)
[`display_name`](institution-object.md#display\_name)
[`id`](institution-object.md#id)
[`ror`](institution-object.md#ror)
[`type`](institution-object.md#type)
  */
