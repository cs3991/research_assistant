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
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, layoutState) {
        return BlocBuilder<PhoneScreenCubit, bool>(
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
                    return itemBuilder(
                      context: context,
                      stack: layoutState.stack,
                      index: index,
                      isPhoneScreen: isPhoneScreen,
                    );
                  },
                ),
              );
            } else {
              return Stack(
                children: List.generate(
                  layoutState.stack.length,
                  (index) {
                    return itemBuilder(
                      context: context,
                      stack: layoutState.stack,
                      index: index,
                      isPhoneScreen: isPhoneScreen,
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget itemBuilder({
    required BuildContext context,
    required List stack,
    required int index,
    required bool isPhoneScreen,
  }) {
    if (stack[index] is SearchPage) {
      return const Search();
    } else if (stack[index] is AuthorDetailsPage) {
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
    } else if (stack[index] is PublicationDetailsPage) {
      return PublicationDetails(
        work: (stack[index] as PublicationDetailsPage).work,
        index: index,
      );
    } else {
      throw Exception('Unknown page type');
    }
  }
}
