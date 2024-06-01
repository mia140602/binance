import 'dart:ui';

import 'package:flutter/material.dart';

class DottedUnderlinedText extends StatelessWidget {
  final Text text;
  final Color underlineColor;
  final double thickness;
  final double gapSize;
  final double paddingBottom;

  DottedUnderlinedText({
    required this.text,
    required this.underlineColor,
    required this.thickness,
    required this.gapSize,
    required this.paddingBottom,
    // this.underlineColor = Colors.black,
    // this.thickness = 3.0,
    // this.gapSize = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Space for the underline
      child: CustomPaint(

        painter: DottedLinePainter(underlineColor, thickness, gapSize),
        child: Padding(
          padding:  EdgeInsets.only(top: paddingBottom),
          child: text,
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double gapSize;

  DottedLinePainter(this.color, this.thickness, this.gapSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    double startY = size.height - thickness / 2;
    double endX = size.width;

    for (double startX = 0; startX < endX; startX += gapSize * 2) {
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX + gapSize, startY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
