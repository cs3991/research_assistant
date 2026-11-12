import 'package:flutter/material.dart';
import 'package:research_assistant/collection/view/library_sidebar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/collection/view/collection.dart';
import 'package:research_assistant/layout/cubit/navigation_cubit.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/layout/view/layout_navigation.dart';
import 'package:research_assistant/newsfeed/view/newsfeed.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     // statusBarColor: Theme.of(context).colorScheme.secondaryContainer,
    //     statusBarColor: Colors.transparent,
    //     // systemNavigationBarColor: Theme.of(context).colorScheme.
    //     systemNavigationBarColor: Colors.transparent,
    //   ),
    // );
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        // statusBarColor: Theme.of(context).colorScheme.secondaryContainer,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: ElevationOverlay.applySurfaceTint(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.surfaceTint,
          3,
        ),
        statusBarIconBrightness: Brightness.dark, // todo : brightness
        // systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NavigationCubit()),
            BlocProvider(create: (context) => SearchCubit()),
            BlocProvider(create: (context) => PhoneScreenCubit()),
            BlocProvider(
              create: (context) => PageStackCubit(page: SearchPage(index: 0)),
            ),
          ],
          child: LayoutBuilder(
            builder: (context, constraints) {
              context.read<PhoneScreenCubit>().constraintChanged(
                constraints.maxWidth,
              );
              return BlocBuilder<NavigationCubit, int>(
                builder: (BuildContext context, int index) {
                  final navigationBody = NavigationBody(index: index);
                  return BlocBuilder<PhoneScreenCubit, bool>(
                    builder: (context, isPhoneScreen) {
                      if (!isPhoneScreen) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                              child: SizedBox(
                                width: 240,
                                child: LibrarySidebar(
                                  selectedIndex: index,
                                  onDestinationSelected: context
                                      .read<NavigationCubit>()
                                      .showTabWithIndex,
                                ),
                              ),
                            ),
                            Expanded(child: navigationBody),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(child: navigationBody),
                            Builder(
                              builder: (BuildContext context) {
                                final currentNavBarTheme =
                                    NavigationBarTheme.of(context);
                                return MediaQuery(
                                  data: MediaQuery.of(
                                    context,
                                  ).removePadding(removeTop: true),
                                  child: NavigationBar(
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
                                        BlocProvider.of<NavigationCubit>(
                                          context,
                                        ).showTabWithIndex(newIndex),
                                  ),
                                );
                              },
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
  const NavigationBody({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [LayoutNavigation(), const NewsFeed(), const Collection()],
    );
  }
}
