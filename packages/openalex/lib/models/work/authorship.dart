import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/author/author.dart';
import 'package:openalex/models/institution/dehydrated_institution.dart';

part 'authorship.g.dart';

@JsonSerializable(explicitToJson: true)
class Authorship {
  @JsonKey(name: 'author_position')
  String? authorPosition;

  @JsonKey(name: 'author')
  Author? author;

  @JsonKey(name: 'institutions')
  List<DehydratedInstitution>? institutions;

  Authorship({
    this.authorPosition,
    this.author,
    this.institutions,
  });

  factory Authorship.fromJson(Map<String, dynamic> json) =>
      _$AuthorshipFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorshipToJson(this);
}

/*
author_position: "first",
        author: {
            id: "https://openalex.org/A1969205032",
            display_name: "Heather A. Piwowar",
            orcid: "https://orcid.org/0000-0003-1613-5981"
        },
        institutions: [
            {
                id: "https://openalex.org/I4200000001",
                display_name: "OurResearch",
                ror: "https://ror.org/02nr0ka47",
                country_code: "US",
                type: "nonprofit"
            }
        ]
 */
