import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_icon.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';

import '../../../../utils/parser_util.dart';

class Pricebar extends StatelessWidget {
  final double newPrice;
  final double oldPrice;

  const Pricebar({
    super.key,
    required this.newPrice,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    Color color = newPrice > oldPrice
        ? palette.buyButtonColor
        : newPrice < oldPrice
            ? palette.sellPriceColor
            : Theme.of(context).colorScheme.primary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: ParserUtil.formatPrice(newPrice.toString()),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        CustomText(
          // text: oldPrice.toString(),
          text: ParserUtil.formatPrice(oldPrice.toString()),
          fontSize: 12,
          // fontWeight: FontWeight.w500,
          color: palette.selectedTimeChipColor,
        ),
      ],
    );
  }
}
