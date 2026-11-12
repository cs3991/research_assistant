import 'dart:io';

import 'package:open_alex_api/open_alex_api.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

/// Optional live check. Unit tests use recorded responses and require no key.
Future<void> main(List<String> arguments) async {
  final query = arguments.isEmpty ? 'machine learning' : arguments.join(' ');
  final client = OpenAlexApiClient(
    apiKey: Platform.environment['OPENALEX_API_KEY'],
  );
  final repository = CatalogRepository(openAlex: client);
  try {
    final works = await client.searchWorksData(
      query,
      page: 1,
      itemsPerPage: 25,
    );
    if (works.isEmpty) {
      throw StateError('The search returned no works');
    }
    final detail = await repository.getWork(works.first['id'] as String);
    final secondPage = await repository.searchWork(
      query,
      page: 2,
      itemsPerPage: 25,
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
