import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:research_assistant/layout/cubit/layout_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

import '../../catalog_repository/src/model/work.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  static const _pageSize = 25;
  final PagingController<int, Work> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      log('listener called');
      context.read<SearchCubit>().search(query: context.read<SearchCubit>().state.query, page: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        log('state changed: $state');
        if (state is SearchWaitingRequest) {
          log('query changed: ${state.query}');
          _pagingController.refresh();
          log(_pagingController.value.status.toString());
        }
        if (state is SearchResultLoaded) {
          final isLastPage = state.results.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(state.results);
          } else {
            _pagingController.appendPage(state.results, state.page + 1);
          }
        } else if (state is SearchResultError) {
          _pagingController.error = state.error;
        }
      },
      builder: (context, state) {
        // if (state is SearchResultLoaded || state is SearchResultLoading) {
        return Expanded(
          child: PagedListView(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Work>(
              noItemsFoundIndicatorBuilder: (context) => Center(
                heightFactor: 1,
                widthFactor: 10,
                child: Text(
                  'Aucun résultat',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (context, work, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: InkResponse(
                      highlightShape: BoxShape.rectangle,
                      onTap: () {
                        final index = context
                            .read<LayoutCubit>()
                            .state
                            .stack
                            .indexWhere((element) => element is SearchPage);
                        context.read<LayoutCubit>().showPublication(fromIndex: index, work: work);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${work.publicationYear} - ${work.primaryLocation}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Icon(
                                        Icons.format_quote_rounded,
                                        size: 16,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      work.citedByCount.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            work.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            work.authors.take(5).join(', '),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
        // } else if (state is SearchResultError) {
        //   return Center(
        //     child: Text('Erreur: ${state.error}'),
        //   );
        // } else {
        //   return const Center(
        //     child: Text('Aucun résultat'),
        //   );
        // }
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
