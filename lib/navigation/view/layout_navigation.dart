import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/navigation/cubit/layout_cubit.dart';
import 'package:research_assistant/publication_details/view/publication_details.dart';
import 'package:research_assistant/search/view/search.dart';

class LayoutNavigation extends StatelessWidget {
  LayoutNavigation({super.key});

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(page: SearchPage(index: 0)),
      child: Builder(
        builder: (context) {
          return BlocBuilder<LayoutCubit, LayoutState>(
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return constraints.maxWidth > 900
                      ? Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.stack.length,
                            itemBuilder: (context, index) {
                              if (state.stack[index] is SearchPage) {
                                return const Search();
                              } else if (state.stack[index] is AuthorDetailsPage) {
                                return Padding(
                                  padding: EdgeInsets.all(constraints.maxWidth < 900 ? 0 : 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        constraints.maxWidth < 900 ? 0 : 12,
                                      ),
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                    ),
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth < 900 ? double.infinity : 500,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                  ),
                                );
                              } else if (state.stack[index] is PublicationDetailsPage) {
                                return PublicationDetails(
                                  work: (state.stack[index] as PublicationDetailsPage).work,
                                  index: index,
                                );
                              } else {
                                throw Exception('Unknown page type');
                              }
                            },
                          ),
                        )
                      : Stack(
                          children: List.generate(
                            state.stack.length,
                            (index) {
                              if (state.stack[index] is SearchPage) {
                                return const Search(
                                  fullscreen: true,
                                );
                              } else if (state.stack[index] is AuthorDetailsPage) {
                                return Padding(
                                  padding: EdgeInsets.all(constraints.maxWidth < 900 ? 0 : 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        constraints.maxWidth < 900 ? 0 : 12,
                                      ),
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                    ),
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth < 900 ? double.infinity : 500,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                  ),
                                );
                              } else if (state.stack[index] is PublicationDetailsPage) {
                                return PublicationDetails(
                                  work: (state.stack[index] as PublicationDetailsPage).work,
                                  index: index,
                                  fullscreen: true,
                                );
                              } else {
                                throw Exception('Unknown page type');
                              }
                            },
                          ),
                        );
                },
              );
            },
          );
        },
      ),
    );
  }
}
