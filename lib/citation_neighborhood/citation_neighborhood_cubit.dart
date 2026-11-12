import 'package:bloc/bloc.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

class CitationNeighborhoodState {
  const CitationNeighborhoodState({
    required this.works,
    this.loading = false,
    this.hasMore = true,
    this.error,
  });
  final List<Work> works;
  final bool loading;
  final bool hasMore;
  final Object? error;
}

class CitationNeighborhoodCubit extends Cubit<CitationNeighborhoodState> {
  CitationNeighborhoodCubit({required this.work, required this.repository})
    : super(CitationNeighborhoodState(works: [work]));
  final Work work;
  final CatalogRepository repository;
  int _page = 0;
  final _details = <String, Future<Work>>{};

  Future<Work> getDetails(Work article) async {
    if (!article.isSummary || article.id == null) return article;
    final id = article.id!;
    try {
      return await (_details[id] ??= repository.getWork(id));
    } catch (_) {
      final _ = _details.remove(id);
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (state.loading || !state.hasMore) return;
    final previous = state;
    emit(
      CitationNeighborhoodState(
        works: previous.works,
        loading: true,
        hasMore: previous.hasMore,
      ),
    );
    try {
      final result = await repository.getCitationNeighborhood(
        work,
        page: _page + 1,
      );
      if (isClosed) return;
      _page++;
      emit(
        CitationNeighborhoodState(
          works: List.unmodifiable([...previous.works, ...result.works]),
          hasMore: result.hasMore,
        ),
      );
    } catch (error) {
      if (!isClosed) {
        emit(
          CitationNeighborhoodState(
            works: previous.works,
            hasMore: previous.hasMore,
            error: error,
          ),
        );
      }
    }
  }
}
