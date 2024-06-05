import 'package:binance_clone/data/local_data/sharePref.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/trade_details/trading_view_detail.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../models/trade_data.dart';

class ItemHomeContainer extends StatelessWidget {
  final int indexMarket;
  final List<TradeData> data;
  const ItemHomeContainer(
      {super.key, required this.indexMarket, required this.data});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
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
              onTap: () async {
                await SharePref.updateLocalSymbol(tradeData.symbol);

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TradeViewDetails(
                    symbol: tradeData.symbol,
                  );
                }));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: tradeData.baseAsset,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: palette.appBarTitleColor,
                            ),
                            if (indexMarket == 1 &&
                                (index == 1 || index == 2 || index == 0))
                              Icon(
                                Icons.local_fire_department_outlined,
                                size: 16.h,
                                color: palette.mainYellowColor,
                              ),
                          ],
                        ),
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
                        color: palette.appBarTitleColor,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
