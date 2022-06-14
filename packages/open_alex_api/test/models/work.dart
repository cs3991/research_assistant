import 'package:json_annotation/json_annotation.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'json_response.dart';

void main() {
  group('Work', () {
    group('fromJson', () {
      test('throws CheckedFromJsonException when WorkType enum is unknown', () {
        expect(() {
          var invalidJson = Map<String, dynamic>.from(jsonResponse);
          invalidJson['type'] = 'unknown';
          return Work.fromJson(invalidJson);
        }, throwsA(isA<CheckedFromJsonException>()));
      });

      test(
          'throws CheckedFromJsonException when OpenAccessStatus enum is unknown',
          () {
        expect(() {
          var invalidJson = Map<String, dynamic>.from(jsonResponse);
          var openAccess =
              Map<String, dynamic>.from(jsonResponse['open_access']);
          openAccess['oa_status'] = 'unknown';
          invalidJson['open_access'] = openAccess;
          return Work.fromJson(invalidJson);
        }, throwsA(isA<CheckedFromJsonException>()));
      });

      test('throws CheckedFromJsonException when one required field is missing',
          () {
        for (final field in [
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
          var invalidJson = Map<String, dynamic>.from(jsonResponse);
          invalidJson.remove(field);
          expect(() {
            return Work.fromJson(invalidJson);
          }, throwsA(isA<CheckedFromJsonException>()));
        }
      });

      test('correctly decodes json', () {
        expect(
            Work.fromJson(jsonResponse),
            isA<Work>()
                .having((e) => e.title, 'title',
                    'éThe state of OA: a large-scale analysis of the prevalence and impact of Open Access articles')
                .having(
                    (e) => e.citedByCountsByYear, 'cited by count by year', {
                  2022: 13,
                  2021: 108,
                  2020: 126,
                  2019: 97,
                  2018: 47,
                  2017: 6
                })
                .having((e) => e.citedByCount, 'cited by count', 394)
                .having(
                    (e) => e.type, 'type', isIn([WorkType.journalArticle])));
      });
    });
  });
}
