import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/collection/model/citation_layout.dart';
import 'package:research_assistant/collection/model/citation_network.dart';

class CitationNetworkView extends StatefulWidget {
  const CitationNetworkView({
    required this.network,
    required this.onNodeTap,
    this.selectedWork,
    this.focusWork,
    super.key,
  });
  final Work? selectedWork;
  final Work? focusWork;
  final ValueChanged<Work> onNodeTap;
  final CitationNetwork network;
  @override
  State<CitationNetworkView> createState() => _CitationNetworkViewState();
}

class _CitationNetworkViewState extends State<CitationNetworkView> {
  late CitationLayout _layout;
  @override
  void initState() {
    super.initState();
    _layout = CitationLayout(widget.network, focusWork: widget.focusWork);
  }

  @override
  void didUpdateWidget(CitationNetworkView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.network.nodes, widget.network.nodes) ||
        oldWidget.focusWork != widget.focusWork) {
      _layout = CitationLayout(widget.network, focusWork: widget.focusWork);
    }
  }

  @override
  Widget build(BuildContext context) {
    final network = widget.network;
    final colors = Theme.of(context).colorScheme;
    final selectedWork = widget.selectedWork;
    bool isSelected(Work article) =>
        selectedWork == article ||
        selectedWork?.id != null && selectedWork!.id == article.id;
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
                        selected: isSelected(network.nodes[i]),
                        label: 'Ouvrir ${network.nodes[i].title}',
                        child: Material(
                          color: isSelected(network.nodes[i])
                              ? colors.primary
                              : colors.primaryContainer,
                          shape: CircleBorder(
                            side: BorderSide(
                              color:
                                  (selectedWork == network.nodes[i] ||
                                      selectedWork?.id != null &&
                                          selectedWork!.id ==
                                              network.nodes[i].id)
                                  ? colors.onPrimaryContainer
                                  : colors.primary,
                              width:
                                  (selectedWork == network.nodes[i] ||
                                      selectedWork?.id != null &&
                                          selectedWork!.id ==
                                              network.nodes[i].id)
                                  ? 3
                                  : 1,
                            ),
                          ),
                          child: InkWell(
                            key: ValueKey(network.nodes[i]),
                            customBorder: const CircleBorder(),
                            onTap: () => widget.onNodeTap(network.nodes[i]),
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
                          fontWeight: isSelected(network.nodes[i])
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
