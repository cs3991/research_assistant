// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Institution',
      json,
      ($checkedConvert) {
        final val = Institution(
          id: $checkedConvert('id', (v) => v as String),
          ror: $checkedConvert('ror', (v) => v as String),
          countryCode: $checkedConvert('country_code', (v) => v as String),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$InstitutionTypeEnumMap, v)),
          homepageUrl: $checkedConvert('homepage_url', (v) => v as String),
          imageUrl: $checkedConvert('image_url', (v) => v as String),
          imageThumbnailUrl:
              $checkedConvert('image_thumbnail_url', (v) => v as String),
          displayNameAcronyms: $checkedConvert('display_name_acronyms',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          displayNameAlternatives: $checkedConvert('display_name_alternatives',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          geo: $checkedConvert(
              'geo', (v) => Geo.fromJson(v as Map<String, dynamic>)),
          internationalDisplayName: $checkedConvert(
            'display_name',
            (v) => Map<String, String>.from(v as Map),
            readValue: Institution._readInternational,
          ),
          countsByYear: $checkedConvert(
              'counts_by_year',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      YearInstitution.fromJson(e as Map<String, dynamic>))
                  .toList()),
          worksApiUrl: $checkedConvert('works_api_url', (v) => v as String),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert(
              'created_date', (v) => DateTime.parse(v as String)),
          magId: $checkedConvert(
            'mag',
            (v) => v as String?,
            readValue: Institution._readId,
          ),
          gridId: $checkedConvert(
            'grid',
            (v) => v as String?,
            readValue: Institution._readId,
          ),
          wikipediaId: $checkedConvert(
            'wikipedia',
            (v) => v as String?,
            readValue: Institution._readId,
          ),
          wikidataId: $checkedConvert(
            'wikidata',
            (v) => v as String?,
            readValue: Institution._readId,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'countryCode': 'country_code',
        'homepageUrl': 'homepage_url',
        'imageUrl': 'image_url',
        'imageThumbnailUrl': 'image_thumbnail_url',
        'displayNameAcronyms': 'display_name_acronyms',
        'displayNameAlternatives': 'display_name_alternatives',
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count',
        'internationalDisplayName': 'display_name',
        'countsByYear': 'counts_by_year',
        'worksApiUrl': 'works_api_url',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'magId': 'mag',
        'gridId': 'grid',
        'wikipediaId': 'wikipedia',
        'wikidataId': 'wikidata'
      },
    );

const _$InstitutionTypeEnumMap = {
  InstitutionType.Education: 'education',
  InstitutionType.Healthcare: 'healthcare',
  InstitutionType.Company: 'company',
  InstitutionType.Archive: 'archive',
  InstitutionType.Nonprofit: 'nonprofit',
  InstitutionType.Government: 'government',
  InstitutionType.Facility: 'facility',
  InstitutionType.Other: 'other',
};

YearInstitution _$YearInstitutionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'YearInstitution',
      json,
      ($checkedConvert) {
        final val = YearInstitution(
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

Geo _$GeoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Geo',
      json,
      ($checkedConvert) {
        final val = Geo(
          city: $checkedConvert('city', (v) => v as String),
          geonamesCityId:
              $checkedConvert('geonames_city_id', (v) => v as String),
          region: $checkedConvert('region', (v) => v as String),
          countryCode: $checkedConvert('country_code', (v) => v as String),
          country: $checkedConvert('country', (v) => v as String),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'geonamesCityId': 'geonames_city_id',
        'countryCode': 'country_code'
      },
    );
