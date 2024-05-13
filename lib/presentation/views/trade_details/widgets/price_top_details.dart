import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../theme/palette.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/reactive_builder.dart';
import '../trade_details_view_model.dart';

class PriceTopDetails extends StatelessWidget {
  const PriceTopDetails({
    super.key,
    required this.symbol,
  });

  final String symbol;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    double previousPrice = 0.0; // Khởi tạo giá trị ban đầu cho previousPrice

    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref.read(tradeDetailsViewModelProvider(symbol)).tradeData,
          builder: (tradeData) {
            // final List<String> symbols = tradeData.symbol.split('/');
            String assetSymbol = tradeData.baseAsset;
            String quoteSymbol = tradeData.quoteAsset;
            final double currentPrice =
                double.tryParse(tradeData.currentPrice) ?? 0.0;
            final double highPrice =
                double.tryParse(tradeData.highPrice) ?? 0.0;
            final double lowPrice = double.tryParse(tradeData.lowPrice) ?? 0.0;
            final formattedPrice = formatter.format(currentPrice);
            final highPriceFomat = formatter.format(highPrice);
            final lowPriceFomat = formatter.format(lowPrice);

            Color textColor = palette.appBarTitleColor;
            if (currentPrice > previousPrice) {
              textColor = palette.mainGreenColor;
            } else if (currentPrice < previousPrice) {
              textColor = palette.sellButtonColor;
            }
            previousPrice = currentPrice;

            return Container(
              padding: const EdgeInsets.only(
                top: 0,
                left: 0,
                right: 0,
                bottom: 5,
              ),
              color: palette.cardColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: formattedPrice,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              CustomText(
                                text: '\$${tradeData.currentPrice}',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: palette.appBarTitleColor,
                              ),
                              CustomText(
                                text: tradeData.percentageChangeIn24H > 0
                                    ? '+${tradeData.percentageChangeIn24H.toStringAsFixed(2)}%'
                                    : '${tradeData.percentageChangeIn24H.toStringAsFixed(2)}%',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: tradeData.isPriceChangeIn24HNeg
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ],
                          ),
                          Gap(5.h),
                          Container(
                            width: 60.w,
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.amber.shade100.withOpacity(0.2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "POW",
                                  fontSize: 10,
                                  color: Colors.amber.shade500,
                                ),
                                Container(
                                  height: 5,
                                  width: 1,
                                  color: Colors.amber.shade500,
                                ),
                                CustomText(
                                  text: "KL",
                                  fontSize: 10,
                                  color: Colors.amber.shade500,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.amber.shade500,
                                  size: 8,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Giá cao nhất 24h",
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: highPriceFomat,
                                fontSize: 10,
                              ),
                              Gap(5.h),
                              const CustomText(
                                text: "Giá thấp nhất 24h",
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: lowPriceFomat,
                                fontSize: 10,
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "KL 24h($assetSymbol)",
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: tradeData.baseAssetVolume,
                                fontSize: 10,
                              ),
                              Gap(5.h),
                              CustomText(
                                text: "KL 24h($quoteSymbol)",
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: tradeData.quoteAssetVolume,
                                fontSize: 10,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }
}
