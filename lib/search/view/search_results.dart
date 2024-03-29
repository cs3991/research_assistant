import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:research_assistant/catalog_repository/src/model/work.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  static const _pageSize = 25;
  final PagingController<int, Work> _pagingController = PagingController(firstPageKey: 1);
  static final _numberFormatter = NumberFormat.compactCurrency(
    locale: 'fr',
    symbol: '',
    decimalDigits: 0,
  )..maximumFractionDigits = 1;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<SearchCubit>().search(
            query: context.read<SearchCubit>().state.query,
            page: pageKey,
            itemsPerPage: _pageSize,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchWaitingRequest) {
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
                child: Text(
                  'Aucun résultat',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (context, work, index) {
                return BlocBuilder<PageStackCubit, PageStackState>(
                  builder: (context, pageStackState) {
                    final nextPage = pageStackState.stack.last;
                    final isSelected = nextPage is PublicationDetailsPage && nextPage.work == work;
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.outline.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? Theme.of(context).colorScheme.outline : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: InkResponse(
                            highlightShape: BoxShape.rectangle,
                            onTap: () {
                              final index = context
                                  .read<PageStackCubit>()
                                  .state
                                  .stack
                                  .indexWhere((element) => element is SearchPage);
                              context.read<PageStackCubit>().showPublication(fromIndex: index, work: work);
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
                                            _numberFormatter.format(work.citedByCount),
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
                      ),
                    );
                  },
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
