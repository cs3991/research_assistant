import 'package:bloc/bloc.dart';

class PhoneLayoutCubit extends Cubit<bool> {
  PhoneLayoutCubit() : super(false);

  void showPhoneLayout() {
    emit(true);
  }

  void showLargeScreenLayout() {
    emit(false);
  }

  void constraintChanged(double maxWidth) {
    if (maxWidth < 900) {
      showPhoneLayout();
    } else {
      showLargeScreenLayout();
    }
  }
}
