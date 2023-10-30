import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/concept/dehydrated_concept.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/institution/summary_stats.dart';
import 'package:openalex/models/source/apc_price.dart';
import 'package:openalex/models/source/society.dart';
import 'package:openalex/models/work/alex_ids.dart';

part 'source.g.dart';

@JsonSerializable(explicitToJson: true)
class Source {
  @JsonKey(name: 'abbreviated_title')
  String? abbreviatedTitle;

  @JsonKey(name: 'alternate_titles')
  List<String>? alternateTitles;

  @JsonKey(name: 'apc_prices')
  List<ApcPrice>? apcPrices;

  @JsonKey(name: 'apc_usd')
  int? apcUsd;

  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  @JsonKey(name: 'country_code')
  String? countryCode;

  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  @JsonKey(name: 'created_date')
  String? createdDate;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'homepage_url')
  String? homepageUrl;

  @JsonKey(name: 'host_organization')
  String? hostOrganization;

  @JsonKey(name: 'host_organization_lineage')
  List<String>? hostOrganizationLineage;

  @JsonKey(name: 'host_organization_name')
  String? hostOrganizationName;

  String? id;

  @JsonKey(name: 'ids')
  AlexIds? ids;

  @JsonKey(name: 'is_in_doaj')
  bool? isInDoaj;

  @JsonKey(name: 'is_oa')
  bool? isOa;

  List<String>? issn;

  @JsonKey(name: 'issn_l')
  String? issnL;

  List<Society>? societies;

  @JsonKey(name: 'summary_stats')
  SummaryStats? summaryStats;

  String? type;

  @JsonKey(name: 'updated_date')
  String? updatedDate;

  @JsonKey(name: 'works_api_url')
  String? worksApiUrl;

  @JsonKey(name: 'works_count')
  int? worksCount;

  @JsonKey(name: 'x_concepts')
  List<DehydratedConcept>? xConcepts;

  Source({
    this.abbreviatedTitle,
    this.alternateTitles,
    this.apcPrices,
    this.apcUsd,
    this.citedByCount,
    this.countryCode,
    this.countsByYear,
    this.createdDate,
    this.displayName,
    this.homepageUrl,
    this.hostOrganization,
    this.hostOrganizationLineage,
    this.hostOrganizationName,
    this.id,
    this.ids,
    this.isInDoaj,
    this.isOa,
    this.issn,
    this.issnL,
    this.societies,
    this.summaryStats,
    this.type,
    this.updatedDate,
    this.worksApiUrl,
    this.worksCount,
    this.xConcepts,
  });

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

//* Source object
// These are the fields in a source object. When you use the API to get a single source or lists of sources, this is what's returned.
// abbreviated_title
// String: An abbreviated title obtained from the .
// abbreviated_title: "J. addict. med. ther. sci."
// alternate_titles
// Array: Alternate titles for this source, as obtained from the  and individual work records, like Crossref DOIs, that carry the source name as a string. These are commonly abbreviations or translations of the source's canonical name.
// alternate_titles: [
//    "ACRJ"
// ]
// apc_prices
// List: List of objects, each with price (Integer) and currency (String).
// Article processing charge information, taken directly from .
// apc_prices: [
//     {
//         price: 3920,
//         currency: "GBP"
//     }
// ]
// apc_usd
// Integer: The source's article processing charge in US Dollars, if available from .
// The apc_usd value is calculated by taking the APC price (see ) with a currency of USD if it is available. If it's not available, we convert the first available value from apc_prices into USD, using recent exchange rates.
// apc_usd: 5200
// cited_by_count
// Integer: The total number of  that cite a Work hosted in this source.
// cited_by_count: 133702
// country_code
// String: The country that this source is associated with, represented as an .
// country_code: "GB"
// counts_by_year
// List:  and  for each of the last ten years, binned by year. To put it another way: each year, you can see how many new works this source started hosting, and how many times any work in this source got cited.
// If the source was founded less than ten years ago, there will naturally be fewer than ten years in this list. Years with zero citations and zero works have been removed so you will need to add those in if you need them.
// counts_by_year: [
//     {
//         year: 2021,
//         works_count: 4338,
//         cited_by_count: 127268
//     },
//     {
//         year: 2020,
//         works_count: 4363,
//         cited_by_count: 119531
//     },
//
//     // and so forth
// ]
// created_date
// String: The date this Source object was created in the OpenAlex dataset, expressed as an  date string.
// created_date: "2017-08-08"
// display_name
// String: The name of the source.
// display_name: "PeerJ"
// homepage_url
// String: The starting page for navigating the contents of this source; the homepage for this source's website.
// homepage_url: "http://www.peerj.com/"
// host_organization
// String: The host organization for this source as an . This will be an  if the source is a repository, and a  if the source is a journal, conference, or eBook platform (based on the  field).
// id: "https://openalex.org/P4310320595"
// host_organization_lineage
// List:  — See . This will only be included if the  is a publisher (and not if the host_organization is an institution).
// host_organization_lineage: [
//     "https://openalex.org/P4310321285",
//     "https://openalex.org/P4310319900",
//     "https://openalex.org/P4310319965"
// ]
// host_organization_name
// String: The display_name from the , shown for convenience.
// host_organization_name: "Elsevier BV"
// id
// String: The  for this source.
// id: "https://openalex.org/S1983995261"
// ids
// Object: All the external identifiers that we know about for this source. IDs are expressed as URIs whenever possible. Possible ID types:
// fatcat (String: this source's  ID)
// issn (List: a list of this source's ISSNs. Same as )
// issn_l (String: this source's ISSN-L. Same as )
// mag (Integer: this source's  ID)
// openalex (String: this source's . Same as )
// wikidata (String: this source's  ID)
// Many sources are missing one or more ID types (either because we don't know the ID, or because it was never assigned). Keys for null IDs are not displayed.
// Example
// is_in_doaj
// Boolean: Whether this is a journal listed in the  (DOAJ). ****
// is_in_doaj: true
// is_oa
// Boolean: Whether this is currently fully-open-access source. This could be true for a preprint repository where everything uploaded is free to read, or for a  or  open access journal, where all newly published Works are available for free under an open license.
// We say "currently" because the status of a source can change over time. It's common for journals to "flip" to Gold OA, after which they may make only future articles open or also open their back catalogs. It's entirely possible for a source to say is_oa: true, but for an article from last year to require a subscription.
// is_oa: true
// issn
// List: The  used by this source. Many publications have multiple ISSNs (), so  should be used when possible.
// issn: ["2167-8359"]
// issn_l
// String: The  identifying this source. This is the  for sources.
// ISSN is a global and unique ID for serial publications. However, different media versions of a given publication (e.g., print and electronic) often have different ISSNs. This is why we can't have nice things. The ISSN-L or Linking ISSN solves the problem by designating a single canonical ISSN for all media versions of the title. It's usually the same as the print ISSN.
// issn_l: "2167-8359"
// societies
// Array: Societies on whose behalf the source is published and maintained, obtained from our . Thanks!
// societies: [
//     {
//         "url": "http://www.counseling.org/",
//         "organization": "American Counseling Association on behalf of the American College Counseling Association"
//     }
// ]
// summary_stats
// Object: Citation metrics for this source
// 2yr_mean_citedness Float: The 2-year mean citedness for this source. Also known as .
// h_index Integer: The  for this source.
// i10_index Integer: The  for this source.
// While the h-index and the i-10 index are normally author-level metrics, they can be calculated for any set of papers, so we include them for sources.
// summary_stats: {
//     2yr_mean_citedness: 1.5295340589458237,
//     h_index: 105,
//     i10_index: 5045
// }
// type
// String: The type of source, which will be one of: journal, repository, conference, ebook platform, or book series.
// type: "journal"
// updated_date
// String: The last time anything in this Source object changed, expressed as an  date string. This date is updated for any change at all, including increases in various counts.
// updated_date: "2022-01-02T00:00:00"
// works_api_url
// String: A URL that will get you a list of all this source's Works.
// We express this as an API URL (instead of just listing the works themselves) because sometimes a source's publication list is too long to reasonably fit into a single Source object.
// works_api_url: "https://api.openalex.org/works?filter=primary_location.source.id:S1983995261",
// works_count
// Integer: The number of  this source hosts.
// works_count: 20184
// x_concepts
// The "x" in x_concepts is because it's experimental and subject to removal with very little warning. We plan to replace it with a custom link to the Concepts API endpoint.
// List: The Concepts most frequently applied to works hosted by this source. Each is represented as a  object, with one additional attribute:
// score (Float): The strength of association between this source and the listed concept, from 0-100.
// x_concepts: [
//     {
//         id: "https://openalex.org/C86803240",
//         wikidata: null,
//         display_name: "Biology",
//         level: 0,
//         score: 86.7
//     },
//     {
//         id: "https://openalex.org/C185592680",
//         wikidata: null,
//         display_name: "Chemistry",
//         level: 0,
//         score: 51.4
//     },
//
//     // and so forth
// ]
// The DehydratedSource object
// The DehydratedSource is stripped-down Source object, with most of its properties removed to save weight. Its only remaining properties are:
// ​​
// ​​
// ​​
// ​​
// ​​
// ​​
// ​​
// ​​
// ​​
// ​​
//*
