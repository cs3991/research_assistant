import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'json_response.dart';

main() {
  group('Concept', () {
    group('fromJson', () {
      var jsonResponseMap = jsonDecode(conceptJsonResponse);
      test('throws CheckedFromJsonException when one required field is missing',
          () {
        for (final field in [
          'id',
          'level',
          'works_count',
          'cited_by_count',
          'image_url',
          'image_thumbnail_url',
          'international',
          'ancestors',
          'related_concepts',
          'counts_by_year',
          'works_api_url',
          'updated_date',
          'created_date',
        ]) {
          var invalidJson = Map<String, dynamic>.from(jsonResponseMap);
          expect(invalidJson.remove(field), isNotNull);
          expect(() {
            return Concept.fromJson(invalidJson);
          }, throwsA(isA<CheckedFromJsonException>()));
        }
      });
      test('Return Concept when optional fields are null', () {
        var validJson = Map<String, dynamic>.from(jsonResponseMap);
        for (final field in ['mag', 'wikipedia', 'wikidata']) {
          expect(validJson['ids'].remove(field), isNotNull);
        }
        expect(Concept.fromJson(validJson), isA<Concept>());
      });
    });
  });
}
