part of 'search_cubit.dart';

class SearchState {
  const SearchState(this.query);

  final String query;
}

class SearchInitial extends SearchState {
  const SearchInitial() : super('');
}

class SearchResultLoading extends SearchState {
  const SearchResultLoading(super.query);
}

class SearchResultLoaded extends SearchState {
  const SearchResultLoaded(super.query, this.results);

  final List<Work> results;
}

class SearchResultError extends SearchState {
  const SearchResultError(super.query, this.error);

  final Object error;
}
