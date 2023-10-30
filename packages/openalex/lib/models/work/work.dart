import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/concept/concept.dart';
import 'package:openalex/models/institution/counts_by_year.dart';
import 'package:openalex/models/work/alex_ids.dart';
import 'package:openalex/models/work/apc_list.dart';
import 'package:openalex/models/work/apc_paid.dart';
import 'package:openalex/models/work/authorship.dart';
import 'package:openalex/models/work/grant.dart';
import 'package:openalex/models/work/location.dart';
import 'package:openalex/models/work/mesh.dart';
import 'package:openalex/models/work/open_access.dart';
import 'package:openalex/models/work/sustainable_goal.dart';

import 'biblio.dart';

part 'work.g.dart';

@JsonSerializable(explicitToJson: true)
class Work {
  /// The abstract of the work, as an inverted index, which encodes information about the abstract's words and
  /// their positions within the text. Like Microsoft Academic Graph, OpenAlex doesn't include plaintext abstracts due to legal constraints.
  ///
  /// Newer works are more likely to have an abstract inverted index. For example, over 60% of works in 2022 have abstract data, compared to 45% for works older than 2000.
  @JsonKey(name: 'abstract_inverted_index')
  Map<String, List<int>>? abstractInvertedIndex;

  /// List of Authorship objects, each representing an author and their institution. Limited to the first 100 authors to maintain API performance.
  List<Authorship>? authorships;

  /// Information about this work's APC (article processing charge). The object contains:
  /// - value: Integer
  /// - currency: String
  /// - provenance: String — the source of this data. Currently the only value is “doaj” (DOAJ)
  /// - value_usd: Integer — the APC converted into USD
  /// This value is the APC list price–the price as listed by the journal’s publisher. That’s not always the price actually paid,
  /// because publishers may offer various discounts to authors. Unfortunately we don’t always know this discounted price, but when we do you can find it in apc_paid.
  /// Currently our only source for this data is DOAJ, and so doaj is the only value for apc_list.provenance, but we’ll add other sources over time.
  /// We currently don’t have information on the list price for hybrid journals (toll-access journals that also provide an open-access option),
  /// but we will add this at some point. We do have apc_paid information for hybrid OA works occasionally.
  /// You can use this attribute to find works published in Diamond open access journals by looking at works where apc_list.value is zero. See open_access.oa_status for more info.
  @JsonKey(name: 'apc_list')
  ApcList? apcList;

  /// Information about the paid APC (article processing charge) for this work. The object contains:
  /// value: Integer
  /// currency: String
  /// provenance: String — currently either openapc or doaj, but more will be added; see below for details.
  /// value_usd: Integer — the APC converted into USD
  /// You can find the listed APC price (when we know it) for a given work using apc_list. However, authors don’t always pay the listed price;
  /// often they get a discounted price from publishers. So it’s useful to know the APC actually paid by authors, as distinct from the list price. This is our effort to provide this.
  /// Our best source for the actually paid price is the OpenAPC project. Where available, we use that data, and so apc_paid.provenance is openapc.
  /// Where OpenAPC data is unavailable (and unfortunately this is common) we make our best guess by assuming the author paid the APC list price, and apc_paid.provenance will be set to wherever we got the list price from.
  @JsonKey(name: 'apc_paid')
  ApcPaid? apcPaid;

  /// A Location object with the best available open access location for this work.
  /// We score open locations to determine which is best using these factors:
  /// 1. Must have is_oa: true
  /// 2. type_:_ "publisher" is better than "repository".
  /// 3. version: "publishedVersion" is better than "acceptedVersion", which is better than "submittedVersion".
  /// 4. pdf_url: A location with a direct PDF link is better than one without.
  /// 5. repository rankings: Some major repositories like PubMed Central and arXiv are ranked above others.
  @JsonKey(name: 'best_oa_location')
  Location? bestOALocation;

  /// Old-timey bibliographic info for this work. This is mostly useful only in citation/reference contexts. These are all strings because sometimes you'll get fun values like "Spring" and "Inside cover."
  Biblio? biblio;

  /// A URL that uses the cites filter to display a list of works that cite this work. This is a way to expand cited_by_count into an actual list of works.
  @JsonKey(name: 'cited_by_api_url')
  String? citedByApiUrl;

  /// The number of citations to this work. These are the times that other works have cited this work: Other works ➞ This work.
  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  /// List of dehydrated Concept objects.
  /// Each Concept object in the list also has one additional property:
  /// score (Float): The strength of the connection between the work and this concept (higher is stronger). This number is produced by AWS Sagemaker, in the last layer of the machine learning model that assigns concepts.
  /// Concepts with a score of at least 0.3 are assigned to the work. However, ancestors of an assigned concept are also added to the work, even if the ancestor scores are below 0.3.
  ///
  /// Because all ancestor concepts are assigned to the work, you may see concepts in works with very low scores, even some zero scores.
  @JsonKey(name: 'concepts')
  List<Concept>? concepts;

  /// OpenAlex IDs of any authors for which authorships.is_corresponding is true.
  @JsonKey(name: 'corresponding_author_ids')
  List<String>? correspondingAuthorIds;

  /// OpenAlex IDs of any institutions found within an authorship for which authorships.is_corresponding is true.
  @JsonKey(name: 'corresponding_institution_ids')
  List<String>? correspondingInstitutionIds;

  /// Number of distinct country_codes among the authorships for this work.
  @JsonKey(name: 'countries_distinct_count')
  int? countriesDistinctCount;

  /// Works.cited_by_count for each of the last ten years, binned by year. To put it another way: each year, you can see how many times this work was cited.
  /// Any citations older than ten years old aren't included. Years with zero citations have been removed so you will need to add those in if you need them.
  @JsonKey(name: 'counts_by_year')
  List<CountByYear>? countsByYear;

  /// The date this Work object was created in the OpenAlex dataset, expressed as an ISO 8601 date string.
  @JsonKey(name: 'created_date')
  DateTime? createdDate;

  /// Exactly the same as Work.title. It's useful for Works to include a display_name property, since all the other entities have one.
  @JsonKey(name: 'display_name')
  String? displayName;

  /// The DOI for the work. This is the Canonical External ID for works.
  /// Occasionally, a work has more than one DOI--for example, there might be one DOI for a preprint version hosted on bioRxiv, and another DOI for the published version.
  /// However, this field always has just one DOI, the DOI for the published work.
  String? doi;

  /// List of grant objects, which include the Funder and the award ID, if available. Our grants data comes from Crossref, and is currently fairly limited.
  List<Grant>? grants;

  /// The OpenAlex ID for this work.
  String? id;

  /// All the external identifiers that we know about for this work. IDs are expressed as URIs whenever possible. Possible ID types:
  /// doi (String: The DOI. Same as Work.doi)
  /// mag (Integer: the Microsoft Academic Graph ID)
  /// openalex (String: The OpenAlex ID. Same as Work.id)
  /// pmid (String: The Pubmed Identifier)
  /// pmcid (String: the Pubmed Central identifier)
  AlexIds? ids;

  /// Number of distinct institutions among the authorships for this work.
  @JsonKey(name: 'institutions_distinct_count')
  int? institutionsDistinctCount;

  /// Set to true if the work hosted here can be read for free, without registration.
  @JsonKey(name: 'is_oa')
  bool? isOA;

  /// True if we think this work is paratext.
  /// In our context, paratext is stuff that's in scholarly venue (like a journal) but is about the venue rather than a scholarly work properly speaking. Some examples and nonexamples:
  /// - yep it's paratext: front cover, back cover, table of contents, editorial board listing, issue information, masthead.
  /// - no, not paratext: research paper, dataset, letters to the editor, figures
  /// Turns out there is a lot of paratext in registries like Crossref. That's not a bad thing... but we've found that it's good to have a way to filter it out.
  /// We determine is_paratext algorithmically using title heuristics.
  @JsonKey(name: 'is_paratext')
  bool? isParatext;

  /// True if we know this work has been retracted.
  /// This field has high precision but low recall. In other words, if is_retracted is true, the article is definitely retracted.
  /// But if is_retracted is False, it still might be retracted, but we just don't know. This is because unfortunately, the open sources for retraction data aren't currently very comprehensive, and the more comprehensive ones aren't sufficiently open for us to use here.
  @JsonKey(name: 'is_retracted')
  bool? isRetracted;

  /// The language of the work in ISO 639-1 format. The language is automatically detected using the information we have about the work. We use the langdetect software library on the words in the work's abstract, or the title if we do not have the abstract. The source code for this procedure is here. Keep in mind that this method is not perfect, and that in some cases the language of the title or abstract could be different from the body of the work.
  /// A few things to keep in mind about this:
  /// We don't always assign a language if we do not have enough words available to accurately guess.
  /// We report the language of the metadata, not the full text. For example, if a work is in French, but the title and abstract are in English, we report the language as English.
  /// In some cases, abstracts are in two different languages. Unfortunately, when this happens, what we report will not be accurate.
  String? language;

  /// The license applied to this work at this host. Most toll-access works don't have an explicit license (they're under "all rights reserved" copyright), so this field generally has content only if is_oa is true.
  String? license;

  /// A list of Location objects describing all unique places where this work lives.
  List<Location>? locations;

  /// Number of locations for this work.
  @JsonKey(name: 'locations_count')
  int? locationsCount;

  /// List of MeSH tag objects. Only works found in PubMed have MeSH tags; for all other works, this is an empty list.
  List<MeSH>? mesh;

  ///  It lists groups of words and phrases (n-grams) that make up a work, as obtained from the Internet Archive. See The Ngram object and Get N-grams for background on n-grams, how we use them, and what this API call returns.
  @JsonKey(name: 'ngrams_url')
  String? ngramsUrl;

  /// Information about the access status of this work, as an OpenAccess object.
  @JsonKey(name: 'open_access')
  OpenAccess? openAccess;

  /// A Location object with the primary location of this work.
  /// The primary_location is where you can find the best (closest to the version of record) copy of this work. For a peer-reviewed journal article,
  /// this would be a full text published version, hosted by the publisher at the article's DOI URL.
  @JsonKey(name: 'primary_location')
  Location? primaryLocation;

  /// The day when this work was published, formatted as an ISO 8601 date.
  /// Where different publication dates exist, we select the earliest available date of electronic publication.
  /// This date applies to the version found at Work.url. The other versions, found in Work.locations, may have been published at different (earlier) dates.
  @JsonKey(name: 'publication_date')
  DateTime? publicationDate;

  /// The year this work was published.
  /// This year applies to the version found at Work.url. The other versions, found in Work.locations, may have been published in different (earlier) years.
  @JsonKey(name: 'publication_year')
  int? publicationYear;

  /// OpenAlex IDs for works that this work cites. These are citations that go from this work out to another work: This work ➞ Other works.
  @JsonKey(name: 'referenced_works')
  List<String>? referencedWorks;

  /// OpenAlex IDs for works related to this work. Related works are computed algorithmically; the algorithm finds recent papers with the most concepts in common with the current paper.
  @JsonKey(name: 'related_works')
  List<String>? relatedWorks;

  /// The United Nations' 17 Sustainable Development Goals are a collection of goals at the heart of a global "shared blueprint for peace and prosperity for people and the planet." We use a machine learning model to tag works with their relevance to these goals based on our OpenAlex SDG Classifier, an mBERT machine learning model developed by the Aurora Universities Network, trained on Elsevier data. The score represents the model's predicted probability of the work's relevance for a particular goal.
  @JsonKey(name: 'sustainable_development_goals')
  List<SustainableGoal>? sustainableDevelopmentGoals;

  /// The title of the work.
  String? title;

  /// The type of the work.
  /// You can see all of the different types along with their counts in the OpenAlex api here: https://api.openalex.org/works?group_by=type.
  /// Most works are type article. This includes what was formerly (and currently in type_crossref) labeled as journal-article, proceedings-article, and posted-content. We consider all of these to be article type works, and the distinctions between them to be more about where they are published or hosted:
  /// Journal articles will have a primary_location.source.type of journal
  /// Conference proceedings will have a primary_location.source.type of conference
  /// Preprints or "posted content" will have a primary_location.version of submittedVersion
  /// (Note that distinguishing between journals and conferences is a hard problem, one we often get wrong. We are working on improving this, but we also point out that the two have a lot of overlap in terms of their roles as hosts of research publications.)
  /// So, here is how you can filter for only non-preprint articles:
  /// https://api.openalex.org/works?filter=type:article,primary_location.version:!submittedVersion
  /// Works that represent stuff that is about the venue (such as a journal)—rather than a scholarly work properly speaking—have type paratext. These include things like front-covers, back-covers, tables of contents, and the journal itself (e.g., https://openalex.org/W4232230324).
  /// We also have types for letter , editorial , and erratum (corrections). Coverage is low on these but will improve.
  /// Other work types follow the Crossref "type" controlled vocabulary—see type_crossref.
  String? type;

  /// Legacy type information, using Crossref's "type" controlled vocabulary.
  /// These are the work types that we used to use, before switching to our current system (see type).
  /// You can see all possible values of Crossref's "type" controlled vocabulary via the Crossref api here: https://api.crossref.org/types.
  /// Where possible, we just pass along Crossref's type value for each work. When that's impossible (eg the work isn't in Crossref), we do our best to figure out the type ourselves.
  @JsonKey(name: 'type_crossref')
  String? typeCrossref;

  /// The last time anything in this Work object changed, expressed as an ISO 8601 date string (in UTC). This date is updated for any change at all, including increases in various counts.
  @JsonKey(name: 'updated_date')
  DateTime? updatedDate;

  /// Group of words (or numbers, letters, etc) that exist together in the work. This can be a five-gram, four-gram, trigram, bigram, or unigram.
  String? ngram;

  /// How many times this ngram occurred in the work.
  @JsonKey(name: 'ngram_count')
  int? ngramCount;

  /// How many tokens are in the ngram.
  @JsonKey(name: 'ngram_tokens')
  int? ngramTokens;

  /// How often the ngram occurred in the work.
  /// Caution: This data was taken directly from the General Index and we've not tested term_frequency against actual articles.
  /// You can read about their data extraction process on the Internet Archive website. If you compare term_frequency against articles we would like to hear how it went!
  @JsonKey(name: 'term_frequency')
  double? termFrequency;

  String get abstract {
    return abstractInvertedIndex!.entries.map((e) => e.key).toList().join(' ');
  }

  Work({
    this.abstractInvertedIndex,
    this.authorships,
    this.apcList,
    this.apcPaid,
    this.bestOALocation,
    this.biblio,
    this.citedByApiUrl,
    this.citedByCount,
    this.concepts,
    this.correspondingAuthorIds,
    this.correspondingInstitutionIds,
    this.countriesDistinctCount,
    this.countsByYear,
    this.createdDate,
    this.displayName,
    this.doi,
    this.grants,
    this.id,
    this.ids,
    this.institutionsDistinctCount,
    this.isOA,
    this.isParatext,
    this.isRetracted,
    this.language,
    this.license,
    this.locations,
    this.locationsCount,
    this.mesh,
    this.ngramsUrl,
    this.openAccess,
    this.primaryLocation,
    this.publicationDate,
    this.publicationYear,
    this.referencedWorks,
    this.relatedWorks,
    this.sustainableDevelopmentGoals,
    this.title,
    this.type,
    this.typeCrossref,
    this.updatedDate,
    this.ngram,
    this.ngramCount,
    this.ngramTokens,
    this.termFrequency,
  });

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

  Map<String, dynamic> toJson() => _$WorkToJson(this);
}
