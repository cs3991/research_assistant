import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'json_response.dart';

void main() {
  group('Work', () {
    group('fromJson', () {
      var jsonResponseMap = jsonDecode(workJsonResponse);
      test('throws CheckedFromJsonException when WorkType enum is unknown', () {
        expect(() {
          var invalidJson = Map<String, dynamic>.from(jsonResponseMap);
          invalidJson['type'] = 'unknown';
          return Work.fromJson(invalidJson);
        }, throwsA(isA<CheckedFromJsonException>()));
      });

      test(
          'throws CheckedFromJsonException when OpenAccessStatus enum is unknown',
          () {
        expect(() {
          var invalidJson = Map<String, dynamic>.from(jsonResponseMap);
          var openAccess =
              Map<String, dynamic>.from(jsonResponseMap['open_access']);
          openAccess['oa_status'] = 'unknown';
          invalidJson['open_access'] = openAccess;
          return Work.fromJson(invalidJson);
        }, throwsA(isA<CheckedFromJsonException>()));
      });

      test('throws CheckedFromJsonException when one required field is missing',
          () {
        for (final field in [
          "id",
          "type",
          "title",
          "display_name",
          "publication_year",
          "publication_date",
          "cited_by_count",
          "open_access",
          "is_retracted",
          "is_paratext",
          "cited_by_api_url",
          "counts_by_year",
          "updated_date",
          "created_date",
        ]) {
          var invalidJson = Map<String, dynamic>.from(jsonResponseMap);
          expect(invalidJson.remove(field), isNotNull);
          expect(() {
            return Work.fromJson(invalidJson);
          }, throwsA(isA<CheckedFromJsonException>()));
        }
      });
      test('returns Work when all required fields are present', () {
        var validJson = Map<String, dynamic>.from(jsonResponseMap);
        for (final field in [
          'mag',
          'doi',
          'pmid',
          'pmcid',
        ]) {
          expect(validJson['ids'].remove(field), isNotNull);
        }
        expect(validJson['open_access'].remove('oa_url'), isNotNull);
        expect(Work.fromJson(validJson), isA<Work>());
      });
    });
  });
}
