part of 'search_cubit.dart';

class SearchState {
  const SearchState({required this.query, required this.page});

  final String query;
  final int page;
}

class SearchInitial extends SearchState {
  const SearchInitial() : super(query: '', page: 0);
}

class SearchWaitingRequest extends SearchState {
  const SearchWaitingRequest({required this.query}) : super(query: query, page: 0);

  final String query;
}

class SearchResultLoading extends SearchState {
  const SearchResultLoading({required super.query, required super.page});
}

class SearchResultLoaded extends SearchState {
  const SearchResultLoaded({required super.query, required super.page, required this.results});

  final List<Work> results;
}

class SearchResultError extends SearchState {
  const SearchResultError({required super.query, required super.page, required this.error});

  final Object error;
}
