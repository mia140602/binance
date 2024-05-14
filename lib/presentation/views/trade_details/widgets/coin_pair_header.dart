import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view_model.dart';
import 'package:binance_clone/presentation/widgets/custom_icon.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/presentation/widgets/reactive_builder.dart';

class CoinPairHeader extends StatelessWidget {
  CoinPairHeader(
      {super.key, this.showCurrentPrice = false, required this.symbol});
  bool showCurrentPrice;
  String symbol;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref.read(tradeDetailsViewModelProvider(symbol)).tradeData,
          builder: (tradeData) {
            return Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 0,
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
                            CustomText(
                              text: symbol,
                              color: palette.appBarTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: palette.selectedTabChipColor,
                                  borderRadius: BorderRadius.circular(4.r)),
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: CustomText(
                                text: "Hợp đồng tương lai vĩnh cửu",
                                fontSize: 8,
                                color: palette.appBarTitleColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18.h,
                              color: palette.appBarTitleColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.star_rate_rounded,
                                size: 22, color: palette.appBarTitleColor),
                            Gap(12),
                            Icon(
                              Icons.share,
                              size: 20,
                              color: palette.appBarTitleColor,
                            ),
                            Gap(12),
                            Icon(
                              Icons.window_sharp,
                              size: 20,
                              color: palette.appBarTitleColor,
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
