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
    final pnlNotifier = tradeDetailsViewModel.pnlNotifier;
    final roiNotifier = tradeDetailsViewModel.roiNotifier;
    final Color pnlColor = pnlNotifier.value > 0
        ? palette.mainGreenColor
        : palette.sellButtonColor;
    Widget selectedWidget = Container();
    if (check == 0) {
      selectedWidget = Column(
        children: [
          _rowItem(title: "Giao ngay", symbol: symbol),
          SizedBox(
            height: 15.h,
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
            height: 15.h,
          ),
          Container(
            height: 1,
            color: palette.selectedTabChipColor,
          ),
          _rowItem(title: "Funding", symbol: symbol),
          _rowItem(title: "Earn", symbol: symbol),
          _rowItem(title: "Hợp đồng tương lai COI...", symbol: symbol),
          _rowItem(title: "Cross Margin", symbol: symbol),
          _rowItem(title: "Isolate Margin", symbol: symbol),
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
                    CustomText(
                      text: AppStrings.total_balance,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: palette.grayColor,
                      size: 13.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
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
                      text: numberFormat.format(value).replaceAll('.', '') +
                          ' \$',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    );
                  },
                ),
                Gap(15.w),
                Row(
                  children: [
                    CustomText(
                      text: symbol,
                      fontSize: 14.sp,
                      color: palette.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                    Gap(2.w),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 14.h,
                      color: palette.appBarTitleColor,
                    )
                  ],
                )
              ],
            ),
            // Row(
            //   children: [
            //     ValueListenableBuilder<double>(
            //       valueListenable: totalBalance,
            //       builder: (context, value, child) {
            //         return CustomText(
            //             // text: '${value.toStringAsFixed(2)}',
            //             text:
            //                 '≈ ${numberFormat.format(value).replaceAll('.', '')} \$',
            //             fontSize: 13.sp,
            //             color: Colors.grey.shade500);
            //       },
            //     ),
            //   ],
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("PNL của hôm nay",
                    style: AppStyle.regularText().copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        decorationColor: Colors.grey)),
                SizedBox(width: 2.w),
                ValueListenableBuilder<double>(
                  valueListenable: pnlNotifier,
                  builder: (context, value, child) {
                    return CustomText(
                      text: value > 0
                          ? "+${value.toStringAsFixed(2)} \$"
                          : "${value.toStringAsFixed(2)} \$",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: pnlColor,
                    );
                  },
                ),
                ValueListenableBuilder<double>(
                  valueListenable: roiNotifier,
                  builder: (context, value, child) {
                    return CustomText(
                        text: value > 0
                            ? "(+${value.toStringAsFixed(2)}%)"
                            : "(${value.toStringAsFixed(2)}%)",
                        color: value > 0
                            ? palette.mainGreenColor
                            : palette.sellButtonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp);
                  },
                ),
                Gap(10.w),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 13.h,
                  color: palette.selectedTimeChipColor,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  decoration: BoxDecoration(
                      color: palette.mainYellowColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: CustomText(
                    text: "Nạp",
                    color: palette.cardColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Gap(10.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  decoration: BoxDecoration(
                      color: palette.bgColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: CustomText(
                    text: "Mua",
                    color: palette.appBarTitleColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                // iconbutton(
                //     palette: palette,
                //     context: context,
                //     image: "download",
                //     text: "Nạp"),
                // iconbutton(
                //     palette: palette,
                //     context: context,
                //     image: "upload",
                //     text: "Rút"),
                // iconbutton(
                //     palette: palette,
                //     context: context,
                //     image: "sunrise",
                //     text: "Mua"),
                // iconbutton(
                //     palette: palette,
                //     context: context,
                //     image: "change",
                //     width: 16.w,
                //     text: "Chuyển"),
              ],
            ),
            Divider(
              color: palette.selectedTabChipColor,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                CustomTabBar(
                  tabs: const ["Tài khoản", "Tiền mã hóa"],
                  fontSize: 13.sp,
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

  Widget iconbutton(
      {required Palette palette,
      required BuildContext context,
      required String image,
      required String text,
      double? width}) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: palette.cardColor,
              border:
                  Border.all(color: palette.selectedTimeChipColor, width: 0.5),
            ),
            // height: MediaQuery.of(context).size.height * 0.05,
            // width: MediaQuery.of(context).size.width * 0.45,
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "assets/icons/${image}.png",
              width: width ?? 18.w,
            )),
        Gap(5.h),
        CustomText(
          text: text,
          color: palette.selectedTimeChipColor,
        )
      ],
    );
  }

  Widget _rowItem({required String title, String? symbol}) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      decoration: BoxDecoration(
          // border: Border(
          //   bottom: BorderSide(
          //     color: palette.selectedTabChipColor,
          //     width: 0.5,
          //   ),
          // ),
          ),
      padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
      child: Row(
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
      ),
    );
  }
}
