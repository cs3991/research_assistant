import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  final _catalogRepository = CatalogRepository();

  void updateQuery({required String query}) {
    emit(SearchWaitingRequest(query: query));
  }

  Future<void> search({required String query, required int page, required int itemsPerPage}) async {
    if (query.isEmpty) {
      emit(SearchResultLoaded(query: query, page: page, results: []));
      return;
    }
    emit(SearchResultLoading(query: query, page: page));
    try {
      log('SearchCubit.search: query=$query, page=$page');
      final results = await _catalogRepository.searchWork(query, page: page, itemsPerPage: itemsPerPage);
      emit(SearchResultLoaded(query: query, page: page, results: results));
    } on Exception catch (e) {
      log('Erreur : query=$query, page=$page, error=$e');
      emit(SearchResultError(query: query, error: e, page: page));
    }
  }
}
