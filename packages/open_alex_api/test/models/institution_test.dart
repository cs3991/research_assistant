import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'json_response.dart';

main() {
  group('Institution', () {
    group('fromJson', () {
      var jsonResponseMap = jsonDecode(institutionJsonResponse);
      test('throws CheckedFromJsonException when one required field is missing',
          () {
        for (final field in [
          "id",
          "ror",
          "country_code",
          "type",
          "homepage_url",
          "image_url",
          "image_thumbnail_url",
          "display_name_acronyms",
          "display_name_alternatives",
          "works_count",
          "cited_by_count",
          "geo",
          "international",
          // "associated_institutions",
          "counts_by_year",
          "works_api_url",
          "updated_date",
          "created_date",
        ]) {
          var invalidJson = Map<String, dynamic>.from(jsonResponseMap);
          expect(invalidJson.remove(field), isNotNull);
          expect(() {
            return Institution.fromJson(invalidJson);
          }, throwsA(isA<CheckedFromJsonException>()));
        }
      });
      test('Return Institution when optional fields are null', () {
        var validJson = Map<String, dynamic>.from(jsonResponseMap);
        for (final field in [
          "mag",
          "grid",
          "wikipedia",
          "wikidata",
        ]) {
          expect(validJson['ids'].remove(field), isNotNull);
        }
        expect(Institution.fromJson(validJson), isA<Institution>());
      });
    });
  });
}
