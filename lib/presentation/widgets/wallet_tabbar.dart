import 'package:flutter/material.dart';

import '../theme/palette.dart';

class WalletTabBar extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final Function(int)? onChanged;
  final Color? selectedTabBorderColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const WalletTabBar({
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

    if (tabs.isEmpty) {
      return Center(
        child: Text("Chưa có ví",
            style: TextStyle(
                fontSize: fontSize ?? 14, color: palette.filterLineColor)),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 8.0, // khoảng cách giữa các button
        children: List.generate(tabs.length, (i) {
          final isSelected = i == index;
          return ChoiceChip(
            label: Text(tabs[i]),
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                onChanged?.call(i);
              }
            },
            selectedColor: Colors.amber,
            backgroundColor: Colors.grey,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: fontWeight ?? FontWeight.w700,
              fontSize: fontSize ?? 14,
            ),
          );
        }),
      ),
    );
  }
}
