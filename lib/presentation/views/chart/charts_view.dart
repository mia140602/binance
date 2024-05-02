import 'package:binance_clone/presentation/views/trade_details/widgets/price_top_details.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/models/kline_candle.dart';
import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/views/chart/charts_view_model.dart';
import 'package:binance_clone/presentation/views/chart/full_charts_view.dart';
import 'package:binance_clone/presentation/views/chart/widgets/trade_duration_list_view.dart';
import 'package:binance_clone/presentation/widgets/custom_icon.dart';
import 'package:binance_clone/presentation/widgets/reactive_builder.dart';
import 'package:binance_clone/utils/app_strings.dart';

class ChartsView extends StatelessWidget {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(24),
          PriceTopDetails(),
          const SizedBox(
            height: 22,
            child: TradeDurationListView(),
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomIcon(
              iconPath: AppAssets.expand,
              height: 17,
              width: 17,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FullChartsView(),
                  ),
                );
              },
            ),
          ),
          const Gap(16),
          Consumer(builder: (context, ref, _) {
            return ReactiveBuilder<List<KlineCandle>>(
                value: ref.read(chartsViewModelProvider).candles,
                builder: (candles) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: 390,
                        width: MediaQuery.of(context).size.width,
                        child: candles.length < 14
                            ? const SizedBox()
                            : Candlesticks(
                                symbol: AppStrings.symbol,
                                candles: List<Candle>.from(
                                  candles.map(
                                    (e) => Candle(
                                      date: e.date,
                                      high: e.high,
                                      low: e.low,
                                      open: e.open,
                                      close: e.close,
                                      baseAssetVolume: e.baseAssetVolume,
                                      quoteAssetVolume: e.quoteAssetVolume,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Positioned(
                        top: 160,
                        left: width * .44,
                        right: width * .44,
                        child: candles.length < 14
                            ? const SizedBox.square(
                                dimension: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  );
                });
          }),
        ],
      ),
    );
  }
}
