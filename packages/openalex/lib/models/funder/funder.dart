import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/institution/summary_stats.dart';
import 'package:openalex/models/work/alex_ids.dart';

import '../institution/role.dart';

part 'funder.g.dart';

@JsonSerializable(explicitToJson: true)
class Funder {
  @JsonKey(name: 'alternate_titles')
  List<String>? alternateTitles;

  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  @JsonKey(name: 'country_code')
  String? countryCode;

  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  @JsonKey(name: 'created_date')
  String? createdDate;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'grants_count')
  int? grantsCount;

  @JsonKey(name: 'homepage_url')
  String? homepageUrl;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'ids')
  AlexIds? ids;

  @JsonKey(name: 'image_thumbnail_url')
  String? imageThumbnailUrl;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'roles')
  List<Role>? roles;

  @JsonKey(name: 'summary_stats')
  SummaryStats? summaryStats;

  @JsonKey(name: 'updated_date')
  String? updatedDate;

  @JsonKey(name: 'works_count')
  int? worksCount;

  Funder({
    this.alternateTitles,
    this.citedByCount,
    this.countryCode,
    this.countsByYear,
    this.createdDate,
    this.description,
    this.displayName,
    this.grantsCount,
    this.homepageUrl,
    this.id,
    this.ids,
    this.imageThumbnailUrl,
    this.imageUrl,
    this.roles,
    this.summaryStats,
    this.updatedDate,
    this.worksCount,
  });

  factory Funder.fromJson(Map<String, dynamic> json) => _$FunderFromJson(json);

  Map<String, dynamic> toJson() => _$FunderToJson(this);
}

/*
Funder object
These are the fields in a funder object. When you use the API to get a single funder or lists of funders, this is what's returned.
alternate_titles
List: A list of alternate titles for this funder.
alternate_titles: [
  "US National Institutes of Health",
  "Institutos Nacionales de la Salud",
  "NIH"
]
cited_by_count
Integer: The total number  that cite a work linked to this funder.
cited_by_count: 7823467
country_code
String: The country where this funder is located, represented as an .
country_code: "US"
counts_by_year
List: The values of  and  for each of the last ten years, binned by year. To put it another way: for every listed year, you can see how many new works are linked to this funder, and how many times any work linked to this funder was cited.
Years with zero citations and zero works have been removed so you will need to add those back in if you need them.
counts_by_year: [
    {
        year: 2021,
        works_count: 4211,
        cited_by_count: 120939
    },
    {
        year: 2020,
        works_count: 4363,
        cited_by_count: 119531
    },

    // and so forth
]
created_date
String: The date this Funder object was created in the OpenAlex dataset, expressed as an  date string.
created_date: "2023-02-13"
description
String: A short description of this funder, taken from .
description: "medical research organization in the United States"
display_name
String: The primary name of the funder.
display_name: "National Institutes of Health"
grants_count
Integer: The number of grants linked to this funder.
grants_count: 7109
homepage_url
String: The URL for this funder's primary homepage.
homepage_url: "http://www.nih.gov/"
id
String: The OpenAlex ID for this funder.
id: "https://openalex.org/F4320332161"
ids
Object: All the external identifiers that we know about for this funder. IDs are expressed as URIs whenever possible. Possible ID types:
crossref String: this funder's Crossref ID
doi String: this funder's DOI
openalex String: this funder's ​
ror String: this funder's ROR ID
wikidata String: this funder's ​
ids: {
    openalex: "https://openalex.org/F4320332161",
    ror: "https://ror.org/01cwqze88",
    wikidata: "https://www.wikidata.org/entity/Q390551",
    crossref: "100000002",
    doi: "https://doi.org/10.13039/100000002"
}
image_thumbnail_url
String: Same as , but it's a smaller image.
This is usually a hotlink to a wikimedia image. You can change the width=300 parameter in the URL if you want a different thumbnail size.
image_thumbnail_url: "https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/NIH 2013 logo vertical.svg&width=300"
image_url
String: URL where you can get an image representing this funder. Usually this a hotlink to a Wikimedia image, and usually it's a seal or logo.
image_url: "https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/NIH 2013 logo vertical.svg"
roles
List: List of role objects, which include the role (one of institution, funder, or publisher), the id (), and the works_count.
In many cases, a single organization does not fit neatly into one role. For example, Yale University is a single organization that is a research university, funds research studies, and publishes an academic journal. The roles property links the OpenAlex entities together for a single organization, and includes counts for the works associated with each role.
The roles list of an entity (, , or ) always includes itself. In the case where an organization only has one role, the roles will be a list of length one, with itself as the only item.
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
summary_stats
Object: Citation metrics for this funder
2yr_mean_citedness Float: The 2-year mean citedness for this funder. Also known as .
h_index Integer: The  for this funder.
i10_index Integer: The  for this funder.
While the h-index and the i-10 index are normally author-level metrics and the 2-year mean citedness is normally a journal-level metric, they can be calculated for any set of papers, so we include them for funders.
summary_stats: {
    2yr_mean_citedness: 5.065784263815827,
    h_index: 985,
    i10_index: 176682
}
updated_date
String: The last time anything in this funder object changed, expressed as an  date string. This date is updated for any change at all, including increases in various counts.
updated_date: "2023-04-21T16:54:19.012138"
works_count
Integer: The number of works linked to this funder.
works_count: 260210
 */
