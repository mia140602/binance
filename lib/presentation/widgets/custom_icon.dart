import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String? label;
  final String iconPath;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;

  const CustomIcon({
    super.key,
    required this.iconPath,
    this.label,
    this.width,
    this.height,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Row(
        children: [
          label != null
              ? Text(
                  label ?? "",
                  style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500),
                )
              : const SizedBox(),
          Image.asset(
            iconPath,
            height: height,
            width: width,
            color: color,
          ),
        ],
      ),
    );
  }
}
