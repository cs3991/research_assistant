import 'dart:io';

import 'package:open_alex_api/open_alex_api.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

/// Optional live check. Unit tests use recorded responses and require no key.
Future<void> main() async {
  final client = OpenAlexApiClient(
    apiKey: Platform.environment['OPENALEX_API_KEY'],
  );
  final repository = CatalogRepository(openAlex: client);
  try {
    final works = await client.searchWorks(
      'machine learning',
      page: 1,
      itemsPerPage: 3,
    );
    if (works.isEmpty) {
      throw StateError('The search returned no works');
    }
    final detail = await repository.getWork(works.first.id);
    final secondPage = await repository.searchWork(
      'machine learning',
      page: 2,
      itemsPerPage: 3,
    );
    if (secondPage.isEmpty) {
      throw StateError('The second page returned no works');
    }
    stdout
      ..writeln(
        'Search: ${works.length} results; page 2: ${secondPage.length} results',
      )
      ..writeln('Detail: ${detail.title}; DOI: ${detail.doiUrl}')
      ..writeln('Topics: ${detail.conceptsNames.join(', ')}');
  } finally {
    client.close();
  }
}
