import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void showFeed() {
    emit(0);
  }

  void showCollection() {
    emit(1);
  }

  void showTabWithIndex(int i) {
    emit(i);
  }
}
