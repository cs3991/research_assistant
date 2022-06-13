import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/collection/view/collection.dart';
import 'package:research_assistant/navigation/cubit/navigation_cubit.dart';
import 'package:research_assistant/newsfeed/view/newsfeed.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: BlocBuilder<NavigationCubit, int>(
              builder: (BuildContext context, int index) {
                if (constraints.maxWidth > 900) {
                  return Row(
                    children: [
                      NavigationRail(
                        groupAlignment: 0,
                        destinations: const [
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
                            BlocProvider.of<NavigationCubit>(context)
                                .showTabWithIndex(newIndex),
                      ),
                      NavigationBody(index: index),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      NavigationBody(index: index),
                      NavigationBar(
                        destinations: const [
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
                            BlocProvider.of<NavigationCubit>(context)
                                .showTabWithIndex(newIndex),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class NavigationBody extends StatelessWidget {
  const NavigationBody({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(
        builder: (context) {
          if (index == 0) {
            return const NewsFeed();
          }
          if (index == 1) {
            return const Collection();
          } else {
            return ColoredBox(
              color: Theme.of(context).colorScheme.surface,
              child: const Text('Unknown'),
            );
          }
        },
      ),
    );
  }
}
