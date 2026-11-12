import 'package:flutter/material.dart';

class CitationGraph extends StatelessWidget {
  const CitationGraph({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
    child: Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Connexions', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFCFB),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.search_rounded, size: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.filter_list_rounded, size: 18),
              SizedBox(width: 8),
              Icon(Icons.sort_by_alpha_rounded, size: 18),
            ],
          ),
          const Expanded(
            child: SizedBox.expand(
              child: CustomPaint(painter: _CitationGraphPainter()),
            ),
          ),
        ],
      ),
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
