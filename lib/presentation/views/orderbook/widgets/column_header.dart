import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:gap/gap.dart';

import '../../../theme/palette.dart';

class ColumnHeader extends StatelessWidget {
  const ColumnHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _ColumnItem(
            title: "Giá",
            subtitle: "USDT",
          ),
        ),
        // Spacer(),
        Gap(30),
        Expanded(
          child: _ColumnItem(
            title: "Số lượng",
            subtitle: "USDT",
          ),
        ),
        // Spacer(),
        // Expanded(
        //   child: _ColumnItem(
        //     title: "Tổng",
        //   ),
        // ),
      ],
    );
  }
}

class _ColumnItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ColumnItem({
    required this.title,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 10,
          // fontWeight: FontWeight.w500,
          color: palette.selectedTimeChipColor,
        ),
        CustomText(
          text: subtitle.isNotEmpty ? "($subtitle)" : " ",
          fontSize: 9,
          // fontWeight: FontWeight.w600,
          color: palette.selectedTimeChipColor,
        ),
        const Gap(10),
      ],
    );
  }
}
