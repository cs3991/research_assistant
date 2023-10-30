import 'package:bloc/bloc.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  final _catalogRepository = CatalogRepository();

  Future<void> search(String query) async {
    emit(SearchResultLoading(query));
    try {
      final results = await _catalogRepository.searchWork(query);
      emit(SearchResultLoaded(query, results));
    }
    on Exception catch (e) {
      emit(SearchResultError(query, e));
    }
  }
}
