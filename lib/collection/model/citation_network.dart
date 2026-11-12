import 'package:research_assistant/catalog_repository/catalog_repository.dart';

class CitationLink {
  const CitationLink(this.source, this.target);
  final int source;
  final int target;
}

/// Only citations whose two endpoints occur in the loaded search results.
class CitationNetwork {
  CitationNetwork(List<Work> works) {
    final indices = <String, int>{};
    for (final work in works) {
      final id = _workId(work.id);
      if (id != null && indices.containsKey(id)) continue;
      if (id != null) indices[id] = nodes.length;
      nodes.add(work);
    }
    for (var source = 0; source < nodes.length; source++) {
      final targets = <int>{};
      for (final reference in nodes[source].referencedWorkIds) {
        final target = indices[_workId(reference)];
        if (target != null && target != source && targets.add(target)) {
          links.add(CitationLink(source, target));
        }
      }
    }
  }

  final nodes = <Work>[];
  final links = <CitationLink>[];

  static String? _workId(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value
        .trim()
        .split('/')
        .where((part) => part.isNotEmpty)
        .last
        .toUpperCase();
  }
}
