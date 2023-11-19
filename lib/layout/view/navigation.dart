import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/collection/view/collection.dart';
import 'package:research_assistant/layout/cubit/navigation_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/layout/view/layout_navigation.dart';
import 'package:research_assistant/newsfeed/view/newsfeed.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NavigationCubit()),
            BlocProvider(create: (context) => SearchCubit()),
            BlocProvider(create: (context) => PhoneLayoutCubit()),
          ],
          child: LayoutBuilder(
            builder: (context, constraints) {
              context.read<PhoneLayoutCubit>().constraintChanged(constraints.maxWidth);
              return BlocBuilder<NavigationCubit, int>(
                builder: (BuildContext context, int index) {
                  return BlocBuilder<PhoneLayoutCubit, bool>(
                    builder: (context, isPhoneScreen) {
                      if (!isPhoneScreen) {
                        return Row(
                          children: [
                            NavigationRail(
                              groupAlignment: 0,
                              destinations: const [
                                NavigationRailDestination(
                                  icon: Icon(Icons.search_rounded),
                                  label: Text('Rechercher'),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(Icons.rss_feed_rounded),
                                  label: Text('Nouveautés'),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(Icons.library_books_rounded),
                                  label: Text('Collection'),
                                ),
                              ],
                              labelType: NavigationRailLabelType.selected,
                              selectedIndex: index,
                              onDestinationSelected: (int newIndex) =>
                                  BlocProvider.of<NavigationCubit>(context).showTabWithIndex(newIndex),
                            ),
                            Expanded(
                              child: NavigationBody(index: index),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: NavigationBody(index: index),
                            ),
                            NavigationBar(
                              destinations: const [
                                NavigationDestination(
                                  icon: Icon(Icons.search_rounded),
                                  label: 'Rechercher',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.rss_feed_rounded),
                                  label: 'Nouveautés',
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.library_books_rounded),
                                  label: 'Collection',
                                ),
                              ],
                              selectedIndex: index,
                              onDestinationSelected: (int newIndex) =>
                                  BlocProvider.of<NavigationCubit>(context).showTabWithIndex(newIndex),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class NavigationBody extends StatelessWidget {
  const NavigationBody({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (index == 0) {
          return LayoutNavigation();
        }
        if (index == 1) {
          return const NewsFeed();
        }
        if (index == 2) {
          return const Collection();
        } else {
          return ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: const Text('Unknown'),
          );
        }
      },
    );
  }
}
