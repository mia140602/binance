import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../theme/palette.dart';

import '../../trade_details/trade_details_view_model.dart';

final indexProvider = StateProvider<int>((ref) => 0);

class OverviewScreen extends ConsumerStatefulWidget {
  const OverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends ConsumerState<OverviewScreen> {
  int _index = 0;
  int check = 0;
  String symbol = "USDT";

  void _setIndex(int newIndex) {
    setState(() {
      _index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    // Lấy instance của TradeDetailsViewModel từ Provider
    final tradeDetailsViewModel =
        ref.watch(tradeDetailsViewModelProvider('btcusdt'));
    // Sau đó truy cập totalBalanceNotifier từ instance đó
    final numberFormat = NumberFormat("#,##0.00000", "en_US");
    final totalBalance = tradeDetailsViewModel.totalBalanceNotifier;
    Widget selectedWidget = Container();
    if (check == 0) {
      selectedWidget = Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppStrings.spot,
                    style: AppStyle.regularBoldText(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("0 USDT", style: AppStyle.boldText()),
                  Text("≈ \$0", style: AppStyle.smallGrayText()),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'USD',
                    style: AppStyle.regularBoldText(),
                  ),
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 14.h,
                    color: Colors.grey[500],
                  ),
                  Text(
                    "-M Futures",
                    style: AppStyle.regularBoldText(),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ValueListenableBuilder<double>(
                    valueListenable: totalBalance,
                    builder: (context, value, child) {
                      return CustomText(
                        // text: '${value.toStringAsFixed(2)}',
                        text:
                            '${numberFormat.format(value).replaceAll('.', '')} USDT',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      );
                    },
                  ),
                  ValueListenableBuilder<double>(
                    valueListenable: totalBalance,
                    builder: (context, value, child) {
                      return CustomText(
                        // text: '${value.toStringAsFixed(2)}',
                        text:
                            '≈ \$ ${numberFormat.format(value).replaceAll('.', '')}',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF757b87),
                        fontSize: 12.sp,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          _rowItem(title: "Funding", symbol: symbol),
          SizedBox(
            height: 27.h,
          ),
          _rowItem(title: "Earn", symbol: symbol),
          SizedBox(
            height: 27.h,
          ),
          _rowItem(title: "Hợp đồng tương lai COI...", symbol: symbol),
          SizedBox(
            height: 27.h,
          ),
          _rowItem(title: "Cross Margin", symbol: symbol),
          SizedBox(
            height: 27.h,
          ),
          _rowItem(title: "Isolate Margin", symbol: symbol),
          SizedBox(
            height: 27.h,
          ),
          _rowItem(title: "Sao chép giao dịch", symbol: symbol),
          Container(
            height: 100,
            width: 100,
          )
        ],
      );
    } else {
      selectedWidget =
          Center(child: CustomText(text: "Chức năng chưa triển khai"));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      color: palette.cardColor,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: palette.grayColor,
                      size: 13.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomText(
                      text: AppStrings.total_balance,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: palette.selectedTabChipColor,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: Row(
                        children: [
                          CustomText(
                            text: symbol,
                            fontSize: 10.sp,
                            color: palette.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                          Gap(2.w),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 10.h,
                            color: palette.grayColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/alas.png",
                        width: 14.w,
                      ),
                      Gap(20.w),
                      Image.asset(
                        "assets/icons/time.png",
                        width: 14.w,
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: totalBalance,
                  builder: (context, value, child) {
                    return CustomText(
                      // text: '${value.toStringAsFixed(2)}',
                      text: numberFormat.format(value).replaceAll('.', ''),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: totalBalance,
                  builder: (context, value, child) {
                    return CustomText(
                        // text: '${value.toStringAsFixed(2)}',
                        text:
                            '≈ ${numberFormat.format(value).replaceAll('.', '')} \$',
                        fontSize: 13.sp,
                        color: Colors.grey.shade500);
                  },
                ),
              ],
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(
            //       "PNL today",
            //       style: AppStyle.regularText().copyWith(decoration: TextDecoration.underline,decorationColor: Colors.grey),
            //     ),
            //     SizedBox(width: 2.w,),
            //     Text("+0,000241 \$", style: AppStyle.smallGreenText(),),
            //     Text("+0.02%",style: AppStyle.smallGreenText(),),
            //     Icon(Icons.arrow_right_outlined,size: 17.h,color: Colors.grey,)
            //   ],
            // ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: palette.mainYellowColor,
                    ),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Mua",
                          style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ))),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: palette.grayButton,
                    ),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Bán",
                          style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: palette.textColor),
                        ))),
              ],
            ),
            Divider(
              color: palette.selectedTimeChipColor,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                CustomTabBar(
                  tabs: const ["Tài khoản", "Tiền mã hóa"],
                  index: _index,
                  onChanged: (value) {
                    setState(() {
                      check = value; // Update the index value when tab changes
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 15.h,
            ),
            selectedWidget
          ],
        ),
      ),
    );
  }

  Row _rowItem({required String title, String? symbol}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ],
        ),
        Column(
          children: [
            Text("0.00 ${symbol}", style: AppStyle.boldText()),
          ],
        )
      ],
    );
  }
}
