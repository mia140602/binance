
import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/palette.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int _index = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(
  //       length: 4,
  //       vsync:
  //           this); // Số lượng tabs phải khớp với số lượng trong CustomTabBar
  //   // _tabController.addListener(_handleTabSelection);
  // }

  void _setIndex(int newIndex) {
    setState(() {
      _index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Container(
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
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
              CustomText(
                text: "0.00",
                color: palette.appBarTitleColor,
                fontWeight: FontWeight.w600,
                fontSize: 32.sp,
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
                      text: "BTC",
                      color: palette.textColor,
                      fontSize: 15.sp,
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
              Text(
                "≈ 695,7274922",
                style: GoogleFonts.roboto(
                    fontSize: 13.sp, color: Colors.grey.shade500),
              )
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
                      child: Text("Bán",
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Image.asset(WalletAssets.fdusd, height: 16.h,),
          //         SizedBox(width: 10.w,),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text("FDUSE", style: AppStyle.boldText(),),
          //             Text(AppStrings.fisrtDigital, style: AppStyle.smallGrayText(),)
          //           ],
          //         )
          //       ],
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Text("1.00",style: AppStyle.boldText(),),
          //         Text("0.00033 ETH", style: AppStyle.smallGrayText(),)
          //       ],
          //     )
          //   ],
          // ),
          // SizedBox(height: 20.h,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Image.asset(WalletAssets.memecoin, height: 16.h,),
          //         SizedBox(width: 10.w,),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text("MEME", style: AppStyle.boldText(),),
          //             Text("Memecoin", style: AppStyle.smallGrayText(),),
          //             Text("PNL today", style: AppStyle.smallGrayText(),),
          //             Text(AppStrings.avergeCost, style: AppStyle.smallGrayText(),),
          //           ],
          //         )
          //       ],
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         SizedBox(height: 15.h,),
          //         Text("0.928",style: AppStyle.boldText(),),
          //         Text("0 \$(-1,70%)", style: AppStyle.smallRedyText(),),
          //         SizedBox(height:1.h),
          //         Text("0.046719\$", style: AppStyle.smallGrayText(),)
          //       ],
          //     )
          //   ],
          // )
          // Row(
          //   children: [
          //     Text(AppStrings.account, style: AppStyle.bolddText(),),
          //   ],
          // ),
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
                  Text("≈ 44,93428732 BTC", style: AppStyle.smallGrayText()),
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
                children: [
                  Text("44,93428732 BTC", style: AppStyle.boldText()),
                  Text("≈ 44,93428732 BTC", style: AppStyle.smallGrayText()),
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
    );
  }
}
