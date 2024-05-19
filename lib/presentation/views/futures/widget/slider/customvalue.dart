import 'package:flutter/material.dart';

class CustomValueIndicatorShape extends SliderComponentShape {
  final String suffix;

  CustomValueIndicatorShape({this.suffix = ''});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(48, 48); // Điều chỉnh kích thước nếu cần
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
      ..color = sliderTheme.valueIndicatorColor ?? Colors.black
      ..style = PaintingStyle.fill;

    // Vẽ hình chữ nhật
    final Rect rect = Rect.fromCenter(center: center, width: 60, height: 30);
    context.canvas.drawRect(rect, paint);

    // Định dạng và vẽ giá trị
    final String formattedValue = '${value.toStringAsFixed(0)}$suffix';
    labelPainter.text = TextSpan(
      text: formattedValue,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      )
    );
    labelPainter.layout();
    labelPainter.paint(context.canvas, center + Offset(-labelPainter.width / 2, -labelPainter.height / 2));
  }
}