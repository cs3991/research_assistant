import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/collection/model/citation_layout.dart';
import 'package:research_assistant/collection/model/citation_network.dart';
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
                : _NetworkView(network: network),
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

class _NetworkView extends StatefulWidget {
  const _NetworkView({required this.network});
  final CitationNetwork network;
  @override
  State<_NetworkView> createState() => _NetworkViewState();
}

class _NetworkViewState extends State<_NetworkView> {
  late CitationLayout _layout;
  @override
  void initState() {
    super.initState();
    _layout = CitationLayout(widget.network);
  }

  @override
  void didUpdateWidget(_NetworkView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.network.nodes, widget.network.nodes)) {
      _layout = CitationLayout(widget.network);
    }
  }

  @override
  Widget build(BuildContext context) {
    final network = widget.network;
    final colors = Theme.of(context).colorScheme;
    final selectedWork = context.select((PageStackCubit cubit) {
      final page = cubit.state.stack.last;
      return page is PublicationDetailsPage ? page.work : null;
    });
    return InteractiveViewer(
      constrained: false,
      minScale: .2,
      maxScale: 4,
      boundaryMargin: const EdgeInsets.all(200),
      child: SizedBox(
        width: _layout.size.width,
        height: _layout.size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _LinksPainter(
                  network.links,
                  _layout,
                  colors.outlineVariant,
                ),
              ),
            ),
            for (var i = 0; i < network.nodes.length; i++)
              Positioned(
                left: _layout.points[i].dx - 70,
                top: _layout.points[i].dy - _layout.radii[i],
                width: 140,
                child: Tooltip(
                  message:
                      '${network.nodes[i].title}\n${network.nodes[i].citedByCount == null ? 'Citations inconnues' : '${network.nodes[i].citedByCount} citations'}',
                  child: Column(
                    children: [
                      Semantics(
                        button: true,
                        selected: selectedWork == network.nodes[i],
                        label: 'Ouvrir ${network.nodes[i].title}',
                        child: Material(
                          color: selectedWork == network.nodes[i]
                              ? colors.primary
                              : colors.primaryContainer,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: selectedWork == network.nodes[i]
                                  ? colors.onPrimaryContainer
                                  : colors.primary,
                              width: selectedWork == network.nodes[i] ? 3 : 1,
                            ),
                          ),
                          child: InkWell(
                            key: ValueKey(network.nodes[i]),
                            customBorder: const CircleBorder(),
                            onTap: () {
                              final navigation = context.read<PageStackCubit>();
                              final searchIndex = navigation.state.stack
                                  .indexWhere((page) => page is SearchPage);
                              if (searchIndex < 0) return;
                              navigation.showPublication(
                                fromIndex: searchIndex,
                                work: network.nodes[i],
                              );
                            },
                            child: SizedBox(
                              width: _layout.radii[i] * 2,
                              height: _layout.radii[i] * 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        CitationLayout.label(network.nodes[i]),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: selectedWork == network.nodes[i]
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LinksPainter extends CustomPainter {
  _LinksPainter(this.links, this.layout, this.color);
  final List<CitationLink> links;
  final CitationLayout layout;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (final link in links) {
      final from = layout.points[link.source];
      final to = layout.points[link.target];
      final distance = (to - from).distance;
      if (distance <= layout.radii[link.source] + layout.radii[link.target]) {
        continue;
      }
      final direction = (to - from) / distance;
      final end = to - direction * (layout.radii[link.target] + 2);
      final normal = Offset(-direction.dy, direction.dx);
      canvas
        ..drawLine(from + direction * layout.radii[link.source], end, paint)
        ..drawLine(end, end - direction * 7 + normal * 3, paint)
        ..drawLine(end, end - direction * 7 - normal * 3, paint);
    }
  }

  @override
  bool shouldRepaint(_LinksPainter oldDelegate) =>
      oldDelegate.layout != layout ||
      oldDelegate.color != color ||
      oldDelegate.links != links;
}
