import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:open_alex_api/open_alex_api.dart' as api;
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

void main() {
  late Map<String, dynamic> json;
  late CatalogRepository repository;

  setUp(() {
    final response =
        jsonDecode(
              File(
                'packages/open_alex_api/test/fixtures/works_current.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    json = (response['results'] as List<dynamic>)[1] as Map<String, dynamic>;
    final client = api.OpenAlexApiClient();
    addTearDown(client.close);
    repository = CatalogRepository(openAlex: client);
  });

  test('preserves DOI URLs and uses current Topics', () {
    final work = repository.workFromJson(json);
    expect(work.doiUrl.toString(), json['doi']);
    expect(
      work.conceptsNames,
      (json['topics'] as List<dynamic>).map(
        (e) => (e as Map<String, dynamic>)['display_name'],
      ),
    );
    expect(work.authors, isNotEmpty);
    expect(work.abstract, isNotEmpty);
  });

  test('converts all TMR results including authors without OpenAlex IDs', () {
    final response =
        jsonDecode(
              File(
                'packages/open_alex_api/test/fixtures/works_tmr.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    final results = (response['results'] as List)
        .map((json) => repository.workFromJson(json as Map<String, dynamic>))
        .toList();
    expect(results, hasLength(25));
    expect(results.map((work) => work.title), everyElement(isNotEmpty));
    expect(results.map((work) => work.authors), everyElement(isNotEmpty));
  });

  test('handles missing locations and uses the OA landing page', () {
    json['primary_location'] = null;
    (json['best_oa_location'] as Map)['pdf_url'] = null;
    final work = repository.workFromJson(json);
    expect(work.primaryLocation, isEmpty);
    expect(
      work.bestOaUrl.toString(),
      (json['best_oa_location'] as Map<String, dynamic>)['landing_page_url'],
    );
  });

  test('falls back to OA URL when there is no best location', () {
    json['best_oa_location'] = null;
    final work = repository.workFromJson(json);
    expect(
      work.bestOaUrl.toString(),
      (json['open_access'] as Map<String, dynamic>)['oa_url'],
    );
  });

  test('reconstructs abstract word positions and supports a bare DOI', () {
    json['abstract_inverted_index'] = {
      'science': [1, 3],
      'Open': [0],
      'for': [2],
    };
    (json['ids'] as Map<String, dynamic>)['doi'] = '10.1234/example';
    final work = repository.workFromJson(json);
    expect(work.abstract, 'Open science for science');
    expect(work.doiUrl.toString(), 'https://doi.org/10.1234/example');
  });
}
