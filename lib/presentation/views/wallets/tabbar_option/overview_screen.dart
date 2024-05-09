import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          color: palette.cardColor,
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
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 5.w,
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
                  Row(
                    children: [
                      Icon(
                        Icons.question_mark,
                        size: 14.h,
                      )
                    ],
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
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2.w, bottom: 6.h),
                    decoration: BoxDecoration(
                        color: palette.cardColor,
                        borderRadius: BorderRadius.circular(3.r)),
                    child: Row(
                      children: [
                        CustomText(
                          text: "USDT",
                          color: palette.textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 14.h,
                          color: palette.grayColor,
                        )
                      ],
                    ),
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
                        borderRadius: BorderRadius.circular(10.r),
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
                        borderRadius: BorderRadius.circular(10.r),
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
                      tabs: const ["Tài khoản", "Ví điện tử"], index: _index),
                ],
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Account",
              //       style: AppStyle.bigText(),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 15.h,
              ),

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
                      Text("44,93428732 BTC", style: AppStyle.boldText()),
                      Text("≈ 44,93428732 BTC",
                          style: AppStyle.smallGrayText()),
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
                                '${numberFormat.format(value).replaceAll('.', '')} \$',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF757b87),
                            fontSize: 14,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Funding',
                        style: AppStyle.regularBoldText(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0.00 BTC", style: AppStyle.boldText()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Earn',
                        style: AppStyle.regularBoldText(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0.00 BTC", style: AppStyle.boldText()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'COIN-M Futures',
                        style: AppStyle.regularBoldText(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0.00 BTC", style: AppStyle.boldText()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Cross Margin',
                        style: AppStyle.regularBoldText(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0.00 BTC", style: AppStyle.boldText()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Isolated Margin',
                        style: AppStyle.regularBoldText(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0.00 BTC", style: AppStyle.boldText()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Copy Trading',
                        style: AppStyle.regularBoldText(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0.00 BTC", style: AppStyle.boldText()),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
