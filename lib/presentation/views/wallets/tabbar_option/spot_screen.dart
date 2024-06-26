import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_strings.dart';
import '../../../../utils/app_style.dart';
import '../../../app_assets.dart';
import '../../../theme/palette.dart';
import '../../../widgets/custom_text.dart';

class SpotScreen extends StatefulWidget {
  const SpotScreen({super.key});

  @override
  State<SpotScreen> createState() => _SpotScreenState();
}

class _SpotScreenState extends State<SpotScreen> {
  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
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
                    Icon(Icons.history,size: 14.h,)
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
                      borderRadius: BorderRadius.circular(7.r),
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
                      borderRadius: BorderRadius.circular(7.r),
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
                      borderRadius: BorderRadius.circular(7.r),
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
            ),SizedBox(height: 15.h,),
            Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(
                  border: Border.all(color: palette.grayColor),
                  borderRadius: BorderRadius.circular(7.r)
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Image.asset(WalletAssets.bnb, height: 16.h,),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Chuyển đổi tài sản có giá trị nhỏ sang BNB",
                    style: AppStyle.smallText(),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Số dư", style: AppStyle.bigboldText(),),
                Row(children: [
                    Image.asset(
                      WalletAssets.search,
                      height: 15.h,
                      color: palette.grayColor,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Image.asset(
                      WalletAssets.setting,
                      height: 15.h,
                      color: palette.grayColor,
                    ),
                  ],)
              ],
            ),
            SizedBox(height: 15.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(CoinAssets.bnb, height: 22.h,),
                    SizedBox(width: 10.h,),
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
            SizedBox(height: 15.h,),
          ],
        ),
      ),
    );
  }
}
