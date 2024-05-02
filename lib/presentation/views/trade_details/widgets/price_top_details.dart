import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../theme/palette.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/reactive_builder.dart';
import '../trade_details_view_model.dart';

class PriceTopDetails extends StatelessWidget {
  const PriceTopDetails({Key? key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");

    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref.read(tradeDetailsViewModelProvider).tradeData,
          builder: (tradeData) {
            // Chuyển đổi giá thành số
            final double currentPrice =
                double.tryParse(tradeData.currentPrice) ?? 0.0;
            // Định dạng giá theo mẫu "#,##0.00"
            final formattedPrice = formatter.format(currentPrice);

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
                              text: formattedPrice,
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
                ],
              ),
            );
          });
    });
  }
}
