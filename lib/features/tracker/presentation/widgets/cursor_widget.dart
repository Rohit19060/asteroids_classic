import 'package:flutter/material.dart';

class CursorWidget extends StatelessWidget {
  const CursorWidget({
    super.key,
    required this.size,
   required this.rotation,
  });
  final Size size;
  final double rotation;

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: size,
        painter: CursorPainter(rotation: rotation),
      );
}

class CursorPainter extends CustomPainter {
  CursorPainter({required this.rotation});
  final double rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke // Draw only the outline
      ..strokeWidth = 1.0;

    final path = Path();

    path.moveTo(size.width / 2, 0); // Top point
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(size.width / 2, size.height * 0.65); // Middle bottom
    path.lineTo(0, size.height); // Bottom left
    path.close(); // Complete the shape

    // Rotate and move the path based on the direction
      // Rotate and move the path based on the rotation value
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2); // Move to center
    canvas.rotate(rotation); // Apply rotation
    canvas.translate(-size.width / 2, -size.height / 2); // Move back

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
