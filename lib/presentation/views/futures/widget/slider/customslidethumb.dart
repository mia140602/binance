import 'package:flutter/material.dart';

class CustomSliderThumbDiamond extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(20, 20); // Kích thước của thumb
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.transparent
      ..style = PaintingStyle.fill;

    final Paint outlinePaint = Paint()
      ..color = sliderTheme.valueIndicatorColor ?? Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Path path = Path()
      ..moveTo(center.dx, center.dy - 6)
      ..lineTo(center.dx + 6, center.dy)
      ..lineTo(center.dx, center.dy + 6)
      ..lineTo(center.dx - 6, center.dy)
      ..close();

    context.canvas.drawPath(path, paint);
    context.canvas.drawPath(path, outlinePaint);
  }
}

class CustomSliderTickMarkDiamond extends SliderTickMarkShape {
  @override
  Size getPreferredSize(
      {required SliderThemeData sliderTheme, bool isEnabled = false}) {
    return Size(12, 12); // Kích thước của tick marks
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      required bool isEnabled,
      required TextDirection textDirection}) {
    final bool isActive = thumbCenter.dx >= center.dx;
    final Paint paint = Paint()
      ..color = isActive ? Color(0xffFFFFFF) : Color(0xFF1F2630)
      ..style = PaintingStyle.fill;

    final Paint outlinePaint = Paint()
      ..color = isActive ? Color(0xffFFFFFF) : Color(0xff848e9f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Path path = Path()
      ..moveTo(center.dx, center.dy - 4)
      ..lineTo(center.dx + 4, center.dy)
      ..lineTo(center.dx, center.dy + 4)
      ..lineTo(center.dx - 4, center.dy)
      ..close();

    context.canvas.drawPath(path, outlinePaint);
    context.canvas.drawPath(path, paint);
  }
}
