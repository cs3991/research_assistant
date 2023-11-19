import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/layout/cubit/layout_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
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
            builder: (context, layoutState) {
              return BlocBuilder<PhoneLayoutCubit, bool>(
                builder: (context, isPhoneScreen) {
                  if (!isPhoneScreen) {
                    return Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: layoutState.stack.length,
                        itemBuilder: (context, index) {
                          if (layoutState.stack[index] is SearchPage) {
                            return const Search();
                          } else if (layoutState.stack[index] is AuthorDetailsPage) {
                            return Padding(
                              padding: EdgeInsets.all(isPhoneScreen ? 0 : 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    isPhoneScreen ? 0 : 12,
                                  ),
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: isPhoneScreen ? double.infinity : 500,
                                ),
                                padding: const EdgeInsets.all(16),
                              ),
                            );
                          } else if (layoutState.stack[index] is PublicationDetailsPage) {
                            return PublicationDetails(
                              work: (layoutState.stack[index] as PublicationDetailsPage).work,
                              index: index,
                            );
                          } else {
                            throw Exception('Unknown page type');
                          }
                        },
                      ),
                    );
                  } else {
                    return Stack(
                      children: List.generate(
                        layoutState.stack.length,
                        (index) {
                          if (layoutState.stack[index] is SearchPage) {
                            return const Search();
                          } else if (layoutState.stack[index] is AuthorDetailsPage) {
                            return Padding(
                              padding: EdgeInsets.all(isPhoneScreen ? 0 : 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    isPhoneScreen ? 0 : 12,
                                  ),
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: isPhoneScreen ? double.infinity : 500,
                                ),
                                padding: const EdgeInsets.all(16),
                              ),
                            );
                          } else if (layoutState.stack[index] is PublicationDetailsPage) {
                            return PublicationDetails(
                              work: (layoutState.stack[index] as PublicationDetailsPage).work,
                              index: index,
                            );
                          } else {
                            throw Exception('Unknown page type');
                          }
                        },
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
