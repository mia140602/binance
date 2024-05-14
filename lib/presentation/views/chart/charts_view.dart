import 'package:binance_clone/presentation/views/futures/chartview/chartview.dart';
import 'package:binance_clone/presentation/views/futures/chartview/orderBook.dart';
import 'package:binance_clone/presentation/views/trade_details/widgets/price_top_details.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/presentation/widgets/tabbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import 'package:binance_clone/presentation/views/chart/widgets/trade_duration_list_view.dart';

import '../../../utils/percent.dart';
import '../../theme/palette.dart';

class ChartsView extends StatelessWidget {
  ChartsView({super.key, required this.symbol});
  String symbol;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      color: palette.cardColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PriceTopDetails(
                symbol: symbol,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const SizedBox(
                height: 22,
                child: TradeDurationListView(),
              ),
            ),
            Gap(10.h),
            Container(
              height: 0.5.h,
              color: palette.selectedTimeChipColor.withOpacity(0.5),
            ),
            Container(
                color: palette.cardColor,
                height: MediaQuery.of(context).size.height / 3,
                child: TradingChartScreen(
                  symbol: symbol,
                )),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5.h,
                          color:
                              palette.selectedTimeChipColor.withOpacity(0.5)))),
              child: Row(
                children: [
                  Expanded(
                    child: TabBarSelect(tabs: [
                      "MA",
                      "EMA",
                      "BOLL",
                      "SAR",
                      "AVL",
                      "VOL",
                      "MACD",
                      "RIS",
                      "KDJ",
                      "OBV",
                      "WR",
                      "StochRSI",
                      'L.S Acco'
                    ], index: 6),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: palette.selectedTimeChipColor,
                      ))
                ],
              ),
            ),
            Gap(10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: palette.selectedTimeChipColor.withOpacity(0.2)),
                    child: CustomText(
                      text: "Sổ lệnh",
                      fontSize: 10.sp,
                      color: palette.selectedTimeChipColor,
                    ),
                  ),
                  Gap(10.w),
                  CustomText(
                    text: "Giao dịch",
                    fontSize: 10.sp,
                    color: palette.selectedTimeChipColor,
                  ),
                ],
              ),
            ),
            Gap(10),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                height: 20.h,
                child: PercentageBar()),
            Gap(10.h),
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
              height: 500.h,
              width: MediaQuery.of(context).size.width,
              child: TradingOrderBookScreen(
                symbol: symbol,
              ),
            )
          ],
        ),
      ),
    );
  }
}
