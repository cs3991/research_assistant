import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'venue.g.dart';

// example of json model:
//   "id": "https://openalex.org/V1983995261",
//   "issn_l": "2167-8359",
//   "issn": ["2167-8359"],
//   "display_name": "PeerJ",
//   "publisher": "PeerJ",
//   "works_count": 21215,
//   "cited_by_count": 153850,
//   "is_oa": true,
//   "is_in_doaj": true,
//   "homepage_url": "http://www.peerj.com/",
//   "ids": {
//     "openalex": "https://openalex.org/V1983995261",
//     "issn_l": "2167-8359",
//     "mag": "1983995261",
//     "issn": ["2167-8359"]
//   },
//   "x_concepts": [
//     {
//       "id": "https://openalex.org/C86803240",
//       "wikidata": "https://www.wikidata.org/wiki/Q420",
//       "display_name": "Biology",
//       "level": 0,
//       "score": 82.4
//     }
//   ],
//   "counts_by_year": [
//     {"year": 2022, "works_count": 883, "cited_by_count": 18439},
//     {"year": 2021, "works_count": 4325, "cited_by_count": 46571},
//     {"year": 2020, "works_count": 4364, "cited_by_count": 33225},
//     {"year": 2019, "works_count": 3857, "cited_by_count": 22303},
//   ],
//   "works_api_url": "https://api.openalex.org/works?filter=host_venue.id:V1983995261",
//   "updated_date": "2022-06-18",
//   "created_date": "2016-06-24"
// }

@JsonSerializable(fieldRename: FieldRename.snake)
class Venue {
  final String id;
  final String displayName;
  @JsonKey(name: 'issn_l')
  final String linkingIssn;
  final List<String> issn;
  final String publisher;
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
    required this.id,
    required this.displayName,
    required this.linkingIssn,
    required this.issn,
    required this.publisher,
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

