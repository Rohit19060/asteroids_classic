import 'dart:math';

import 'package:flutter/material.dart';

class RandomPolygonWidget extends StatelessWidget {
  const RandomPolygonWidget({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: const Size(100, 100),
        painter: RandomPolygonPainter(sides: 4),
      );
}

class RandomPolygonPainter extends CustomPainter {
  RandomPolygonPainter({required this.sides});
  final int sides;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();
    final random = Random();

    // Generate random vertices
    final vertices = List.generate(sides, (_) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      return Offset(dx, dy);
    });

    if (vertices.isNotEmpty) {
      path.moveTo(vertices[0].dx, vertices[0].dy);
      for (final vertex in vertices.skip(1)) {
        path.lineTo(vertex.dx, vertex.dy);
      }
      path.close(); // Close the path to form a polygon
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
