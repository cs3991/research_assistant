import 'package:bloc/bloc.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  final _catalogRepository = CatalogRepository();

  void updateQuery({required String query}) {
    emit(SearchWaitingRequest(query: query));
  }

  Future<void> search({required String query, required int page}) async {
    emit(SearchResultLoading(query: query, page: page));
    try {
      // final results = await _catalogRepository.searchWork(query);
      print('SearchCubit.search: query=$query, page=$page');
      final results = page < 5
          ? await Future.delayed(
              Duration(seconds: 1),
              () => List.generate(
                  25,
                  (index) => Work(
                        title: 'Title page $page $index',
                        authors: List.generate(3, (index) => 'Author $index'),
                        publicationDate: DateTime(2021, 1, 1),
                        abstract: 'Abstract page $page $index',
                        citedByCount: 0,
                        conceptsNames: List.generate(3, (index) => 'Concept $index'),
                        doiUrl: Uri.parse('https://doi.org/10.1000/xyz123'),
                        isOpenAccess: true,
                        primaryLocation: 'Primary location page $page $index',
                        publicationYear: 2021,
                        bestOaUrl: Uri.parse('https://doi.org/10.1000/xyz123'),
                      )))
          : <Work>[];
      emit(SearchResultLoaded(query: query, page: page, results: results));
    } on Exception catch (e) {
      emit(SearchResultError(query: query, error: e, page: page));
    }
  }
}
