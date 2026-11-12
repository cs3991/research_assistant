import 'dart:convert';
import 'dart:io';

import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'json_response.dart';

void main() {
  group('Work', () {
    group('fromJson', () {
      var jsonResponseMap = jsonDecode(workJsonResponse);
      test('decodes preprints, diamond OA, funding and nullable metadata', () {
        final json =
            jsonDecode(
                  File('test/fixtures/works_current.json').readAsStringSync(),
                )['results'][0]
                as Map<String, dynamic>;
        json['type'] = 'preprint';
        json['open_access']['oa_status'] = 'diamond';
        json['primary_location'] = null;
        json['funders'] = [
          {'id': 'https://openalex.org/F1', 'display_name': 'Research fund'},
        ];
        json['awards'] = [
          {
            'id': 'https://openalex.org/G1',
            'funder_award_id': 'award-1',
            'funder_id': 'https://openalex.org/F1',
          },
        ];
        json.remove('concepts');
        final authorship = json['authorships'][0];
        authorship.remove('raw_affiliation_string');
        authorship['raw_affiliation_strings'] = ['University', 'Laboratory'];
        authorship['institutions'][0]['ror'] = null;
        authorship['institutions'][0]['country_code'] = null;
        final work = Work.fromJson(json);
        expect(work.type, WorkType.preprint);
        expect(work.openAccessStatus, OpenAccessStatus.diamond);
        expect(work.primaryLocation, isNull);
        expect(work.funders.single.displayName, 'Research fund');
        expect(work.awards.single.funderAwardId, 'award-1');
        expect(work.concepts, isEmpty);
        expect(
          work.authorships.first.rawAffiliationString,
          'University; Laboratory',
        );
        expect(work.authorships.first.institutions.first.ror, isNull);
      });

      test('maps unknown work types to other', () {
        final json = Map<String, dynamic>.from(jsonResponseMap)
          ..['type'] = 'future-type';
        expect(Work.fromJson(json).type, WorkType.other);
      });

      test('maps unknown access statuses to unknown', () {
        final json = Map<String, dynamic>.from(jsonResponseMap);
        json['open_access'] = {
          ...json['open_access'],
          'oa_status': 'future-status',
        };
        expect(Work.fromJson(json).openAccessStatus, OpenAccessStatus.unknown);
      });
    });
  });
}
