import 'package:flutter/material.dart';

import '../theme/palette.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final Function(int)? onChanged;
  final Color? selectedTabBorderColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.index,
    this.onChanged,
    this.selectedTabBorderColor,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: palette.cardColor,
        border: palette.tabBorderColor != null
            ? Border.all(color: palette.tabBorderColor!)
            : null,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isSelected = i == index;
            return GestureDetector(
              onTap: () => onChanged?.call(i),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tabs[i],
                      style: TextStyle(
                        fontSize: fontSize ?? 15,
                        fontWeight: fontWeight ?? FontWeight.w700,
                        color: isSelected
                            ? palette.appBarTitleColor
                            : palette.filterLineColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    isSelected
                        ? Container(
                            width: 12,
                            height: 3,
                            color:
                                selectedTabBorderColor ?? Colors.amber.shade400,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
