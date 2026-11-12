import 'package:flutter/material.dart';

/// Graph content shares the search panel's background and search scope.
class CitationGraph extends StatelessWidget {
  const CitationGraph({required this.onCollapse, super.key});

  final VoidCallback onCollapse;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 280,
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
        const Expanded(
          child: SizedBox.expand(
            child: CustomPaint(painter: _CitationGraphPainter()),
          ),
        ),
      ],
    ),
  );
}

class _CitationGraphPainter extends CustomPainter {
  const _CitationGraphPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final a = Offset(size.width * .25, 62);
    final b = Offset(size.width * .65, 126);
    canvas.drawLine(a, b, Paint()..color = const Color(0xFFB8A29A));
    for (final point in [a, b]) {
      canvas
        ..drawCircle(point, 23, Paint()..color = const Color(0xFFFCFCFB))
        ..drawCircle(
          point,
          23,
          Paint()
            ..color = const Color(0xFF998B85)
            ..style = PaintingStyle.stroke
            ..strokeWidth = .8,
        );
    }
  }

  @override
  bool shouldRepaint(_CitationGraphPainter oldDelegate) => false;
}
