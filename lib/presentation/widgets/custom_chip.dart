import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Function(String)? onPressed;
  final bool selected;
  final bool disableWidth;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double? width;

  const CustomChip({
    super.key,
    required this.label,
    this.selected = false,
    this.disableWidth = false,
    this.fontWeight = FontWeight.w500,
    this.padding = EdgeInsets.zero,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onPressed?.call(label);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: padding,
        width: width ?? (disableWidth ? null : 40),
        height: 28,
        child: Center(
          child: CustomText(
            text: label.toLowerCase(),
            fontSize: 12,
            fontWeight: fontWeight,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
