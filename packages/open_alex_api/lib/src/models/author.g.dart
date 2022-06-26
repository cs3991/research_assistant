// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDehydrated _$AuthorDehydratedFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AuthorDehydrated',
      json,
      ($checkedConvert) {
        final val = AuthorDehydrated(
          id: $checkedConvert('id', (v) => v as String),
          displayName: $checkedConvert('display_name', (v) => v as String),
          orcid: $checkedConvert('orcid', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'displayName': 'display_name'},
    );

Author _$AuthorFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Author',
      json,
      ($checkedConvert) {
        final val = Author(
          id: $checkedConvert('id', (v) => v as String),
          displayName: $checkedConvert('display_name', (v) => v as String),
          displayNameAlternatives: $checkedConvert('display_name_alternatives',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          countsByYear: $checkedConvert(
              'counts_by_year',
              (v) => (v as List<dynamic>)
                  .map((e) => Year.fromJson(e as Map<String, dynamic>))
                  .toList()),
          worksApiUrl: $checkedConvert('works_api_url', (v) => v as String),
          lastKnownInstitution: $checkedConvert('last_known_institution',
              (v) => InstitutionDehydrated.fromJson(v as Map<String, dynamic>)),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert(
              'created_date', (v) => DateTime.parse(v as String)),
          orcid: $checkedConvert('orcid', (v) => v as String?),
          magId: $checkedConvert(
            'mag',
            (v) => v as String?,
            readValue: Author._readId,
          ),
          twitterId: $checkedConvert(
            'twitter',
            (v) => v as String?,
            readValue: Author._readId,
          ),
          wikipediaId: $checkedConvert(
            'wikipedia',
            (v) => v as String?,
            readValue: Author._readId,
          ),
          scopusId: $checkedConvert(
            'scopus',
            (v) => v as String?,
            readValue: Author._readId,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayName': 'display_name',
        'displayNameAlternatives': 'display_name_alternatives',
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count',
        'countsByYear': 'counts_by_year',
        'worksApiUrl': 'works_api_url',
        'lastKnownInstitution': 'last_known_institution',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'magId': 'mag',
        'twitterId': 'twitter',
        'wikipediaId': 'wikipedia',
        'scopusId': 'scopus'
      },
    );
