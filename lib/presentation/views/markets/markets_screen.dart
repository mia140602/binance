import 'package:binance_clone/presentation/views/markets/widgets/market_activity_header.dart';
import 'package:binance_clone/presentation/views/trade_details/trading_view_detail.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../models/trade_data.dart';
import '../../theme/palette.dart';

import 'market_view_model.dart';

class MarketView extends ConsumerWidget {
  const MarketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _tabIndex = 0;

    // void _setTabIndex(int value) {
    //   if (_tabIndex != value) {
    //     setState(() {
    //       _tabIndex = value;
    //     });
    //   }
    // }

    final marketData = ref.watch(marketViewModelProvider).marketData;
    final palette = Theme.of(context).extension<Palette>()!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: palette.cardColor,
        elevation: 0,
        titleSpacing: 0,
        title: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
              margin: EdgeInsets.only(left: 30, right: 10),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: palette.cardColor),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search_sharp),
                    hintText: "Tìm kiếm Coin/Cặp giao dịch/Phái sinh"),
              )),
        ),
        actions: [Icon(Icons.more_horiz)],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: MarketActivityHeader(
            index: _tabIndex,
            //  onTabChanged: _setTabIndex
          ),
        ),
      ),
      backgroundColor: palette.cardColor,
      body: ValueListenableBuilder<List<TradeData>>(
        valueListenable: marketData,
        builder: (context, data, child) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final tradeData = data[index];
              String addminus = '';
              Color buttonK = palette.mainGreenColor;
              if (tradeData.isPriceChangeIn24HNeg == true) {
                buttonK = Colors.red;
              } else {
                addminus = '+';
              }

              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TradeViewDetails(
                    symbol: tradeData.symbol,
                  );
                })),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: '${tradeData.symbol}',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          Gap(5),
                          CustomText(
                            text: '2.42B',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: '${tradeData.currentPrice}',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          Gap(5),
                          CustomText(
                            text: '\$${tradeData.currentPrice}',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      Container(
                        width: 90,
                        height: 36,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: buttonK,
                            borderRadius: BorderRadius.circular(8)),
                        child: CustomText(
                          text:
                              '$addminus${tradeData.percentageChangeIn24H.toStringAsFixed(2)}%',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: palette.cardColor,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
