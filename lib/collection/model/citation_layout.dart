import 'dart:math' as math;
import 'dart:ui';

import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/collection/model/citation_network.dart';

/// Citations attract horizontally; year bands keep recent papers above older ones.
class CitationLayout {
  CitationLayout(CitationNetwork network) {
    final count = network.nodes.length;
    final side = math.max<double>(560, math.sqrt(count) * 115);
    final years =
        network.nodes
            .map((work) => work.publicationYear)
            .whereType<int>()
            .toSet()
            .toList()
          ..sort();
    final hasUndated = network.nodes.any(
      (work) => work.publicationYear == null,
    );
    size = Size(side, side + (hasUndated && years.isNotEmpty ? 120 : 0));
    final targets = <int, double>{};
    if (years.isNotEmpty) {
      final span = years.last - years.first;
      for (final year in years) {
        targets[year] = span == 0
            ? side / 2
            : 80 + (years.last - year) / span * (side - 160);
      }
    }
    final bands = List.generate(count, (i) {
      final year = network.nodes[i].publicationYear;
      if (year == null) {
        return (
          center: years.isEmpty ? side / 2 : side + 50,
          slack: years.isEmpty ? side / 2 - 60 : 20.0,
        );
      }
      final center = targets[year]!;
      var slack = side / 2 - 80;
      for (final other in years) {
        if (other != year) {
          slack = math.min(slack, (targets[other]! - center).abs() * .3);
        }
      }
      return (center: center, slack: slack);
    });
    radii = network.nodes.map((work) {
      // Circle area is proportional to citation count; unknown/zero values
      // retain a small visible marker rather than disappearing.
      return math.max<double>(
        5,
        math.sqrt(math.max<int>(0, work.citedByCount ?? 0)) * .8,
      );
    }).toList();
    final largest = radii.fold<double>(0, math.max);
    if (largest > 38) {
      final scale = 38 / largest;
      radii = radii
          .map((radius) => math.max<double>(5, radius * scale))
          .toList();
    }
    final random = math.Random(42);
    points = List.generate(
      count,
      (i) => Offset(
        side * (.15 + random.nextDouble() * .7),
        bands[i].center + (random.nextDouble() * 2 - 1) * bands[i].slack,
      ),
    );
    for (var step = 0; step < 220; step++) {
      final forces = List.filled(count, Offset.zero);
      for (var i = 0; i < count; i++) {
        for (var j = i + 1; j < count; j++) {
          final delta = points[i] - points[j];
          final distance = math.max<double>(1, delta.distance);
          final direction = delta / distance;
          final separation = radii[i] + radii[j] + 56;
          final strength =
              1400 / (distance * distance) +
              math.max<double>(0, separation - distance) * .08;
          forces[i] += direction * strength;
          forces[j] -= direction * strength;
        }
      }
      for (final link in network.links) {
        final delta = points[link.target] - points[link.source];
        final distance = math.max<double>(1, delta.distance);
        final rest = radii[link.source] + radii[link.target] + 65;
        final force = delta / distance * (distance - rest) * .035;
        forces[link.source] += force;
        forces[link.target] -= force;
      }
      final cooling = 1 - step / 260;
      for (var i = 0; i < count; i++) {
        var force = forces[i] + (size.center(Offset.zero) - points[i]) * .001;
        if (force.distance > 12) force = force / force.distance * 12;
        final next = points[i] + force * cooling;
        points[i] = Offset(
          next.dx.clamp(60, side - 60),
          next.dy.clamp(
            bands[i].center - bands[i].slack,
            bands[i].center + bands[i].slack,
          ),
        );
      }
    }
  }

  late final Size size;
  late final List<Offset> points;
  late List<double> radii;

  static String label(Work work) {
    final author = work.authors.isEmpty ? 'Auteur inconnu' : work.authors.first;
    return '$author, ${work.publicationYear ?? 's. d.'}';
  }
}
