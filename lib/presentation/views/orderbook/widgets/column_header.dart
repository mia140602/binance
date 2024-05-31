import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../theme/palette.dart';

class ColumnHeader extends StatelessWidget {
  const ColumnHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: _ColumnItem(
            title: "Giá",
            subtitle: "USDC",
          ),
        ),
        // Spacer(),
        Gap(20.w),
        const Expanded(
          child: _ColumnItem(
            title: "Số lượng",
            subtitle: "BTC",
            aliT: true,
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
  final bool? aliT;

  const _ColumnItem({
    super.key,
    required this.title,
    this.subtitle = "",  this.aliT,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: (aliT == true) ? Alignment.centerRight : Alignment.centerLeft,
          child: CustomText(
            text: title,
            fontSize: 10,
            // fontWeight: FontWeight.w500,
            color: palette.selectedTimeChipColor,
          ),
        ),
        Align(
          alignment: (aliT == true) ? Alignment.centerRight : Alignment.centerLeft,
          child: CustomText(
            text: subtitle.isNotEmpty ? "($subtitle)" : " ",
            fontSize: 9,
            // fontWeight: FontWeight.w600,
            color: palette.selectedTimeChipColor,
          ),
        ),
        const Gap(10)
      ],
    );
  }
}
