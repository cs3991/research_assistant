import 'package:bloc/bloc.dart';
import 'package:research_assistant/catalog_repository/src/catalog_repository.dart';
import 'package:research_assistant/catalog_repository/src/model/work.dart';


class PublicationCubit extends Cubit<Work?> {
  PublicationCubit({Work? work}) : super(work) {
    print(work);
  }

  final repository = CatalogRepository();

  void showPublication(Work work) {
    emit(work);
  }

  Future<void> fetchAndShowPublication(String id) async {
    emit(null);
    final work = await repository.getWork(id);
    emit(work);
  }
}
