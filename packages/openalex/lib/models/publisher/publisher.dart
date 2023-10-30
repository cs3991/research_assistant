import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/institution/role.dart';
import 'package:openalex/models/institution/summary_stats.dart';
import 'package:openalex/models/work/alex_ids.dart';

part 'publisher.g.dart';

@JsonSerializable(explicitToJson: true)
class Publisher {
  @JsonKey(name: 'alternate_titles')
  List<String>? alternateTitles;

  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  @JsonKey(name: 'country_codes')
  List<String>? countryCodes;

  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  @JsonKey(name: 'created_date')
  String? createdDate;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'hierarchy_level')
  int? hierarchyLevel;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'ids')
  AlexIds? ids;

  @JsonKey(name: 'image_thumbnail_url')
  String? imageThumbnailUrl;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'lineage')
  List<String>? lineage;

  @JsonKey(name: 'parent_publisher')
  String? parentPublisher;

  @JsonKey(name: 'roles')
  List<Role>? roles;

  @JsonKey(name: 'sources_api_url')
  String? sourcesApiUrl;

  @JsonKey(name: 'summary_stats')
  SummaryStats? summaryStats;

  @JsonKey(name: 'updated_date')
  String? updatedDate;

  @JsonKey(name: 'works_count')
  int? worksCount;

  Publisher({
    this.alternateTitles,
    this.citedByCount,
    this.countryCodes,
    this.countsByYear,
    this.createdDate,
    this.displayName,
    this.hierarchyLevel,
    this.id,
    this.ids,
    this.imageThumbnailUrl,
    this.imageUrl,
    this.lineage,
    this.parentPublisher,
    this.roles,
    this.sourcesApiUrl,
    this.summaryStats,
    this.updatedDate,
    this.worksCount,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) =>
      _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}

/*
Publisher object
Here are the fields in a publisher object. When you use the API to get a single publisher or lists of publishers, this is what's returned.
alternate_titles
List: A list of alternate titles for this publisher.
alternate_titles: [
  "Elsevier",
  "elsevier.com",
  "Elsevier Science",
  "Uitg. Elsevier",
"السفیر",
"السویر",
"انتشارات الزویر",
"لودویک السفیر",
  "爱思唯尔"
]
cited_by_count
Integer: The number of citations to works that are linked to this publisher through journals or other sources.
For example, if a publisher publishes 27 journals and those 27 journals have 3,050 works, this number is the sum of the cited_by_count values for all of those 3,050 works.
cited_by_count: 407508754
country_codes
List: The countries where the publisher is primarily located, as an .
country_codes: ["DE"]
counts_by_year
List: The values of  and  for each of the last ten years, binned by year. To put it another way: for every listed year, you can see how many new works are linked to this publisher, and how many times any work linked to this publisher was cited.
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
String: The date this Publisher object was created in the OpenAlex dataset, expressed as an  date string.
created_date: "2017-08-08"
display_name
String: The primary name of the publisher.
display_name: "Elsevier BV"
hierarchy_level
Integer: The hierarchy level for this publisher. A publisher with hierarchy level 0 has no parent publishers. A hierarchy level 1 publisher has one parent above it, and so on.
hierarchy_level: 1
id
String: The OpenAlex ID for this publisher.
id: "https://openalex.org/P4310320990"
ids
Object: All the external identifiers that we know about for this publisher. IDs are expressed as URIs whenever possible. Possible ID types:
openalex String: this publishers's ​
ror String: this publisher's ROR ID
wikidata String: this publisher's ​
ids: {
  openalex: "https://openalex.org/P4310320990",
  ror: "https://ror.org/02scfj030",
  wikidata: "https://www.wikidata.org/entity/Q746413"
},
image_thumbnail_url
String: Same as , but it's a smaller image.
This is usually a hotlink to a wikimedia image. You can change the width=300 parameter in the URL if you want a different thumbnail size.
image_thumbnail_url: "https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/MIT%20Press%20logo.svg&width=300"
image_url
String: URL where you can get an image representing this publisher. Usually this a hotlink to a Wikimedia image, and usually it's a seal or logo.
image_url: "https://commons.wikimedia.org/w/index.php?title=Special:Redirect/file/MIT%20Press%20logo.svg"
lineage
List:  of publishers. The list will include this publisher's ID, as well as any parent publishers. If this publisher's hierarchy_level is 0, this list will only contain its own ID.
id: "https://openalex.org/P4310321285",
...
hierarchy_level: 2,
lineage: [
    "https://openalex.org/P4310321285",
    "https://openalex.org/P4310319900",
    "https://openalex.org/P4310319965"
]
parent_publisher
String: An OpenAlex ID linking to the direct parent of the publisher. This will be null if the publisher's hierarchy_level is 0.
parent_publisher: "https://openalex.org/P4310311775"
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
sources_api_url
String: An URL that will get you a list of all the sources published by this publisher.
We express this as an API URL (instead of just listing the sources themselves) because there might be thousands of sources linked to a publisher, and that's too many to fit here.
sources_api_url: "https://api.openalex.org/sources?filter=host_organization.id:P4310319965"
summary_stats
Object: Citation metrics for this publisher
2yr_mean_citedness Float: The 2-year mean citedness for this publisher. Also known as .
h_index Integer: The  for this publisher.
i10_index Integer: The  for this publisher.
While the h-index and the i-10 index are normally author-level metrics and the 2-year mean citedness is normally a journal-level metric, they can be calculated for any set of papers, so we include them for publishers.
summary_stats: {
    2yr_mean_citedness: 5.065784263815827,
    h_index: 985,
    i10_index: 176682
}
updated_date
String: The last time anything in this publisher object changed, expressed as an  date string. This date is updated for any change at all, including increases in various counts.
updated_date: "2021-12-25T14:04:30.578837"
works_count
Integer: The number of works published by this publisher.
works_count: 13789818
 */
