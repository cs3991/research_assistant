part of 'search_cubit.dart';

class SearchState {
  const SearchState({
    required this.query,
    required this.page,
    this.works = const [],
  });

  final String query;
  final int page;
  final List<Work> works;
}

class SearchInitial extends SearchState {
  const SearchInitial() : super(query: '', page: 1);
}

class SearchWaitingRequest extends SearchState {
  const SearchWaitingRequest({required super.query}) : super(page: 1);
}

class SearchResultLoading extends SearchState {
  const SearchResultLoading({
    required super.query,
    required super.page,
    super.works,
  });
}

class SearchResultLoaded extends SearchState {
  const SearchResultLoaded({
    required super.query,
    required super.page,
    required this.results,
    super.works,
  });

  final List<Work> results;
}

class SearchResultError extends SearchState {
  const SearchResultError({
    required super.query,
    required super.page,
    required this.error,
    super.works,
  });

  final Object error;
}
