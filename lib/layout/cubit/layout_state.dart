part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {
  const LayoutState({required this.stack});

  final List<LayoutPage> stack;
}

class LayoutInitial extends LayoutState {
  const LayoutInitial({required super.stack});
}

class LayoutLoading extends LayoutState {
  const LayoutLoading({required super.stack});
}

class LayoutLoaded extends LayoutState {
  const LayoutLoaded({required super.stack});
}

/// A class representing a page
abstract class LayoutPage {
  LayoutPage({required this.index});

  final int index;
}

class PublicationDetailsPage extends LayoutPage {
  PublicationDetailsPage({required super.index, required this.work});

  final Work work;
}

class AuthorDetailsPage extends LayoutPage {
  AuthorDetailsPage({required super.index});
}

class SearchPage extends LayoutPage {
  SearchPage({required super.index});
}
