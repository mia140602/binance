import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view_model.dart';
import 'package:binance_clone/presentation/widgets/custom_icon.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/presentation/widgets/reactive_builder.dart';
import 'package:intl/intl.dart';

class PriceTopDetails extends StatelessWidget {
  const PriceTopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref.read(tradeDetailsViewModelProvider).tradeData,
          builder: (tradeData) {
            final formattedPrice = formatter.format(tradeData.currentPrice);
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
                right: 16,
                bottom: 5,
              ),
              color: palette.cardColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            CustomText(
                              text: "${tradeData.currentPrice}",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: palette.candleStickGainColor,
                            ),
                            const Gap(8),
                            const Gap(24),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const Gap(20),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 50,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       _ItemColumn(
                  //         icon: AppAssets.clock,
                  //         label: "24h change",
                  //         description:
                  //             "${tradeData.percentageChangeIn24H.toStringAsFixed(2)}%",
                  //         color: tradeData.isPriceChangeIn24HNeg
                  //             ? palette.candleStickLossColor
                  //             : palette.candleStickGainColor,
                  //       ),
                  //       const _Divider(),
                  //       _ItemColumn(
                  //         icon: AppAssets.arrowUp,
                  //         label: "24h high",
                  //         description: tradeData.highPrice,
                  //         color: Theme.of(context).colorScheme.primary,
                  //       ),
                  //       const _Divider(),
                  //       _ItemColumn(
                  //         icon: AppAssets.arrowDown,
                  //         label: "24h low",
                  //         description: tradeData.lowPrice,
                  //         color: Theme.of(context).colorScheme.primary,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          });
    });
  }
}
