import 'package:open_alex_api/open_alex_api.dart' hide Work;
import 'package:open_alex_api/open_alex_api.dart' as open_alex_api;
import 'package:research_assistant/catalog_repository/src/model/model.dart';

class CatalogRepository {
  CatalogRepository({OpenAlexApiClient? openAlex})
    : _openAlex = openAlex ?? OpenAlexApiClient();

  final OpenAlexApiClient _openAlex;

  Work workFromApi(open_alex_api.Work work) {
    var abstractList = <String>[];
    if (work.abstractInvertedIndex != null) {
      var abstractLength = 0;
      for (final positions in work.abstractInvertedIndex!.values) {
        for (final position in positions) {
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
      primaryLocation: work.primaryLocation?.source?.displayName ?? '',
      citedByCount: work.citedByCount,
      publicationYear: work.publicationYear,
      publicationDate: work.publicationDate,
      isOpenAccess: work.isOpenAccess,
      doiUrl: work.doiId == null
          ? null
          : Uri.parse(
              work.doiId!.startsWith('http')
                  ? work.doiId!
                  : 'https://doi.org/${work.doiId}',
            ),
      conceptsNames: work.topics.isNotEmpty
          ? work.topics.map((e) => e.displayName).toList()
          : work.concepts.map((e) => e.displayName).toList(),
      bestOaUrl: _bestOaUrl(work),
      citationsCountByYear: work.countsByYear
          .map((e) => e.citedByCount)
          .toList(),
    );
  }

  static Uri? _bestOaUrl(open_alex_api.Work work) {
    final url =
        work.bestOaLocation?.pdfUrl ??
        work.bestOaLocation?.landingPageUrl ??
        work.openAccessUrl;
    return url == null ? null : Uri.tryParse(url);
  }

  Future<List<Work>> searchWork(
    String query, {
    int page = 1,
    required int itemsPerPage,
  }) async {
    final works = await _openAlex.searchWorks(
      query,
      page: page,
      itemsPerPage: itemsPerPage,
    );
    return works.map(workFromApi).toList();
  }

  Future<Work> getWork(String id) async {
    final work = await _openAlex.getWork(id);
    return workFromApi(work);
  }
}
