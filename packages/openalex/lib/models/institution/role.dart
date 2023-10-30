import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable(explicitToJson: true)
class Role {
  String? role;

  String? id;

  @JsonKey(name: 'works_count')
  int? worksCount;

  Role({
    this.role,
    this.id,
    this.worksCount,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

/*
 roles: [
    {
        role: "funder",
        id: "https://openalex.org/F4320308380",
        works_count: 1004,
    },
    {
        role: "publisher",
        id: "https://openalex.org/P4310315589",
        works_count: 13986,
    },
    {
        role: "institution",
        id: "https://openalex.org/I32971472",
        works_count: 250031,
    }
]
  */
