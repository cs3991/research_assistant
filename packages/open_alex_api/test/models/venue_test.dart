import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'json_response.dart';

main() {
  group('Venue', () {
    group('fromJson', () {
      var jsonResponseMap = jsonDecode(venueJsonResponse);
      test('throws CheckedFromJsonException when one required field is missing',
          () {
        for (final field in [
          "id",
          "display_name",
          "issn_l",
          "issn",
          "publisher",
          "works_count",
          "cited_by_count",
          "is_oa",
          "is_in_doaj",
          "homepage_url",
          "counts_by_year",
          "works_api_url",
          "updated_date",
          "created_date",
        ]) {
          var invalidJson = Map<String, dynamic>.from(jsonResponseMap);
          expect(invalidJson.remove(field), isNotNull);
          expect(() {
            return Venue.fromJson(invalidJson);
          }, throwsA(isA<CheckedFromJsonException>()));
        }
      });
    });
  });
}
