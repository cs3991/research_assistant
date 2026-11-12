import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/citation_neighborhood/citation_neighborhood_cubit.dart';
import 'package:research_assistant/collection/model/citation_network.dart';
import 'package:research_assistant/collection/view/citation_network_view.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';

class CitationNeighborhoodPage extends StatelessWidget {
  const CitationNeighborhoodPage({
    required this.work,
    required this.index,
    super.key,
  });
  final Work work;
  final int index;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => CitationNeighborhoodCubit(
      work: work,
      repository: context.read<CatalogRepository>(),
    )..loadMore(),
    child: _NeighborhoodPanel(work: work, index: index),
  );
}

class _NeighborhoodPanel extends StatefulWidget {
  const _NeighborhoodPanel({required this.work, required this.index});
  final Work work;
  final int index;

  @override
  State<_NeighborhoodPanel> createState() => _NeighborhoodPanelState();
}

class _NeighborhoodPanelState extends State<_NeighborhoodPanel> {
  bool _opening = false;
  Work get work => widget.work;
  int get index => widget.index;

  @override
  Widget build(BuildContext context) {
    final phone = context.watch<PhoneScreenCubit>().state;
    final last = context.watch<PageStackCubit>().state.stack.last;
    final selected = last is PublicationDetailsPage ? last.work : work;
    return Padding(
      padding: EdgeInsets.all(phone ? 0 : 16),
      child: Container(
        width: phone ? null : 760,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(phone ? 0 : 12),
        ),
        child: BlocBuilder<CitationNeighborhoodCubit, CitationNeighborhoodState>(
          builder: (context, state) {
            final network = CitationNetwork(state.works);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Retour',
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () =>
                          context.read<PageStackCubit>().pop(fromIndex: index),
                    ),
                    Expanded(
                      child: Text(
                        'Réseau de citations',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                Text(work.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(
                  '${network.nodes.length} articles chargés · ↑ Récents · ↓ Anciens',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (state.loading || _opening) const LinearProgressIndicator(),
                if (state.error != null)
                  const Text(
                    'Impossible de charger les citations. Vous pouvez réessayer.',
                  ),
                Expanded(
                  child: CitationNetworkView(
                    network: network,
                    focusWork: work,
                    selectedWork: selected,
                    onNodeTap: (article) async {
                      if (_opening) return;
                      setState(() => _opening = true);
                      try {
                        final full = await context
                            .read<CitationNeighborhoodCubit>()
                            .getDetails(article);
                        if (!context.mounted) return;
                        context.read<PageStackCubit>().showPublication(
                          fromIndex: index,
                          work: full,
                        );
                      } catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Impossible de charger cet article. Réessayez.',
                              ),
                            ),
                          );
                        }
                      } finally {
                        if (mounted) setState(() => _opening = false);
                      }
                    },
                  ),
                ),
                Text(
                  'Au centre : article actuel · Flèche : citant → cité · Taille : citations reçues',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (state.hasMore)
                  TextButton(
                    onPressed: state.loading
                        ? null
                        : context.read<CitationNeighborhoodCubit>().loadMore,
                    child: Text(
                      state.error == null
                          ? 'Charger plus de citations et de références'
                          : 'Réessayer',
                    ),
                  ),
                if (!state.loading &&
                    !state.hasMore &&
                    network.nodes.length == 1)
                  const Text('Aucun article citant ou cité disponible.'),
              ],
            );
          },
        ),
      ),
    );
  }
}
