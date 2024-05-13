import 'package:binance_clone/presentation/views/futures/chartview/chartview.dart';
import 'package:binance_clone/presentation/views/futures/chartview/order_book.dart';
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
  const ChartsView({
    super.key,
    required this.symbol,
  });

  final String symbol;

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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
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
                  const Expanded(
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
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5.h,
                          color:
                              palette.selectedTimeChipColor.withOpacity(0.5)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _dateNumber(
                    palette: palette,
                    text: "Hôm nay",
                    number: "-2,11%",
                  ),
                  _dateNumber(
                    palette: palette,
                    text: "7 ngày",
                    number: "-2.15%",
                  ),
                  _dateNumber(
                    palette: palette,
                    text: "30 ngày",
                    number: "-8.23%",
                  ),
                  _dateNumber(
                      palette: palette,
                      text: "90 ngày",
                      number: "27.59%",
                      numK: palette.mainGreenColor),
                  _dateNumber(
                      palette: palette,
                      text: "180 ngày",
                      number: "69.86%",
                      numK: palette.mainGreenColor),
                  _dateNumber(
                      palette: palette,
                      text: "1 năm",
                      number: "129.34%",
                      numK: palette.mainGreenColor),
                ],
              ),
            ),
            Gap(10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: palette.selectedTimeChipColor.withOpacity(0.2)),
                    child: CustomText(
                      text: "Sổ lệnh",
                      fontSize: 10.sp,
                      color: palette.appBarTitleColor,
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
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              height: 20.h,
              child: const PercentageBar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    child: CustomText(
                      text: "Mua vào",
                      color: palette.selectedTimeChipColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Bán ra",
                          color: palette.selectedTimeChipColor,
                          fontSize: 10.sp,
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:
                                palette.selectedTimeChipColor.withOpacity(0.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "0.1",
                                color: palette.selectedTimeChipColor,
                                fontSize: 10.sp,
                              ),
                              Gap(2.w),
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                color: palette.selectedTimeChipColor,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Gap(5.h),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
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

  Widget _dateNumber(
      {required Palette palette,
      required String text,
      required String number,
      Color? numK}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: text,
            color: palette.selectedTimeChipColor,
            fontSize: 10.sp,
          ),
          CustomText(
            text: number,
            color: numK ?? palette.sellButtonColor,
            fontSize: 10.sp,
          ),
        ],
      ),
    );
  }
}
