import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:research_assistant/navigation/cubit/navigation_cubit.dart';
import 'package:research_assistant/navigation/navigation.dart';

void main() {
  group('NavigationCubit', () {
    test('initial state is 0', () {
      expect(NavigationCubit().state, equals(0));
    });

    blocTest<NavigationCubit, int>(
      'emits [0] when showFeed is called',
      build: NavigationCubit.new,
      act: (cubit) => cubit.showFeed(),
      expect: () => [equals(0)],
    );

    blocTest<NavigationCubit, int>(
      'emits [1] when showCollection is called',
      build: NavigationCubit.new,
      act: (cubit) => cubit.showCollection(),
      expect: () => [equals(1)],
    );

    blocTest<NavigationCubit, int>(
      'emits [0] when showTabWithIndex(0) is called',
      build: NavigationCubit.new,
      act: (cubit) => cubit.showTabWithIndex(0),
      expect: () => [equals(0)],
    );
  });
}
