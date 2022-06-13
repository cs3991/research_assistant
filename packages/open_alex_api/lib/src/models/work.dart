import 'package:json_annotation/json_annotation.dart';

part 'work.g.dart';

@JsonSerializable()
class Work {
  Work({
    required this.title,
  });

  final String title;

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
}

// enum WorkType {
//   book_section,
//   monograph,
//   report,
//   peer_review,
//   book_track,
//   journal_article,
//   book_part,
//   other,
//   book,
//   journal_volume,
//   book_set,
//   reference_entry,
//   proceedings_article,
//   journal,
//   component,
//   book_chapter,
//   proceedings_series,
//   report_series,
//   proceedings,
//   standard,
//   reference_book,
//   posted_content,
//   journal_issue,
//   dissertation,
//   grant,
//   dataset,
//   book_series,
//   edited_book,
//   standard_series,
// }
//
// enum OpenAccessStatus {
//   gold,
//   green,
//   hybrid,
//   bronze,
//   closed,
// }
//
// class WorkModel {
//   // ids
//   final String? openAlexId;
//   final String? doiId;
//   final String? magId;
//   final String? pmidId;
//   final String? pmcId;
//
//   final WorkType type;
//   final String title;
//   final String displayName;
//   final int publicationYear;
//   final DateTime publicationDate;
//
//   // Open access
//   final bool isOpenAccess;
//   final OpenAccessStatus openAccessStatus;
//   final String? openAccessUrl;
//
//   // Citations
//   final int citedByCount;
//   final String citedByUrl;
//   final Map<int, int> citedByCountsByYear;
//
//   final bool isRetracted;
//   final bool isParatext;
//
//   final DateTime updatedDate;
//   final DateTime createdDate;
//
//   WorkModel(
//       this.openAlexId,
//       this.doiId,
//       this.magId,
//       this.pmidId,
//       this.pmcId,
//       this.type,
//       this.title,
//       this.displayName,
//       this.publicationYear,
//       this.publicationDate,
//       this.citedByCount,
//       this.isOpenAccess,
//       this.openAccessStatus,
//       this.openAccessUrl,
//       this.isRetracted,
//       this.isParatext,
//       this.citedByUrl,
//       this.citedByCountsByYear,
//       this.updatedDate,
//       this.createdDate);
//
//   factory WorkModel.fromJson(Map<String, dynamic> json) {
//     return WorkModel(
//       json['open_alex_id'] as String?,
//       json['doi_id'] as String?,
//       json['mag_id'] as String?,
//       json['pmid_id'] as String?,
//       json['pmc_id'] as String?,
//       _parseWorkType(json['type'] as String),
//       json['title'] as String,
//       json['display_name'] as String,
//       json['publication_year'] as int,
//       DateTime.parse(json['publication_date'] as String),
//       json['cited_by_count'] as int,
//       json['is_open_access'] as bool,
//       _parseOpenAccessStatus(json['open_access_status'] as String),
//       json['open_access_url'] as String?,
//       json['is_retracted'] as bool,
//       json['is_paratext'] as bool,
//       json['cited_by_url'] as String,
//       json['counts_by_year'] as Map<int, int>,
//       DateTime.parse(json['updated_date'] as String),
//       DateTime.parse(json['created_date'] as String),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'open_alex_id': openAlexId,
//       'doi_id': doiId,
//       'mag_id': magId,
//       'pmid_id': pmidId,
//       'pmc_id': pmcId,
//       'type': _serializeWorkType(type),
//       'title': title,
//       'display_name': displayName,
//       'publication_year': publicationYear,
//       'publication_date': publicationDate.toIso8601String(),
//       'cited_by_count': citedByCount,
//       'is_open_access': isOpenAccess,
//       'open_access_status': openAccessStatus.toString().replaceAll(r'OpenAccessStatus\.', ''),
//       'open_access_url': openAccessUrl,
//       'is_retracted': isRetracted,
//       'is_paratext': isParatext,
//       'cited_by_url': citedByUrl,
//       'counts_by_year': citedByCountsByYear,
//       'updated_date': updatedDate.toIso8601String(),
//       'created_date': createdDate.toIso8601String(),
//     };
//   }
//
//   static OpenAccessStatus _parseOpenAccessStatus(String json) {
//     switch (json) {
//       case 'gold':
//         return OpenAccessStatus.gold;
//       case 'green':
//         return OpenAccessStatus.green;
//       case 'hybrid':
//         return OpenAccessStatus.hybrid;
//       case 'bronze':
//         return OpenAccessStatus.bronze;
//       case 'closed':
//         return OpenAccessStatus.closed;
//       default:
//         throw Exception('Unknown open access status: $json');
//     }
//   }
//
//   static WorkType _parseWorkType(String json) {
//     switch (json) {
//       case 'book-section':
//         return WorkType.book_section;
//       case 'monograph':
//         return WorkType.monograph;
//       case 'report':
//         return WorkType.report;
//       case 'peer-review':
//         return WorkType.peer_review;
//       case 'book-track':
//         return WorkType.book_track;
//       case 'journal-article':
//         return WorkType.journal_article;
//       case 'book-part':
//         return WorkType.book_part;
//       case 'other':
//         return WorkType.other;
//       case 'book':
//         return WorkType.book;
//       case 'journal-volume':
//         return WorkType.journal_volume;
//       case 'book-set':
//         return WorkType.book_set;
//       case 'reference-entry':
//         return WorkType.reference_entry;
//       case 'proceedings-article':
//         return WorkType.proceedings_article;
//       case 'journal':
//         return WorkType.journal;
//       case 'component':
//         return WorkType.component;
//       case 'book-chapter':
//         return WorkType.book_chapter;
//       case 'proceedings-series':
//         return WorkType.proceedings_series;
//       case 'report-series':
//         return WorkType.report_series;
//       case 'proceedings':
//         return WorkType.proceedings;
//       case 'standard':
//         return WorkType.standard;
//       case 'reference-book':
//         return WorkType.reference_book;
//       case 'posted-content':
//         return WorkType.posted_content;
//       case 'journal-issue':
//         return WorkType.journal_issue;
//       case 'dissertation':
//         return WorkType.dissertation;
//       case 'grant':
//         return WorkType.grant;
//       case 'dataset':
//         return WorkType.dataset;
//       case 'book-series':
//         return WorkType.book_series;
//       case 'edited-book':
//         return WorkType.edited_book;
//       case 'standard-series':
//         return WorkType.standard_series;
//       default:
//         throw Exception('Unknown work type: $json');
//     }
//   }
//
//   static String _serializeWorkType(WorkType type) {
//     return type.toString().replaceAll(r'WorkType\.', '').replaceAll('_', '-');
//   }
// }
