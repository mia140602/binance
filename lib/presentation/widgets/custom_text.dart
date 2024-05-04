import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final Color? color;
  final String? fontFamily;

  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.height,
      this.color,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      style: style,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
