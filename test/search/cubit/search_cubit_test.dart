import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late MockCatalogRepository repository;
  late SearchCubit cubit;

  setUp(() {
    repository = MockCatalogRepository();
    cubit = SearchCubit(catalogRepository: repository);
  });
  tearDown(() => cubit.close());

  Future<void> search(String query) =>
      cubit.search(query: query, page: 1, itemsPerPage: 50);

  test('forwards search and pagination and emits results', () async {
    when(
      () => repository.searchWork('science', page: 2, itemsPerPage: 50),
    ).thenAnswer((_) async => []);
    final states = expectLater(
      cubit.stream,
      emitsInOrder([isA<SearchResultLoading>(), isA<SearchResultLoaded>()]),
    );
    await cubit.search(query: 'science', page: 2, itemsPerPage: 50);
    await states;
    expect(cubit.state.query, 'science');
    expect(cubit.state.page, 2);
  });

  test('empty and whitespace searches do not call the API', () async {
    await search('');
    await search('   ');
    expect(cubit.state, isA<SearchResultLoaded>());
    verifyZeroInteractions(repository);
  });

  for (final error in [Exception('Network unavailable'), TypeError()]) {
    test('reports ${error.runtimeType} and allows retry', () async {
      when(
        () => repository.searchWork('science', page: 1, itemsPerPage: 50),
      ).thenAnswer((_) async => throw error);
      await search('science');
      expect((cubit.state as SearchResultError).error, same(error));
      when(
        () => repository.searchWork('science', page: 1, itemsPerPage: 50),
      ).thenAnswer((_) async => []);
      await search('science');
      expect(cubit.state, isA<SearchResultLoaded>());
    });
  }

  for (final fails in [false, true]) {
    test('ignores obsolete ${fails ? 'errors' : 'results'}', () async {
      final pending = Completer<List<Work>>();
      when(
        () => repository.searchWork('old', page: 1, itemsPerPage: 50),
      ).thenAnswer((_) => pending.future);
      when(
        () => repository.searchWork('new', page: 1, itemsPerPage: 50),
      ).thenAnswer((_) async => []);
      final oldSearch = search('old');
      cubit.updateQuery(query: 'new');
      await search('new');
      if (fails) {
        pending.completeError(Exception('Old request failed'));
      } else {
        pending.complete([]);
      }
      await oldSearch;
      expect(cubit.state, isA<SearchResultLoaded>());
      expect(cubit.state.query, 'new');
    });
  }

  test('can close while a request is pending', () async {
    final pending = Completer<List<Work>>();
    when(
      () => repository.searchWork('science', page: 1, itemsPerPage: 50),
    ).thenAnswer((_) => pending.future);
    final request = search('science');
    await cubit.close();
    pending.complete([]);
    await request;
  });
}
