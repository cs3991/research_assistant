part of 'search_cubit.dart';

class SearchState {
  final String query;

  const SearchState(this.query);
}

class SearchInitial extends SearchState {
  const SearchInitial() : super('');
}

class SearchResultLoading extends SearchState {
  const SearchResultLoading(super.query);
}

class SearchResultLoaded extends SearchState {
  final List<String> results;

  const SearchResultLoaded(super.query, this.results);
}
