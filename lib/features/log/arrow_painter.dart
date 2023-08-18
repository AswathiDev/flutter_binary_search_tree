
import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  // final Offset start;
  // final Offset end;
  final double arrowSize;

  // ArrowPainter({required this.start, required this.end, this.arrowSize = 10.0});
 final bool isLeftArrow;

  ArrowPainter({this.isLeftArrow = true, this.arrowSize = 30.0});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final path = Path();
    // path.moveTo(start.dx, start.dy);
    // path.lineTo(end.dx, end.dy);

    // final angle = atan2(end.dy - start.dy, end.dx - start.dx);
    // final arrowX = end.dx - arrowSize * cos(angle);
    // final arrowY = end.dy - arrowSize * sin(angle);

    // path.lineTo(arrowX - arrowSize * sin(angle + pi / 6), arrowY + arrowSize * cos(angle + pi / 6));
    // path.moveTo(end.dx, end.dy);
    // path.lineTo(arrowX - arrowSize * sin(angle - pi / 6), arrowY + arrowSize * cos(angle - pi / 6));
  if (isLeftArrow) {
      // path.moveTo(size.width, 0);
      // path.lineTo(0, size.height / 2);
      // path.lineTo(size.width, size.height);

 path.moveTo(size.width, size.height / 2 - arrowSize / 2); // Adjust the starting point vertically
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height / 2 + arrowSize / 2);

    } else {

      // path.moveTo(0, 0);
      // path.lineTo(size.width, size.height / 2);
      // path.lineTo(0, size.height);

       path.moveTo(0, size.height / 2 - arrowSize / 2); // Adjust the starting point vertically
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height / 2 + arrowSize / 2); // Adjust the ending point vertically

    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
