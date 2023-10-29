import 'package:bloc/bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());



  void search(String query) {
    emit(SearchResultLoading(query));

  }
}