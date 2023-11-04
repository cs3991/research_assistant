import 'package:open_alex_api/open_alex_api.dart' hide Work;
import 'package:research_assistant/catalog_repository/src/model/model.dart';

class CatalogRepository {
  CatalogRepository() : _openAlex = OpenAlexApiClient();

  final OpenAlexApiClient _openAlex;

  Future<List<Work>> searchWork(String query) async {
    final works = await _openAlex.searchWorks(query);
    return works.map(Work.fromApi).toList();
  }

  Future<Work> getWork(String id) async {
    final work = await _openAlex.getWork(id);
    return Work.fromApi(work);
  }
}
