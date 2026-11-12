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
  final _pages = <int, List<Work>>{};

  void updateQuery({required String query}) {
    _requestId++;
    _pages.clear();
    emit(SearchWaitingRequest(query: query));
  }

  Future<void> search({
    required String query,
    required int page,
    required int itemsPerPage,
  }) async {
    final requestId = ++_requestId;
    if (page == 1 || query != state.query) _pages.clear();
    final previousWorks = _pages.values.expand((works) => works).toList();
    if (query.trim().isEmpty) {
      emit(SearchResultLoaded(query: query, page: page, results: []));
      return;
    }
    emit(SearchResultLoading(query: query, page: page, works: previousWorks));
    try {
      final results = await _catalogRepository.searchWork(
        query,
        page: page,
        itemsPerPage: itemsPerPage,
      );
      if (isClosed || requestId != _requestId) return;
      _pages[page] = results;
      final pages = _pages.keys.toList()..sort();
      emit(
        SearchResultLoaded(
          query: query,
          page: page,
          results: results,
          works: List.unmodifiable(pages.expand((page) => _pages[page]!)),
        ),
      );
    } catch (e) {
      if (isClosed || requestId != _requestId) return;
      log('Erreur : query=$query, page=$page, error=$e');
      emit(
        SearchResultError(
          query: query,
          error: e,
          page: page,
          works: previousWorks,
        ),
      );
    }
  }
}
