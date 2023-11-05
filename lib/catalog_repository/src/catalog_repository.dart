import 'package:open_alex_api/open_alex_api.dart' hide Work;
import 'package:open_alex_api/open_alex_api.dart' as openAlexApi;
import 'package:research_assistant/catalog_repository/src/model/model.dart';

class CatalogRepository {
  CatalogRepository() : _openAlex = OpenAlexApiClient();

  final OpenAlexApiClient _openAlex;

  Work WorkFromApi(openAlexApi.Work work) {
    var abstractList = <String>[];
    if (work.abstractInvertedIndex != null) {
      int abstractLength = 0;
      for (final positions in work.abstractInvertedIndex!.values) {
        for (var position in positions) {
          if (position > abstractLength) {
            abstractLength = position;
          }
        }
      }
      abstractList = List.filled(abstractLength + 1, '');
      for (final word in work.abstractInvertedIndex!.keys) {
        for (final position in work.abstractInvertedIndex![word]!) {
          abstractList[position] = word;
        }
      }
    }

    return Work(
      title: work.title ?? '',
      authors: work.authorships.map((e) => e.author.displayName).toList(),
      abstract: abstractList.join(' '),
      primaryLocation: work.primaryLocation.source?.displayName ?? '',
      citedByCount: work.citedByCount,
      publicationYear: work.publicationYear,
      publicationDate: work.publicationDate,
      isOpenAccess: work.isOpenAccess,
      conceptsNames: work.concepts.map((e) => e.displayName).toList(),
      bestOaUrl: work.bestOaLocation != null && work.bestOaLocation!.pdfUrl != null
          ? Uri.parse(work.bestOaLocation!.pdfUrl!)
          : null,
    );
  }

  Future<List<Work>> searchWork(String query) async {
    final works = await _openAlex.searchWorks(query);
    return works.map(WorkFromApi).toList();
  }

  Future<Work> getWork(String id) async {
    final work = await _openAlex.getWork(id);
    return WorkFromApi(work);
  }
}
