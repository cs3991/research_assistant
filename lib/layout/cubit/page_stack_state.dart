part of 'page_stack_cubit.dart';

@immutable
abstract class PageStackState {
  const PageStackState({required this.stack});

  final List<LayoutPage> stack;
}

class LayoutInitial extends PageStackState {
  const LayoutInitial({required super.stack});
}

class LayoutLoading extends PageStackState {
  const LayoutLoading({required super.stack});
}

class LayoutLoaded extends PageStackState {
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
