import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/navigation/cubit/layout_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchResultLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchResultLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                final work = state.results[index];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: InkResponse(
                      highlightShape: BoxShape.rectangle,
                      onTap: () {
                        // final publicationCubit = BlocProvider.of<PublicationCubit>(context);
                        // publicationCubit.showPublication(work);
                        final index = context
                            .read<LayoutCubit>()
                            .state
                            .stack
                            .indexWhere((element) => element is SearchPage);
                        context.read<LayoutCubit>().showPublication(fromIndex: index, work: work);
                        // Navigator.push<Widget>(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return BlocProvider.value(
                        //         value: publicationCubit,
                        //         child: PublicationDetails(),
                        //       );
                        //     },
                        //   ),
                        // );
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
                                      padding: EdgeInsets.symmetric(horizontal: 4),
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
                            work.authors.take(10).join(', '),
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
          );
        } else if (state is SearchResultError) {
          return Center(
            child: Text('Erreur: ${state.error}'),
          );
        } else {
          return const Center(
            child: Text('Aucun résultat'),
          );
        }
      },
    );
  }
}
