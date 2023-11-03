// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Work _$WorkFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Work',
      json,
      ($checkedConvert) {
        final val = Work(
          abstractInvertedIndex: $checkedConvert(
              'abstract_inverted_index',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
                  )),
          authorships: $checkedConvert(
              'authorships',
              (v) =>
                  (v as List<dynamic>).map((e) => Authorship.fromJson(e as Map<String, dynamic>)).toList()),
          apcList:
              $checkedConvert('apc_list', (v) => v == null ? null : Apc.fromJson(v as Map<String, dynamic>)),
          apcPaid:
              $checkedConvert('apc_paid', (v) => v == null ? null : Apc.fromJson(v as Map<String, dynamic>)),
          bestOaLocation: $checkedConvert(
              'best_oa_location', (v) => v == null ? null : Location.fromJson(v as Map<String, dynamic>)),
          biblio: $checkedConvert('biblio', (v) => Map<String, String?>.from(v as Map)),
          citedByApiUrl: $checkedConvert('cited_by_api_url', (v) => v as String),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          concepts: $checkedConvert(
              'concepts',
              (v) => (v as List<dynamic>)
                  .map((e) => ConceptDehydrated.fromJson(e as Map<String, dynamic>))
                  .toList()),
          correspondingAuthorIds: $checkedConvert(
              'corresponding_author_ids', (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          correspondingInstitutionIds: $checkedConvert(
              'corresponding_institution_ids', (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          countriesDistinctCount: $checkedConvert('countries_distinct_count', (v) => v as int),
          countsByYear: $checkedConvert('counts_by_year',
              (v) => (v as List<dynamic>).map((e) => YearWork.fromJson(e as Map<String, dynamic>)).toList()),
          createdDate: $checkedConvert('created_date', (v) => DateTime.parse(v as String)),
          displayName: $checkedConvert('display_name', (v) => v as String),
          fulltextOrigin: $checkedConvert('fulltext_origin', (v) => v as String?),
          grants: $checkedConvert('grants',
              (v) => (v as List<dynamic>).map((e) => Grant.fromJson(e as Map<String, dynamic>)).toList()),
          hasFulltext: $checkedConvert('has_fulltext', (v) => v as bool),
          id: $checkedConvert('id', (v) => v as String),
          doiId: $checkedConvert(
            'doi',
            (v) => v as String?,
            readValue: Work._readId,
          ),
          magId: $checkedConvert(
            'mag',
            (v) => v as String?,
            readValue: Work._readId,
          ),
          pmidId: $checkedConvert(
            'pmid',
            (v) => v as String?,
            readValue: Work._readId,
          ),
          pmcId: $checkedConvert(
            'pmcid',
            (v) => v as String?,
            readValue: Work._readId,
          ),
          isParatext: $checkedConvert('is_paratext', (v) => v as bool),
          isRetracted: $checkedConvert('is_retracted', (v) => v as bool),
          mesh: $checkedConvert(
              'mesh', (v) => (v as List<dynamic>).map((e) => e as Map<String, dynamic>).toList()),
          title: $checkedConvert('title', (v) => v as String),
          type: $checkedConvert('type', (v) => $enumDecode(_$WorkTypeEnumMap, v)),
          institutionsDistinctCount: $checkedConvert('institutions_distinct_count', (v) => v as int),
          language: $checkedConvert('language', (v) => v as String),
          license: $checkedConvert('license', (v) => v as String?),
          locations: $checkedConvert('locations',
              (v) => (v as List<dynamic>).map((e) => Location.fromJson(e as Map<String, dynamic>)).toList()),
          locationsCount: $checkedConvert('locations_count', (v) => v as int),
          ngramsUrl: $checkedConvert('ngrams_url', (v) => v as String),
          primaryLocation:
              $checkedConvert('primary_location', (v) => Location.fromJson(v as Map<String, dynamic>)),
          publicationDate: $checkedConvert('publication_date', (v) => DateTime.parse(v as String)),
          publicationYear: $checkedConvert('publication_year', (v) => v as int),
          referencedWorks: $checkedConvert(
              'referenced_works', (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          relatedWorks:
              $checkedConvert('related_works', (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          updatedDate: $checkedConvert('updated_date', (v) => v),
          isOpenAccess: $checkedConvert(
            'is_oa',
            (v) => v as bool,
            readValue: Work._readOpenAccess,
          ),
          openAccessStatus: $checkedConvert(
            'oa_status',
            (v) => $enumDecode(_$OpenAccessStatusEnumMap, v),
            readValue: Work._readOpenAccess,
          ),
          openAccessUrl: $checkedConvert(
            'oa_url',
            (v) => v as String?,
            readValue: Work._readOpenAccess,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'abstractInvertedIndex': 'abstract_inverted_index',
        'apcList': 'apc_list',
        'apcPaid': 'apc_paid',
        'bestOaLocation': 'best_oa_location',
        'citedByApiUrl': 'cited_by_api_url',
        'citedByCount': 'cited_by_count',
        'correspondingAuthorIds': 'corresponding_author_ids',
        'correspondingInstitutionIds': 'corresponding_institution_ids',
        'countriesDistinctCount': 'countries_distinct_count',
        'countsByYear': 'counts_by_year',
        'createdDate': 'created_date',
        'displayName': 'display_name',
        'fulltextOrigin': 'fulltext_origin',
        'hasFulltext': 'has_fulltext',
        'doiId': 'doi',
        'magId': 'mag',
        'pmidId': 'pmid',
        'pmcId': 'pmcid',
        'isParatext': 'is_paratext',
        'isRetracted': 'is_retracted',
        'institutionsDistinctCount': 'institutions_distinct_count',
        'locationsCount': 'locations_count',
        'ngramsUrl': 'ngrams_url',
        'primaryLocation': 'primary_location',
        'publicationDate': 'publication_date',
        'publicationYear': 'publication_year',
        'referencedWorks': 'referenced_works',
        'relatedWorks': 'related_works',
        'updatedDate': 'updated_date',
        'isOpenAccess': 'is_oa',
        'openAccessStatus': 'oa_status',
        'openAccessUrl': 'oa_url'
      },
    );

const _$WorkTypeEnumMap = {
  WorkType.article: 'article',
  WorkType.bookChapter: 'book-chapter',
  WorkType.dissertation: 'dissertation',
  WorkType.book: 'book',
  WorkType.dataset: 'dataset',
  WorkType.paratext: 'paratext',
  WorkType.other: 'other',
  WorkType.referenceEntry: 'reference-entry',
  WorkType.report: 'report',
  WorkType.peerReview: 'peer-review',
  WorkType.standard: 'standard',
  WorkType.editorial: 'editorial',
  WorkType.erratum: 'erratum',
  WorkType.grant: 'grant',
  WorkType.letter: 'letter',
};

const _$OpenAccessStatusEnumMap = {
  OpenAccessStatus.gold: 'gold',
  OpenAccessStatus.green: 'green',
  OpenAccessStatus.hybrid: 'hybrid',
  OpenAccessStatus.bronze: 'bronze',
  OpenAccessStatus.closed: 'closed',
};

Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Location',
      json,
      ($checkedConvert) {
        final val = Location(
          isOa: $checkedConvert('is_oa', (v) => v as bool),
          landingPageUrl: $checkedConvert('landing_page_url', (v) => v as String?),
          pdfUrl: $checkedConvert('pdf_url', (v) => v as String?),
          source: $checkedConvert(
              'source', (v) => v == null ? null : SourceDehydrated.fromJson(v as Map<String, dynamic>)),
          license: $checkedConvert('license', (v) => v as String?),
          version: $checkedConvert('version', (v) => v as String?),
          isAccepted: $checkedConvert('is_accepted', (v) => v as bool),
          isPublished: $checkedConvert('is_published', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'isOa': 'is_oa',
        'landingPageUrl': 'landing_page_url',
        'pdfUrl': 'pdf_url',
        'isAccepted': 'is_accepted',
        'isPublished': 'is_published'
      },
    );

Grant _$GrantFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Grant',
      json,
      ($checkedConvert) {
        final val = Grant(
          funder: $checkedConvert('funder', (v) => v as String),
          funderDisplayName: $checkedConvert('funder_display_name', (v) => v as String),
          awardId: $checkedConvert('award_id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'funderDisplayName': 'funder_display_name', 'awardId': 'award_id'},
    );

Apc _$ApcFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Apc',
      json,
      ($checkedConvert) {
        final val = Apc(
          value: $checkedConvert('value', (v) => v as int),
          currency: $checkedConvert('currency', (v) => v as String),
          provenance: $checkedConvert('provenance', (v) => v as String?),
          valueUsd: $checkedConvert('value_usd', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {'valueUsd': 'value_usd'},
    );

Authorship _$AuthorshipFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Authorship',
      json,
      ($checkedConvert) {
        final val = Authorship(
          author: $checkedConvert('author',
              (v) => AuthorDehydrated.fromJson(v as Map<String, dynamic>)),
          authorPosition: $checkedConvert('author_position',
              (v) => $enumDecode(_$AuthorshipPositionEnumMap, v)),
          institutions: $checkedConvert(
              'institutions',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      InstitutionDehydrated.fromJson(e as Map<String, dynamic>))
                  .toList()),
          rawAffiliationString:
              $checkedConvert('raw_affiliation_string', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'authorPosition': 'author_position',
        'rawAffiliationString': 'raw_affiliation_string'
      },
    );

const _$AuthorshipPositionEnumMap = {
  AuthorshipPosition.First: 'first',
  AuthorshipPosition.Middle: 'middle',
  AuthorshipPosition.Last: 'last',
};
