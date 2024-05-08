import 'package:binance_clone/presentation/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_strings.dart';
import '../../../../utils/app_style.dart';
import '../../../theme/palette.dart';
import '../../../widgets/custom_text.dart';

class FundingScreen extends StatefulWidget {
  const FundingScreen({super.key});

  @override
  State<FundingScreen> createState() => _FundingScreenState();
}

class _FundingScreenState extends State<FundingScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Color(0xFF333B46);
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.total_balance,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: palette.grayColor,
                      size: 15.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                          color: palette.cardColor,
                          borderRadius: BorderRadius.circular(3.r)),
                      child: Row(
                        children: [
                          Text(
                            "USD",
                            style: AppStyle.minimumlBoldGrayText(),
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
                    Icon(
                      Icons.history,
                      size: 14.h,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                CustomText(
                  text: "0.00",
                  color: palette.appBarTitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.sp,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "≈ 695,7274922",
                  style: AppStyle.smallGrayText(),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.29,
                  height: MediaQuery.of(context).size.width * 0.096,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: palette.mainYellowColor),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Nạp",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.29,
                  height: MediaQuery.of(context).size.width * 0.096,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: palette.grayButton),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Rút",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: palette.textColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.29,
                  height: MediaQuery.of(context).size.width * 0.096,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: palette.grayButton),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Chuyển",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: palette.textColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.grey.shade700)),
                      padding: EdgeInsets.all(10.h),
                      child: Image.asset(
                        WalletAssets.p2p,
                        height: 22.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "P2P",
                      style: AppStyle.boldText(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: palette.grayColor)),
                      padding: EdgeInsets.all(10.h),
                      child: Image.asset(
                        WalletAssets.buywith,
                        height: 22.h,
                        color: palette.mainYellowColor,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Thanh toán",
                      style: AppStyle.boldText(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: palette.grayColor)),
                      padding: EdgeInsets.all(10.h),
                      child: Image.asset(
                        WalletAssets.gif,
                        height: 22.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Thẻ quà tặng",
                      style: AppStyle.boldText(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: palette.grayColor)),
                      padding: EdgeInsets.all(10.h),
                      child: Image.asset(
                        WalletAssets.pool,
                        color: palette.textColor,
                        height: 22.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Pool",
                      style: AppStyle.boldText(),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0.w),
                  child: Text(
                    "Số dư",
                    style: AppStyle.bigboldText(),
                  ),
                ),
                Image.asset(
                  WalletAssets.search,
                  height: 15.h,
                  color: palette.grayColor,
                ),
        
              ],
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  side: BorderSide(color: palette.grayColor),
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text("Ẩn tài sản <1 USD", style: AppStyle.boldText(),)
              ],
            ),
            SizedBox(height: 15.h,),
            Container(
              padding: EdgeInsets.only(left: 10.w),
              child:Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(CoinAssets.bnb, height: 22.h,),
                            ],
                          ),
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("BNB", style: AppStyle.bigText(),),
                              Text("BNB", style: AppStyle.smallGrayText(),)
                            ],
                          ),
                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CoinAssets.bitcoin, height: 22.h,),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("BTC", style: AppStyle.bigText(),),
                              Text("Bitcoin", style: AppStyle.smallGrayText(),)
                            ],
                          ),

                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CoinAssets.eth, height: 22.h,),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ETH", style: AppStyle.bigText(),),
                              Text("Ethereum", style: AppStyle.smallGrayText(),)
                            ],
                          ),

                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CoinAssets.dogecoin, height: 22.h,),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("DOGE", style: AppStyle.bigText(),),
                              Text("Dogecoin", style: AppStyle.smallGrayText(),)
                            ],
                          ),

                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CoinAssets.solana, height: 22.h,),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("SOL", style: AppStyle.bigText(),),
                              Text("Solana", style: AppStyle.smallGrayText(),)
                            ],
                          ),

                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CoinAssets.w, height: 22.h,),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("W", style: AppStyle.bigText(),),
                              Text("Wormhole", style: AppStyle.smallGrayText(),)
                            ],
                          ),

                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(CoinAssets.shib, height: 22.h,),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("SHIB", style: AppStyle.bigText(),),
                              Text("SHIBA INU", style: AppStyle.smallGrayText(),)
                            ],
                          ),

                        ],
                      ),
                      Text("0.00", style: AppStyle.bigText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Khả dụng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.0.w),
                        child: Text("Đóng băng", style: AppStyle.smallGrayText(),),
                      ),
                      Text("0.00", style: AppStyle.smallText(),),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                ],
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
