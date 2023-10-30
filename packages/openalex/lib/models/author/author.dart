import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/concept/dehydrated_concept.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/institution/dehydrated_institution.dart';
import 'package:openalex/models/institution/summary_stats.dart';
import 'package:openalex/models/work/alex_ids.dart';

part 'author.g.dart';

@JsonSerializable(explicitToJson: true)
class Author {
  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  @JsonKey(name: 'created_date')
  String? createdDate;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'display_name_alternatives')
  List<String>? displayNameAlternatives;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'ids')
  AlexIds? ids;

  @JsonKey(name: 'last_known_institution')
  DehydratedInstitution? lastKnownInstitution;

  @JsonKey(name: 'orcid')
  String? orcid;

  @JsonKey(name: 'summary_stats')
  SummaryStats? summaryStats;

  @JsonKey(name: 'updated_date')
  String? updatedDate;

  @JsonKey(name: 'works_api_url')
  String? worksApiUrl;

  @JsonKey(name: 'works_count')
  int? worksCount;

  @JsonKey(name: 'x_concepts')
  List<DehydratedConcept>? xConcepts;

  Author({
    this.citedByCount,
    this.countsByYear,
    this.createdDate,
    this.displayName,
    this.displayNameAlternatives,
    this.id,
    this.ids,
    this.lastKnownInstitution,
    this.orcid,
    this.summaryStats,
    this.updatedDate,
    this.worksApiUrl,
    this.worksCount,
    this.xConcepts,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

/*
Author object
When you use the API to get a  or , this is what's returned.
cited_by_count
Integer: The total number
📄
  that cite a work this author has created.
cited_by_count: 38
counts_by_year
List:  and  for each of the last ten years, binned by year. To put it another way: each year, you can see how many works this author published, and how many times they got cited.
Any works or citations older than ten years old aren't included. Years with zero works and zero citations have been removed so you will need to add those in if you need them.
counts_by_year: [
    {
        year: 2022,
        works_count: 0,
        cited_by_count: 8
    },
    {
        year: 2021,
        works_count: 1,
        cited_by_count: 252
    },
    ...
    {
        year: 2012,
        works_count: 7,
        cited_by_count: 79
    }
]
created_date
String: The date this Author object was created in the OpenAlex dataset, expressed as an  date string.
created_date: "2017-08-08"
display_name
String: The name of the author as a single string.
display_name: "Jason Priem"
display_name_alternatives
List: Other ways that we've found this author's name displayed.
display_name_alternatives: [
    "Jason R Priem"
]
id
String: The OpenAlex ID for this author.
id: "https://openalex.org/A2208157607"
ids
Object: All the external identifiers that we know about for this author. IDs are expressed as URIs whenever possible. Possible ID types:
mag (Integer: this author's  ID)
openalex (String: this author's . Same as )
orcid (String: this author's  . Same as )
scopus (String: this author's )
twitter (String: this author's Twitter handle)
wikipedia (String: this author's Wikipedia page)
Most authors are missing one or more ID types (either because we don't know the ID, or because it was never assigned). Keys for null IDs are not displayed.
ids: {
    openalex: "https://openalex.org/A2208157607",
    orcid: "https://orcid.org/0000-0001-6187-6610",
    scopus: "http://www.scopus.com/inward/authorDetails.url?authorID=36455008000&partnerID=MN8TOARS",
    mag: 2208157607
},
last_known_institution
Object: This author's last known institutional affiliation. In this context "last known" means that we took all the  where this author has an institutional affiliation, sorted them by publication date, and selected the most recent one.
This is a  object, and you can find more documentation on the  page.
last_known_institution: {
    id: "https://openalex.org/I4200000001",
    ror: "https://ror.org/02nr0ka47",
    display_name: "OurResearch",
    country_code: "CA",
    type: "nonprofit"
},
orcid
String: The   for this author. ORCID is a global and unique ID for authors. This is the  for authors.
Compared to other Canonical IDs, ORCID coverage is relatively low in OpenAlex, because ORCID adoption in the wild has been slow compared with DOI, for example. This is particularly an issue when dealing with older works and authors.
orcid: "https://orcid.org/0000-0001-6187-6610"
summary_stats
Object: Citation metrics for this author
2yr_mean_citedness Float: The 2-year mean citedness for this author. Also known as .
h_index Integer: The  for this author.
i10_index Integer: The  for this author.
While the 2-year mean citedness is normally a journal-level metric, it can be calculated for any set of papers, so we include it for authors.
summary_stats: {
    2yr_mean_citedness: 1.5295340589458237,
    h_index: 45,
    i10_index: 205
}
updated_date
String: The last time anything in this author object changed, expressed as an  date string. This date is updated for any change at all, including increases in various counts.
updated_date: "2022-01-02T00:00:00"
works_api_url
String: A URL that will get you a list of all this author's works.
We express this as an API URL (instead of just listing the works themselves) because sometimes an author's publication list is too long to reasonably fit into a single author object.
works_api_url: "https://api.openalex.org/works?filter=author.id:A2208157607",
works_count
Integer: The number of
📄
  this this author has created.
works_count: 38
This is updated a couple times per day. So the count may be slightly different than what's in works when viewed .
x_concepts
The "x" in x_concepts is because it's experimental and subject to removal with very little warning. We plan to replace it with a custom link to the Concepts API endpoint.
List: The concepts most frequently applied to works created by this author. Each is represented as a  object, with one additional attribute:
score (Float): The strength of association between this author and the listed concept, from 0-100.
x_concepts: [
    {
        id: "https://openalex.org/C41008148",
        wikidata: null,
        display_name: "Computer science",
        level: 0,
        score: 97.4
    },
    {
        id: "https://openalex.org/C17744445",
        wikidata: null,
        display_name: "Political science",
        level: 0,
        score: 78.9
    }
]
The DehydratedAuthor object
The DehydratedAuthor is stripped-down  object, with most of its properties removed to save weight. Its only remaining properties are:
[`id`](author-object.md#id)
[`display_name`](author-object.md#display\_name)
[`orcid`](author-object.md#orcid)
 */
