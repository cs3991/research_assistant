import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit({required LayoutPage page}) : super(LayoutInitial(stack: [page]));

  void _push(LayoutPage page, int fromIndex) {
    var newStack = state.stack.sublist(0, fromIndex + 1) + [page];
    emit(LayoutLoaded(stack: newStack));
  }

  void showPublication(Work work, int fromIndex) {
    _push(PublicationDetailsPage(index: fromIndex + 1, work: work), fromIndex);
  }

  void showAuthor(int fromIndex) {
    _push(AuthorDetailsPage(index: fromIndex + 1), fromIndex);
  }

  void showSearch(int fromIndex) {
    _push(SearchPage(index: fromIndex + 1), fromIndex);
  }

  void pop(int fromIndex) {
    if (state.stack.length <= 1) {
      return;
    }
    var newStack = state.stack.sublist(0, fromIndex);
    emit(LayoutLoaded(stack: newStack));
  }
}
