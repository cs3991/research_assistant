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
          openAlexId: $checkedConvert('id', (v) => v as String?),
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
          type:
              $checkedConvert('type', (v) => $enumDecode(_$WorkTypeEnumMap, v)),
          title: $checkedConvert('title', (v) => v as String),
          displayName: $checkedConvert('display_name', (v) => v as String),
          publicationYear: $checkedConvert('publication_year', (v) => v as int),
          publicationDate: $checkedConvert(
              'publication_date', (v) => DateTime.parse(v as String)),
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
          citedByCountsByYear: $checkedConvert('counts_by_year',
              (v) => Work._readCountsByYear(v as List<Map<dynamic, dynamic>>)),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert(
              'created_date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'openAlexId': 'id',
        'doiId': 'doi',
        'magId': 'mag',
        'pmidId': 'pmid',
        'pmcId': 'pmcid',
        'openAccessUrl': 'oa_url',
        'displayName': 'display_name',
        'publicationYear': 'publication_year',
        'publicationDate': 'publication_date',
        'citedByCount': 'cited_by_count',
        'isOpenAccess': 'is_oa',
        'openAccessStatus': 'oa_status',
        'isRetracted': 'is_retracted',
        'isParatext': 'is_paratext',
        'citedByApiUrl': 'cited_by_api_url',
        'citedByCountsByYear': 'counts_by_year',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date'
      },
    );

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      'id': instance.openAlexId,
      'doi': instance.doiId,
      'mag': instance.magId,
      'pmid': instance.pmidId,
      'pmcid': instance.pmcId,
      'type': _$WorkTypeEnumMap[instance.type],
      'title': instance.title,
      'display_name': instance.displayName,
      'publication_year': instance.publicationYear,
      'publication_date': instance.publicationDate.toIso8601String(),
      'is_oa': instance.isOpenAccess,
      'oa_status': _$OpenAccessStatusEnumMap[instance.openAccessStatus],
      'oa_url': instance.openAccessUrl,
      'cited_by_count': instance.citedByCount,
      'cited_by_api_url': instance.citedByApiUrl,
      'counts_by_year': Work._writeCountsByYear(instance.citedByCountsByYear),
      'is_retracted': instance.isRetracted,
      'is_paratext': instance.isParatext,
      'updated_date': instance.updatedDate.toIso8601String(),
      'created_date': instance.createdDate.toIso8601String(),
    };

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
