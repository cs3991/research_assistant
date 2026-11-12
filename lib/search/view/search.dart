import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/collection/view/citation_graph.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';
import 'package:research_assistant/search/view/search_field.dart';
import 'package:research_assistant/search/view/search_results.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _graphExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isPhoneScreen = context.watch<PhoneScreenCubit>().state;
    final hasActiveSearch = context.select(
      (SearchCubit cubit) => cubit.state.query.trim().isNotEmpty,
    );
    final canShowGraph = !isPhoneScreen && hasActiveSearch;
    final showGraph = canShowGraph && _graphExpanded;
    return Padding(
      padding: EdgeInsets.all(isPhoneScreen ? 0 : 16),
      child: Container(
        width: isPhoneScreen ? double.infinity : (showGraph ? 796 : 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isPhoneScreen ? 0 : 12),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    SearchField(
                      trailing: canShowGraph && !showGraph
                          ? IconButton(
                              tooltip: 'Déployer le graphe de citations',
                              onPressed: () =>
                                  setState(() => _graphExpanded = true),
                              icon: const Icon(Icons.chevron_right_rounded),
                            )
                          : null,
                    ),
                    const SizedBox(height: 16),
                    const SearchResults(),
                  ],
                ),
              ),
              if (showGraph) ...[
                const SizedBox(width: 16),
                CitationGraph(
                  onCollapse: () => setState(() => _graphExpanded = false),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
