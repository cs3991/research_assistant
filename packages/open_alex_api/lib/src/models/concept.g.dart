// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'concept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConceptDehydrated _$ConceptDehydratedFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ConceptDehydrated',
      json,
      ($checkedConvert) {
        final val = ConceptDehydrated(
          id: $checkedConvert('id', (v) => v as String),
          displayName: $checkedConvert('display_name', (v) => v as String),
          wikidata: $checkedConvert('wikidata', (v) => v as String?),
          level: $checkedConvert('level', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'displayName': 'display_name'},
    );

Concept _$ConceptFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Concept',
      json,
      ($checkedConvert) {
        final val = Concept(
          displayName: $checkedConvert('display_name', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          wikidata: $checkedConvert('wikidata', (v) => v as String?),
          level: $checkedConvert('level', (v) => v as int),
          description: $checkedConvert('description', (v) => v as String),
          worksCount: $checkedConvert('works_count', (v) => v as int),
          citedByCount: $checkedConvert('cited_by_count', (v) => v as int),
          imageUrl: $checkedConvert('image_url', (v) => v as String),
          imageThumbnailUrl:
              $checkedConvert('image_thumbnail_url', (v) => v as String),
          international: $checkedConvert(
              'international',
              (v) => InternationalWithDescription.fromJson(
                  v as Map<String, dynamic>)),
          ancestors: $checkedConvert(
              'ancestors',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      ConceptDehydrated.fromJson(e as Map<String, dynamic>))
                  .toList()),
          relatedConcepts: $checkedConvert(
              'related_concepts',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      ConceptDehydrated.fromJson(e as Map<String, dynamic>))
                  .toList()),
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
        'displayName': 'display_name',
        'worksCount': 'works_count',
        'citedByCount': 'cited_by_count',
        'imageUrl': 'image_url',
        'imageThumbnailUrl': 'image_thumbnail_url',
        'relatedConcepts': 'related_concepts',
        'countsByYear': 'counts_by_year',
        'worksApiUrl': 'works_api_url',
        'updatedDate': 'updated_date',
        'createdDate': 'created_date',
        'magId': 'mag',
        'wikipediaId': 'wikipedia'
      },
    );
