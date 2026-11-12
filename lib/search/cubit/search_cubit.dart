import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({CatalogRepository? catalogRepository})
    : _catalogRepository = catalogRepository ?? CatalogRepository(),
      super(const SearchInitial());

  final CatalogRepository _catalogRepository;
  int _requestId = 0;

  void updateQuery({required String query}) {
    _requestId++;
    emit(SearchWaitingRequest(query: query));
  }

  Future<void> search({
    required String query,
    required int page,
    required int itemsPerPage,
  }) async {
    final requestId = ++_requestId;
    if (query.trim().isEmpty) {
      emit(SearchResultLoaded(query: query, page: page, results: []));
      return;
    }
    emit(SearchResultLoading(query: query, page: page));
    try {
      final results = await _catalogRepository.searchWork(
        query,
        page: page,
        itemsPerPage: itemsPerPage,
      );
      if (isClosed || requestId != _requestId) return;
      emit(SearchResultLoaded(query: query, page: page, results: results));
    } catch (e) {
      if (isClosed || requestId != _requestId) return;
      log('Erreur : query=$query, page=$page, error=$e');
      emit(SearchResultError(query: query, error: e, page: page));
    }
  }
}
