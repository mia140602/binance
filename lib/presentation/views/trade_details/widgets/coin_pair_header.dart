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

class CoinPairHeader extends StatelessWidget {
  CoinPairHeader({super.key, this.showCurrentPrice = false});
  bool showCurrentPrice;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    double previousPrice = 0.0;
    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref.read(tradeDetailsViewModelProvider).tradeData,
          builder: (tradeData) {
            final double currentPrice =
                double.tryParse(tradeData.currentPrice) ?? 0.0;

            final formattedPrice = formatter.format(currentPrice);

            Color textColor = Colors.black;
            if (currentPrice > previousPrice) {
              textColor = Colors.green;
            } else if (currentPrice < previousPrice) {
              textColor = Colors.red;
            }

            previousPrice = currentPrice;
            return Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 16,
                right: 16,
                bottom: 0,
              ),
              color: palette.cardColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            const Gap(8),
                            DropdownButton(
                              dropdownColor: palette.cardColor,
                              underline: const SizedBox(),
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: CustomText(
                                      text: tradeData.symbol,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (_) {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              size: 22,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                            ),
                            Gap(12),
                            Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.black,
                            ),
                            Gap(12),
                            Icon(
                              Icons.window_sharp,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
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

class _CoinPairIcons extends StatelessWidget {
  const _CoinPairIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 44,
      child: Stack(
        children: [
          CustomIcon(
            iconPath: AppAssets.btc,
            width: 24,
            height: 24,
          ),
          Positioned(
            right: 1,
            child: CustomIcon(
              iconPath: AppAssets.usdt,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(4),
        VerticalDivider(
          width: 42,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const Gap(4),
      ],
    );
  }
}

class _ItemColumn extends StatelessWidget {
  final String icon;
  final String label;
  final String description;
  final Color? color;

  const _ItemColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIcon(
              iconPath: icon,
              width: 16,
              height: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const Gap(4),
            CustomText(
              text: label,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        const Gap(6),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: CustomText(
            text: description,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
