import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/concept/dehydrated_concept.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/institution/international.dart';
import 'package:openalex/models/institution/summary_stats.dart';
import 'package:openalex/models/work/alex_ids.dart';

part 'concept.g.dart';

@JsonSerializable(explicitToJson: true)
class Concept {
  @JsonKey(name: 'ancestors')
  List<DehydratedConcept>? ancestors;

  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  @JsonKey(name: 'created_date')
  String? createdDate;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'display_name')
  String? displayName;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'ids')
  AlexIds? ids;

  @JsonKey(name: 'image_thumbnail_url')
  String? imageThumbnailUrl;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'international')
  International? international;

  @JsonKey(name: 'level')
  int? level;

  @JsonKey(name: 'related_concepts')
  List<DehydratedConcept>? relatedConcepts;

  @JsonKey(name: 'summary_stats')
  SummaryStats? summaryStats;

  @JsonKey(name: 'updated_date')
  String? updatedDate;

  @JsonKey(name: 'wikidata')
  String? wikidata;

  @JsonKey(name: 'works_api_url')
  String? worksApiUrl;

  @JsonKey(name: 'works_count')
  int? worksCount;

  Concept({
    this.ancestors,
    this.citedByCount,
    this.countsByYear,
    this.createdDate,
    this.description,
    this.displayName,
    this.id,
    this.ids,
    this.imageThumbnailUrl,
    this.imageUrl,
    this.international,
    this.level,
    this.relatedConcepts,
    this.summaryStats,
    this.updatedDate,
    this.wikidata,
    this.worksApiUrl,
    this.worksCount,
  });

  factory Concept.fromJson(Map<String, dynamic> json) =>
      _$ConceptFromJson(json);

  Map<String, dynamic> toJson() => _$ConceptToJson(this);
}

/*
Concept object
These are the fields in a concept object. When you use the API to get a  or , this is what's returned.
ancestors
List: List of concepts that this concept descends from, as  objects. See the  for more details on how the different layers of concepts work together.
ancestors: [
    {
        id: "https://openalex.org/C2522767166",
        wikidata: "https://www.wikidata.org/wiki/Q2374463",
        display_name: "Data science",
        level: 1
    },
    {
        id: "https://openalex.org/C161191863",
        wikidata: "https://www.wikidata.org/wiki/Q199655",
        display_name: "Library science",
        level: 1
    },

    // and so forth
]
cited_by_count
Integer: The number citations to works that have been tagged with this concept. Or less formally: the number of citations to this concept.
For example, if there are just two works tagged with this concept and one of them has been cited 10 times, and the other has been cited 1 time, cited_by_count for this concept would be 11.
cited_by_count: 20248
counts_by_year
List: The values of  and  for each of the last ten years, binned by year. To put it another way: for every listed year, you can see how many new works were tagged with this concept, and how many times any work tagged with this concept got cited.
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
String: The date this Concept object was created in the OpenAlex dataset, expressed as an  date string.
created_date: "2017-08-08"
description
String: A brief description of this concept.
description: "study of alternative metrics for analyzing and informing scholarship"
display_name
String: The English-language label of the concept.
display_name: "Altmetrics"
id
String: The OpenAlex ID for this concept.
id: "https://openalex.org/C2778407487"
ids
Object: All the external identifiers that we know about for this institution. IDs are expressed as URIs whenever possible. Possible ID types:
mag (Integer: this concept's  ID)
openalex (String: this concept's . Same as )
umls_cui (List: this concept's  )
umls_aui (List: this concept's  )
wikidata (String: this concept's . Same as )
wikipedia (String: this concept's Wikipedia page URL)
Many concepts are missing one or more ID types (either because we don't know the ID, or because it was never assigned). Keys for null IDs are not displayed..
ids: {
    openalex: "https://openalex.org/C2778407487",
    wikidata: "https://www.wikidata.org/wiki/Q14565201",
    wikipedia: "https://en.wikipedia.org/wiki/Altmetrics",
    mag: 2778407487114027177
}
image_thumbnail_url
String: Same as , but it's a smaller image.
image_thumbnail_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Altmetrics.svg/100px-Altmetrics.svg.png"
image_url
String: URL where you can get an image representing this concept, where available. Usually this is hosted on Wikipedia.
image_url: "https://upload.wikimedia.org/wikipedia/commons/f/f1/Altmetrics.svg"
international
Object: This concept's display name in many languages, derived from article titles on each language's wikipedia. See the  for "Java Bytecode" for example source data.
display_name (Object)
key (String): language code in  format. Full list of languages is .
value (String): display_name in the given language
international: {
    display_name: {
        ca: "Altmetrics",
        ...
    }
}
level
Integer: The level in the concept tree where this concept lives. Lower-level concepts are more general, and higher-level concepts are more specific.  has a level of 0;  has a level of 5. Level 0 concepts have no ancestors and level 5 concepts have no descendants.
level: 2
related_concepts
List: Concepts that are similar to this one. Each listed concept is a  object, with one additional attribute:
score (Float): The strength of association between this concept and the listed concept, on a scale of 0-100.
related_concepts: [
    {
        id: "https://openalex.org/C2778793908",
        wikidata: null,
        display_name: "Citation impact",
        level: 3,
        score: 4.56749
    },
    {
        id: "https://openalex.org/C2779455604",
        wikidata: null,
        display_name: "Impact factor",
        level: 2,
        score: 4.46396
    }

    // and so forth
]
summary_stats
Object: Citation metrics for this concept
2yr_mean_citedness Float: The 2-year mean citedness for this concept. Also known as .
h_index Integer: The  for this concept.
i10_index Integer: The  for this concept.
While the h-index and the i-10 index are normally author-level metrics and the 2-year mean citedness is normally a journal-level metric, they can be calculated for any set of papers, so we include them for concepts.
summary_stats: {
    2yr_mean_citedness: 1.5295340589458237,
    h_index: 105,
    i10_index: 5045
}
updated_date
String: The last time anything in this concept object changed, expressed as an  date string. This date is updated for any change at all, including increases in various counts.
updated_date: "2021-12-25T14:04:30.578837"
wikidata
String: The  for this concept. This is the  for concepts.
All OpenAlex concepts have a Wikidata ID, because all OpenAlex concepts are also Wikidata concepts.
wikidata: "https://www.wikidata.org/wiki/Q14565201"
works_api_url
String: An URL that will get you a list of all the works tagged with this concept.
We express this as an API URL (instead of just listing the works themselves) because there might be millions of works tagged with this concept, and that's too many to fit here.
works_api_url: "https://api.openalex.org/works?filter=concept.id:C2778407487"
works_count
Integer: The number of works tagged with this concept.
works_count: 3078
The DehydratedConcept object
The DehydratedConcept is stripped-down  object, with most of its properties removed to save weight. Its only remaining properties are:
[`display_name`](concept-object.md#display\_name)
[`id`](concept-object.md#id)
[`level`](concept-object.md#level)
[`wikidata`](concept-object.md#wikidata)
 */
