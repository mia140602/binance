import 'package:binance_clone/presentation/views/futures/chartview/chartview.dart';
import 'package:binance_clone/presentation/views/trade_details/widgets/price_top_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import 'package:binance_clone/presentation/views/chart/widgets/trade_duration_list_view.dart';

import '../../theme/palette.dart';

class ChartsView extends StatelessWidget {
  ChartsView({super.key, required this.symbol});
  String symbol;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: palette.cardColor,
      child: Column(
        children: [
          PriceTopDetails(
            symbol: symbol,
          ),
          const SizedBox(
            height: 22,
            child: TradeDurationListView(),
          ),
          Gap(10.h),
          Container(
            height: 0.5.h,
            color: palette.selectedTimeChipColor.withOpacity(0.5),
          ),
          Container(
              color: palette.cardColor,
              height: MediaQuery.of(context).size.height / 2.5,
              child: TradingChartScreen(
                symbol: symbol,
              ))
        ],
      ),
    );
  }
}
