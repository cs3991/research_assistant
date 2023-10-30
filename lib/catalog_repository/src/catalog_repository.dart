import 'package:open_alex_api/open_alex_api.dart' hide Work;
import 'package:research_assistant/catalog_repository/src/model/model.dart';

class CatalogRepository {
  CatalogRepository() : _openAlex = OpenAlexApiClient();

  final OpenAlexApiClient  _openAlex;

  Future<List<Work>> searchWork(String query) async {
    final works = await _openAlex.searchWorks(query);
    return works.map((e) => Work(title: e.title??'', author: e.authorships.map((e) => e.author.displayName).join(', '))).toList();
  }
}
