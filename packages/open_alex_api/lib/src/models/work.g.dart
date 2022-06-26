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
          id: $checkedConvert('id', (v) => v as String),
          type:
              $checkedConvert('type', (v) => $enumDecode(_$WorkTypeEnumMap, v)),
          title: $checkedConvert('title', (v) => v as String),
          displayName: $checkedConvert('display_name', (v) => v as String),
          publicationYear: $checkedConvert('publication_year', (v) => v as int),
          publicationDate: $checkedConvert(
              'publication_date', (v) => DateTime.parse(v as String)),
          hostVenue: $checkedConvert('host_venue',
              (v) => HostVenue.fromJson(v as Map<String, dynamic>)),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
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
          isRetracted: $checkedConvert('is_retracted', (v) => v as bool),
          isParatext: $checkedConvert('is_paratext', (v) => v as bool),
          citedByApiUrl:
              $checkedConvert('cited_by_api_url', (v) => v as String),
          countsByYear: $checkedConvert(
              'counts_by_year',
              (v) => (v as List<dynamic>)
                  .map((e) => YearWork.fromJson(e as Map<String, dynamic>))
                  .toList()),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert(
              'created_date', (v) => DateTime.parse(v as String)),
          authorships: $checkedConvert(
              'authorships',
              (v) => (v as List<dynamic>)
                  .map((e) => Authorship.fromJson(e as Map<String, dynamic>))
                  .toList()),
          concepts: $checkedConvert(
              'concepts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      ConceptDehydrated.fromJson(e as Map<String, dynamic>))
                  .toList()),
          mesh: $checkedConvert(
              'mesh',
              (v) => (v as List<dynamic>)
                  .map((e) => e as Map<String, dynamic>)
                  .toList()),
          alternateHostVenues: $checkedConvert(
              'alternate_host_venues',
              (v) => (v as List<dynamic>)
                  .map((e) => HostVenue.fromJson(e as Map<String, dynamic>))
                  .toList()),
          referencedWorks: $checkedConvert('referenced_works',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          relatedWorks: $checkedConvert('related_works',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          abstractInvertedIndex: $checkedConvert(
              'abstract_inverted_index',
              (v) => (v as Map<String, dynamic>).map(
                    (k, e) => MapEntry(
                        k, (e as List<dynamic>).map((e) => e as int).toList()),
                  )),
          biblio: $checkedConvert(
              'biblio', (v) => Map<String, String?>.from(v as Map)),
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
          openAccessUrl: $checkedConvert(
            'oa_url',
            (v) => v as String?,
            readValue: Work._readOpenAccess,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayName': 'display_name',
        'publicationYear': 'publication_year',
        'publicationDate': 'publication_date',
        'hostVenue': 'host_venue',
        'citedByCount': 'cited_by_count',
        'isOpenAccess': 'is_oa',
        'openAccessStatus': 'oa_status',
        'isRetracted': 'is_retracted',
        'isParatext': 'is_paratext',
        'citedByApiUrl': 'cited_by_api_url',
        'countsByYear': 'counts_by_year',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'alternateHostVenues': 'alternate_host_venues',
        'referencedWorks': 'referenced_works',
        'relatedWorks': 'related_works',
        'abstractInvertedIndex': 'abstract_inverted_index',
        'doiId': 'doi',
        'magId': 'mag',
        'pmidId': 'pmid',
        'pmcId': 'pmcid',
        'openAccessUrl': 'oa_url'
      },
    );

const _$WorkTypeEnumMap = {
  WorkType.bookSection: 'book-section',
  WorkType.monograph: 'monograph',
  WorkType.report: 'report',
  WorkType.peerReview: 'peer-review',
  WorkType.bookTrack: 'book-track',
  WorkType.journalArticle: 'journal-article',
  WorkType.bookPart: 'book-part',
  WorkType.other: 'other',
  WorkType.book: 'book',
  WorkType.journalVolume: 'journal-volume',
  WorkType.bookSet: 'book-set',
  WorkType.referenceEntry: 'reference-entry',
  WorkType.proceedingsArticle: 'proceedings-article',
  WorkType.journal: 'journal',
  WorkType.component: 'component',
  WorkType.bookChapter: 'book-chapter',
  WorkType.proceedingsSeries: 'proceedings-series',
  WorkType.reportSeries: 'report-series',
  WorkType.proceedings: 'proceedings',
  WorkType.standard: 'standard',
  WorkType.referenceBook: 'reference-book',
  WorkType.postedContent: 'posted-content',
  WorkType.journalIssue: 'journal-issue',
  WorkType.dissertation: 'dissertation',
  WorkType.grant: 'grant',
  WorkType.dataset: 'dataset',
  WorkType.bookSeries: 'book-series',
  WorkType.editedBook: 'edited-book',
  WorkType.standardSeries: 'standard-series',
};

const _$OpenAccessStatusEnumMap = {
  OpenAccessStatus.gold: 'gold',
  OpenAccessStatus.green: 'green',
  OpenAccessStatus.hybrid: 'hybrid',
  OpenAccessStatus.bronze: 'bronze',
  OpenAccessStatus.closed: 'closed',
};

HostVenue _$HostVenueFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HostVenue',
      json,
      ($checkedConvert) {
        final val = HostVenue(
          displayName: $checkedConvert('display_name', (v) => v as String),
          linkingIssn: $checkedConvert('issn_l', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String?),
          issn: $checkedConvert('issn',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          publisher: $checkedConvert('publisher', (v) => v as String?),
          url: $checkedConvert('url', (v) => v as String),
          isOpenAccess: $checkedConvert('is_oa', (v) => v as bool),
          version: $checkedConvert(
              'version', (v) => $enumDecode(_$HostVenueVersionEnumMap, v)),
          license: $checkedConvert('license', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayName': 'display_name',
        'linkingIssn': 'issn_l',
        'isOpenAccess': 'is_oa'
      },
    );

const _$HostVenueVersionEnumMap = {
  HostVenueVersion.publishedVersion: 'publishedVersion',
  HostVenueVersion.acceptedVersion: 'acceptedVersion',
  HostVenueVersion.submittedVersion: 'submittedVersion',
};

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
