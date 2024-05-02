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
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: palette.cardColor,
        border: palette.tabBorderColor != null
            ? Border.all(color: palette.tabBorderColor!)
            : null,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 0.2, // Độ cao của đường phân chia mỏng
              color: Colors.grey.withOpacity(0.5), // Màu của đường phân chia
            ),
          ),
          Row(
            children: List.generate(tabs.length, (i) {
              final isSelected = i == index;
              return GestureDetector(
                onTap: () => onChanged?.call(i),
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border(
                              bottom: BorderSide(
                                color: Colors.amber
                                    .shade300, // Màu gạch chân khi tab được chọn
                                width: 2.0, // Độ dày của gạch chân
                              ),
                            )
                          : null,
                    ),
                    child: Text(
                      tabs[i],
                      style: TextStyle(
                        fontSize: fontSize ?? 13,
                        fontWeight: fontWeight ?? FontWeight.w500,
                        color: isSelected
                            ? palette.selectedTabTextColor
                            : palette.unselectedTabTextColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
