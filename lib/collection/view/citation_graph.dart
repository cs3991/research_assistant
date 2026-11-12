import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/collection/model/citation_network.dart';
import 'package:research_assistant/collection/view/citation_network_view.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class CitationGraph extends StatelessWidget {
  const CitationGraph({required this.onCollapse, super.key});
  final VoidCallback onCollapse;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchCubit>().state;
    final network = CitationNetwork(state.works);
    return SizedBox(
      width: 620,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Connexions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                tooltip: 'Rétracter le graphe de citations',
                onPressed: onCollapse,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
            ],
          ),
          Text(
            '${network.nodes.length} articles · ${network.links.length} citations',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            '↑ Articles récents · ↓ Articles anciens',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (network.nodes.any((work) => work.publicationYear == null))
            Text(
              'Articles sans année : zone séparée en bas',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          if (state is SearchResultLoading) const LinearProgressIndicator(),
          if (state is SearchResultError)
            const Text('Impossible de charger les derniers résultats.'),
          if (network.nodes.isNotEmpty && network.links.isEmpty)
            Text(
              'Aucune citation entre les articles chargés.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          Expanded(
            child: network.nodes.isEmpty
                ? Center(
                    child: Text(
                      state is SearchResultLoading
                          ? 'Chargement des articles…'
                          : 'Aucun article à afficher.',
                    ),
                  )
                : CitationNetworkView(
                    network: network,
                    selectedWork: context.select((PageStackCubit cubit) {
                      final page = cubit.state.stack.last;
                      return page is PublicationDetailsPage ? page.work : null;
                    }),
                    onNodeTap: (work) {
                      final navigation = context.read<PageStackCubit>();
                      final index = navigation.state.stack.indexWhere(
                        (page) => page is SearchPage,
                      );
                      if (index >= 0) {
                        navigation.showPublication(
                          fromIndex: index,
                          work: work,
                        );
                      }
                    },
                  ),
          ),
          if (network.links.isNotEmpty)
            Text(
              'Flèche : citant → cité · Taille : citations reçues',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          Text(
            'Déplacer pour explorer · Pincer ou faire défiler pour zoomer',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
