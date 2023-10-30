import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/institution/dehydrated_institution.dart';
import 'package:openalex/models/institution/geo.dart';
import 'package:openalex/models/institution/international.dart';
import 'package:openalex/models/institution/repository.dart';
import 'package:openalex/models/institution/role.dart';
import 'package:openalex/models/institution/summary_stats.dart';
import 'package:openalex/models/institution/x_concept.dart';
import 'package:openalex/models/work/alex_ids.dart';

part 'institution.g.dart';

@JsonSerializable(explicitToJson: true)
class Institution {
  /// Institutions related to this one. Each associated institution is represented as a  object, with one extra property:
  @JsonKey(name: 'associated_institutions')
  List<DehydratedInstitution>? associatedInstitutions;

  /// The total number Works that cite a work created by an author affiliated with this institution. Or less formally: the number of citations this institution has collected.
  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  /// The country where this institution is located, represented as an ISO two-letter country code.
  @JsonKey(name: 'country_code')
  String? countryCode;

  /// Counts of works and citations for each of the last ten years, binned by year.
  /// To put it another way: each year, you can see how many new works this institution put out, and how many times any work affiliated with this institution got cited.
  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  /// The date this Institution object was created in the OpenAlex dataset, expressed as an ISO 8601 date string.
  @JsonKey(name: 'created_date')
  String? createdDate;

  /// The primary name of the institution.
  @JsonKey(name: 'display_name')
  String? displayName;

  /// Acronyms or initialisms that people sometimes use instead of the full display_name.
  @JsonKey(name: 'display_name_acronyms')
  List<String>? displayNameAcronyms;

  /// Other names people may use for this institution.
  @JsonKey(name: 'display_name_alternatives')
  List<String>? displayNameAlternatives;

  /// A bunch of stuff we know about the location of this institution:
  /// city (String): The city where this institution lives.
  /// geonames_city_id (String): The city where this institution lives, as a GeoNames database ID.
  /// region (String): The sub-national region (state, province) where this institution lives.
  /// country_code (String): The country where this institution lives, represented as an ISO two-letter country code.
  /// country (String): The country where this institution lives.
  /// latitude (Float): Does what it says.
  /// longitude (Float): Does what it says.
  @JsonKey(name: 'geo')
  Geo? geo;

  /// The URL for institution's primary homepage.
  @JsonKey(name: 'homepage_url')
  String? homepageUrl;

  /// The OpenAlex for this institution.
  String? id;

  /// All the external identifiers that we know about for this institution. IDs are expressed as URIs whenever possible. Possible ID types:
  @JsonKey(name: 'ids')
  AlexIds? ids;

  /// Same as image_url, but it's a smaller image.
  @JsonKey(name: 'image_thumbnail_url')
  String? imageThumbnailUrl;

  /// URL where you can get an image representing this institution. Usually this is hosted on Wikipedia, and usually it's a seal or logo.
  @JsonKey(name: 'image_url')
  String? imageUrl;

  /// The institution's display name in different languages. Derived from the wikipedia page for the institution in the given language.
  @JsonKey(name: 'international')
  International? international;

  /// Repositories ( with type: repository) that have this institution as their host_organization.
  @JsonKey(name: 'repositories')
  List<Repository>? repositories;

  /// List of role objects, which include the role (one of institution, funder, or publisher), the id (), and the works_count.
  @JsonKey(name: 'roles')
  List<Role>? roles;

  /// The ROR (Research Organization Registry) identifier is a globally unique ID for research organization. ROR is a community-led project to develop an open, sustainable, usable, and unique identifier for every research organization in the world.
  String? ror;

  /// Citation metrics for this institution
  @JsonKey(name: 'summary_stats')
  SummaryStats? summaryStats;

  /// The institution's primary type, using the OpenAlex vocabulary.
  String? type;

  /// The last time anything in this Institution changed, expressed as an ISO 8601 date string. This date is updated for any change at all, including increases in various counts.
  @JsonKey(name: 'updated_date')
  String? updatedDate;

  /// A URL that will get you a list of all the Works affiliated with this institution.
  @JsonKey(name: 'works_api_url')
  String? worksApiUrl;

  /// The number of Works created by authors affiliated with this institution. Or less formally: the number of works coming out of this institution.
  @JsonKey(name: 'works_count')
  int? worksCount;

  /// The Concepts most frequently applied to works affiliated with this institution. Each is represented as a Concept object, with one additional attribute:
  @JsonKey(name: 'x_concepts')
  List<XConcept>? xConcepts;

  Institution({
    this.associatedInstitutions,
    this.citedByCount,
    this.countryCode,
    this.countsByYear,
    this.createdDate,
    this.displayName,
    this.displayNameAcronyms,
    this.displayNameAlternatives,
    this.geo,
    this.homepageUrl,
    this.id,
    this.ids,
    this.imageThumbnailUrl,
    this.imageUrl,
    this.international,
    this.repositories,
    this.roles,
    this.ror,
    this.summaryStats,
    this.type,
    this.updatedDate,
    this.worksApiUrl,
    this.worksCount,
    this.xConcepts,
  });

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionToJson(this);
}

//* Institution object
// These are the fields in an institution object. When you use the API to get a  or , this is what's returned.
// associated_institutions
// List: Institutions related to this one. Each associated institution is represented as a  object, with one extra property:
// relationship (String): The type of relationship between this institution and the listed institution. Possible values: parent, child, and related.
// Institution associations and the relationship vocabulary come from .
// associated_institutions: [
//     {
//         id: "https://openalex.org/I2802101240",
//         ror: "https://ror.org/0483mr804",
//         display_name: "Carolinas Medical Center",
//         country_code: "US",
//         type: "healthcare",
//         relationship: "related"
//     },
//     {
//         id: "https://openalex.org/I69048370",
//         ror: "https://ror.org/01s91ey96",
//         display_name: "Renaissance Computing Institute",
//         country_code: "US",
//         type: "education",
//         relationship: "related"
//     },
//
//     // and so forth
// ]
// cited_by_count
// Integer: The total number  that cite a work created by an author affiliated with this institution. Or less formally: the number of citations this institution has collected.
// cited_by_count: 21199844
// country_code
// String: The country where this institution is located, represented as an .
// country_code: "US"
// counts_by_year
// List:  and  for each of the last ten years, binned by year. To put it another way: each year, you can see how many new works this institution put out, and how many times any work affiliated with this institution got cited.
// Years with zero citations and zero works have been removed so you will need to add those in if you need them.
// counts_by_year: [
//     {
//         year: 2022,
//         works_count: 133,
//         cited_by_count: 32731
//     },
//     {
//         year: 2021,
//         works_count: 12565,
//         cited_by_count: 2180827
//     },
//
//     // and so forth
// ]
// created_date
// String: The date this Institution object was created in the OpenAlex dataset, expressed as an  date string.
// created_date: "2017-08-08"
// display_name
// String: The primary name of the institution.
// display_name: "University of North Carolina at Chapel Hill"
// display_name_acronyms
// List: Acronyms or initialisms that people sometimes use instead of the full .
// display_name_acronyms:["UNC"]
// display_name_alternatives
// List: Other names people may use for this institution.
// display_name_alternatives: [
//     "UNC-Chapel Hill"
// ]
// geo
// Object: A bunch of stuff we know about the location of this institution:
// city (String): The city where this institution lives.
// geonames_city_id (String): The city where this institution lives, as a  ID.
// region (String): The sub-national region (state, province) where this institution lives.
// country_code (String): The country where this institution lives, represented as an .
// country (String): The country where this institution lives.
// latitude (Float): Does what it says.
// longitude (Float): Does what it says.
// geo: {
//     city: "Chapel Hill",
//     geonames_city_id: "4460162",
//     region: "North Carolina",
//     country_code: "US",
//     country: "United States",
//     latitude: 35.9083,
//     longitude: -79.0492
// }
// homepage_url
// String: The URL for institution's primary homepage.
// homepage_url: "http://www.unc.edu/"
// id
// String: The  for this institution.
// id: "https://openalex.org/I114027177"
// ids
// Object: All the external identifiers that we know about for this institution. IDs are expressed as URIs whenever possible. Possible ID types:
// grid (String: this institution's  )
// mag (Integer: this institution's  ID)
// openalex (String: this institution's . Same as )
// ror (String: this institution's ROR ID. Same as )
// wikipedia (String: this institution's Wikipedia page URL)
// wikidata (String: this institution's )
// Many institution are missing one or more ID types (either because we don't know the ID, or because it was never assigned). Keys for null IDs are not displayed.
// ids: {
//     openalex: "https://openalex.org/I114027177",
//     ror: "https://ror.org/0130frc33",
//     grid: "grid.10698.36",
//     wikipedia: "https://en.wikipedia.org/wiki/University%20of%20North%20Carolina%20at%20Chapel%20Hill",
//     wikidata: "https://www.wikidata.org/wiki/Q192334",
//     mag: 114027177
// }
// image_thumbnail_url
// String: Same as , but it's a smaller image.
// image_thumbnail_url: "https://upload.wikimedia.org/wikipedia/en/thumb/5/5c/University_of_North_Carolina_at_Chapel_Hill_seal.svg/100px-University_of_North_Carolina_at_Chapel_Hill_seal.svg.png"
// image_url
// String: URL where you can get an image representing this institution. Usually this is hosted on Wikipedia, and usually it's a seal or logo.
// image_url: "https://upload.wikimedia.org/wikipedia/en/5/5c/University_of_North_Carolina_at_Chapel_Hill_seal.svg"
// international
// Object: The institution's display name in different languages. Derived from the wikipedia page for the institution in the given language.
// display_name (Object)
// key (String): language code in  format. Full list of languages is .
// value (String): display_name in the given language
// international: {
//     display_name: {
//         "ar": "جامعة نورث كارولينا في تشابل هيل",
//         "en": "University of North Carolina at Chapel Hill",
//         "es": "Universidad de Carolina del Norte en Chapel Hill",
//         "zh-cn": "北卡罗来纳大学教堂山分校",
//         ...
//     }
// }
// repositories
// List: Repositories ( with type: repository) that have this institution as their ​
// repositories: [
//     {
//         id: "https://openalex.org/S4306402521",
//         display_name: "University of Minnesota Digital Conservancy (University of Minnesota)",
//         host_organization: "https://openalex.org/I130238516",
//         host_organization_name: "University of Minnesota",
//         host_organization_lineage: ["https://openalex.org/I130238516"]
//     }
//     // and so forth
// ]
// roles
// List: List of role objects, which include the role (one of institution, funder, or publisher), the id (), and the works_count.
// In many cases, a single organization does not fit neatly into one role. For example, Yale University is a single organization that is a research university, funds research studies, and publishes an academic journal. The roles property links the OpenAlex entities together for a single organization, and includes counts for the works associated with each role.
// The roles list of an entity (, , or ) always includes itself. In the case where an organization only has one role, the roles will be a list of length one, with itself as the only item.
// roles: [
//     {
//         role: "funder",
//         id: "https://openalex.org/F4320308380",
//         works_count: 1004,
//     },
//     {
//         role: "publisher",
//         id: "https://openalex.org/P4310315589",
//         works_count: 13986,
//     },
//     {
//         role: "institution",
//         id: "https://openalex.org/I32971472",
//         works_count: 250031,
//     }
// ]
// ror
// String: The  ID for this institution. This is the  for institutions.
// The ROR (Research Organization Registry) identifier is a globally unique ID for research organization. , which is no longer being updated.
// ror: "https://ror.org/0130frc33"
// summary_stats
// Object: Citation metrics for this institution
// 2yr_mean_citedness Float: The 2-year mean citedness for this institution. Also known as .
// h_index Integer: The  for this institution.
// i10_index Integer: The  for this institution.
// While the h-index and the i-10 index are normally author-level metrics and the 2-year mean citedness is normally a journal-level metric, they can be calculated for any set of papers, so we include them for institutions.
// summary_stats: {
//     2yr_mean_citedness: 5.065784263815827,
//     h_index: 985,
//     i10_index: 176682
// }
// type
// String: The institution's primary type, using the .
// Possible values are: Education, Healthcare, Company, Archive, Nonprofit, Government, Facility, and Other.
// type: "education"
// updated_date
// String: The last time anything in this Institution changed, expressed as an  date string. This date is updated for any change at all, including increases in various counts.
// updated_date: "2022-01-02T00:27:23.088909"
// works_api_url
// String: A URL that will get you a list of all the  affiliated with this institution.
// We express this as an API URL (instead of just listing the Works themselves) because most institutions have way too many works to reasonably fit into a single return object.
// works_api_url: "https://api.openalex.org/works?filter=institutions.id:I114027177"
// works_count
// Integer: The number of  created by authors affiliated with this institution. Or less formally: the number of works coming out of this institution.
// works_count: 202704
// x_concepts
// The "x" in x_concepts is because it's experimental and subject to removal with very little warning. We plan to replace it with a custom link to the Concepts API endpoint.
// List: The  most frequently applied to works affiliated with this institution. Each is represented as a  object, with one additional attribute:
// score (Float): The strength of association between this institution and the listed concept, from 0-100.
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
// The DehydratedInstitution object
// The DehydratedInstitution is stripped-down  object, with most of its properties removed to save weight. Its only remaining properties are:
// [`country_code`](institution-object.md#country\_code)
// [`display_name`](institution-object.md#display\_name)
// [`id`](institution-object.md#id)
// [`ror`](institution-object.md#ror)
// [`type`](institution-object.md#type) *//
