// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Venue',
      json,
      ($checkedConvert) {
        final val = Venue(
          id: $checkedConvert('id', (v) => v as String),
          displayName: $checkedConvert('display_name', (v) => v as String),
          linkingIssn: $checkedConvert('issn_l', (v) => v as String),
          issn: $checkedConvert('issn',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          publisher: $checkedConvert('publisher', (v) => v as String),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          isOa: $checkedConvert('is_oa', (v) => v as bool),
          isInDoaj: $checkedConvert('is_in_doaj', (v) => v as bool),
          homepageUrl: $checkedConvert('homepage_url', (v) => v as String),
          countsByYear: $checkedConvert(
              'counts_by_year',
              (v) => (v as List<dynamic>)
                  .map((e) => YearVenue.fromJson(e as Map<String, dynamic>))
                  .toList()),
          worksApiUrl: $checkedConvert('works_api_url', (v) => v as String),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert(
              'created_date', (v) => DateTime.parse(v as String)),
          magId: $checkedConvert(
            'mag',
            (v) => v as String?,
            readValue: Venue._readId,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayName': 'display_name',
        'linkingIssn': 'issn_l',
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count',
        'isOa': 'is_oa',
        'isInDoaj': 'is_in_doaj',
        'homepageUrl': 'homepage_url',
        'countsByYear': 'counts_by_year',
        'worksApiUrl': 'works_api_url',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'magId': 'mag'
      },
    );

YearVenue _$YearVenueFromJson(Map<String, dynamic> json) => $checkedCreate(
      'YearVenue',
      json,
      ($checkedConvert) {
        final val = YearVenue(
          year: $checkedConvert('year', (v) => v as int),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count'
      },
    );
