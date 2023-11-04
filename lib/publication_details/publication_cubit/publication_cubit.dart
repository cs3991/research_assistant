import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:research_assistant/catalog_repository/src/catalog_repository.dart';
import 'package:research_assistant/catalog_repository/src/model/work.dart';

part 'publication_state.dart';

class PublicationCubit extends Cubit<Work?> {
  PublicationCubit() : super(null);
  final repository = CatalogRepository();

  void showPublication(Work work) {
    emit(work);
  }

  Future<void> fetchPublication(String id) async {
    emit(null);
    final work = await repository.getWork(id);
    emit(work);
  }
}
