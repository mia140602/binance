import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderlineText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color underlineColor;
  final double underlineThickness;
  final double underlineSpacing;

  UnderlineText({
    required this.text,
    required this.style,
    required this.underlineColor,
    required this.underlineThickness,
    required this.underlineSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: style,
        ),
        SizedBox(height: underlineSpacing),
        Container(
          height: underlineThickness,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: underlineColor,
                width: underlineThickness,
                style: BorderStyle.solid, // For solid line
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class DottedUnderlineText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color underlineColor;
  final double underlineThickness;
  final double underlineSpacing;

  DottedUnderlineText({
    required this.text,
    required this.style,
    required this.underlineColor,
    required this.underlineThickness,
    required this.underlineSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedUnderlinePainter(
        text: text,
        textStyle: style,
        underlineColor: underlineColor,
        underlineThickness: underlineThickness,
        underlineSpacing: underlineSpacing,
      ),
    );
  }
}

class DottedUnderlinePainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color underlineColor;
  final double underlineThickness;
  final double underlineSpacing;

  DottedUnderlinePainter({
    required this.text,
    required this.textStyle,
    required this.underlineColor,
    required this.underlineThickness,
    required this.underlineSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(canvas, Offset(0, 0));

    final Paint paint = Paint()
      ..color = underlineColor
      ..strokeWidth = underlineThickness
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    double xStart = 0;
    double xEnd = textPainter.width;

    for (double x = xStart; x < xEnd; x += underlineThickness * 2) {
      path.moveTo(x, textPainter.height + underlineSpacing);
      path.lineTo(x + underlineThickness, textPainter.height + underlineSpacing);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return false;
  }
}
