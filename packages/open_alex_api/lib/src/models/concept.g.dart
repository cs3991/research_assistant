// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'concept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Concept _$ConceptFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Concept',
      json,
      ($checkedConvert) {
        final val = Concept(
          id: $checkedConvert('id', (v) => v as String),
          wikidata: $checkedConvert('wikidata', (v) => v as String),
          level: $checkedConvert('level', (v) => v as int),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          imageUrl: $checkedConvert('image_url', (v) => v as String),
          imageThumbnailUrl:
              $checkedConvert('image_thumbnail_url', (v) => v as String),
          internationalDisplayName: $checkedConvert(
            'display_name',
            (v) => Map<String, String>.from(v as Map),
            readValue: Concept._readInternational,
          ),
          internationalDescription: $checkedConvert(
            'description',
            (v) => Map<String, String>.from(v as Map),
            readValue: Concept._readInternational,
          ),
          countsByYear: $checkedConvert(
              'counts_by_year',
              (v) => (v as List<dynamic>)
                  .map((e) => Year.fromJson(e as Map<String, dynamic>))
                  .toList()),
          worksApiUrl: $checkedConvert('works_api_url', (v) => v as String),
          updatedDate: $checkedConvert(
              'updated_date', (v) => DateTime.parse(v as String)),
          createdDate: $checkedConvert(
              'created_date', (v) => DateTime.parse(v as String)),
          magId: $checkedConvert(
            'mag',
            (v) => v as String?,
            readValue: Concept._readIds,
          ),
          wikipediaId: $checkedConvert(
            'wikipedia',
            (v) => v as String?,
            readValue: Concept._readIds,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count',
        'imageUrl': 'image_url',
        'imageThumbnailUrl': 'image_thumbnail_url',
        'internationalDisplayName': 'display_name',
        'internationalDescription': 'description',
        'countsByYear': 'counts_by_year',
        'worksApiUrl': 'works_api_url',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'magId': 'mag',
        'wikipediaId': 'wikipedia'
      },
    );
