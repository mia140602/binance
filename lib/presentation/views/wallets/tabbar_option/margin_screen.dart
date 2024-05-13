import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_strings.dart';
import '../../../theme/palette.dart';
import '../../../widgets/custom_text.dart';

class MarginScreen extends StatefulWidget {
  const MarginScreen({super.key});

  @override
  State<MarginScreen> createState() => _MarginScreenState();
}

class _MarginScreenState extends State<MarginScreen> {
  bool isSelectedCross = true;

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
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectedCross = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: isSelectedCross
                              ? palette.cardColor
                              : palette.cardColor,
                        ),
                        child: Text("Cross",
                            style: isSelectedCross
                                ? AppStyle.smallText()
                                : AppStyle.smallGrayText()),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectedCross = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: isSelectedCross
                              ? palette.cardColor
                              : palette.cardColor,
                        ),
                        child: Text(
                          "Isolated",
                          style: isSelectedCross
                              ? AppStyle.smallGrayText()
                              : AppStyle.smallText(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    isSelectedCross
                        ? Text(
                            "5x",
                            style: AppStyle.orangeSmallText(),
                          )
                        : Text(
                            "Đang hoạt động 0/15",
                            style: AppStyle.orangeSmallText(),
                          ),
                    SizedBox(
                      width: 15.w,
                    ),
                    isSelectedCross
                        ? Image.asset(
                            WalletAssets.swap,
                            height: 13.h,
                            color: Colors.white,
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: 15.w,
                    ),
                    Image.asset(
                      color: Colors.white,
                      WalletAssets.snow,
                      height: 13.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Icon(
                      Icons.format_align_justify,
                      size: 14.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Icon(
                      Icons.history,
                      size: 15.h,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Text(
                  AppStrings.totalBalance,
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
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: "0.00",
                  color: palette.appBarTitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.sp,
                ),
                SizedBox(
                  width: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0.h),
                  child: Text(
                    "USD",
                    style: AppStyle.smallText(),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 14.h,
                  color: palette.grayColor,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text(
                  "PNL của hôm nay +\$0.00(0.00%)",
                  style: AppStyle.regularText(),
                ),
                Icon(
                  Icons.arrow_right_outlined,
                  size: 15.h,
                  color: palette.grayColor,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng nợ (USD)",
                      style: AppStyle.smallGrayText(),
                    ),
                    Text(
                      "\$0.0000000",
                      style: AppStyle.smallText(),
                    )
                  ],
                ),
                SizedBox(
                  width: 80.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng tài sản (USD)",
                      style: AppStyle.smallGrayText(),
                    ),
                    Text(
                      " \$0.0000000",
                      style: AppStyle.smallText(),
                    )
                  ],
                )
              ],
            ),
            isSelectedCross
                ? Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.29,
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: palette.mainYellowColor),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Vay",
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
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: palette.grayButton),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Trả nợ",
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
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 3.w),
                        width: double.infinity,
                        height: 45.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: palette.grayColor),
                            borderRadius: BorderRadius.circular(7.r)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(
                              WalletAssets.bnb,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chuyển đổi số dư nhỏ",
                                  style: AppStyle.smallText(),
                                ),
                                Text(
                                  "sang BNB",
                                  style: AppStyle.smallText(),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 1.w,
                              height: 15.h,
                              color: palette.grayColor,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Image.asset(
                              WalletAssets.no,
                              height: 17.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chuyển đổi",
                                  style: AppStyle.smallText(),
                                ),
                                Text(
                                  "nợ",
                                  style: AppStyle.smallText(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Cross",
                                style: AppStyle.boldText(),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 14.h,
                                color: palette.grayColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                Icons.lock_clock,
                                size: 14.h,
                                color: palette.mainGreenColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Rủi ro thấp 999.00",
                                style: AppStyle.smallGreenText(),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.format_align_justify,
                            size: 14.h,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                CoinAssets.bitcoin,
                                height: 14.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "1000SATS",
                                style: AppStyle.boldText(),
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.boldText(),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Có sẵn",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Tài sản",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Đã vay",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Lãi suất",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: palette.grayColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                CoinAssets.bitcoin,
                                height: 14.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "1INCH",
                                style: AppStyle.boldText(),
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.boldText(),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Có sẵn",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Tài sản",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Đã vay",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Lãi suất",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: palette.grayColor,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                CoinAssets.bitcoin,
                                height: 14.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "1000SATS",
                                style: AppStyle.boldText(),
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.boldText(),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Có sẵn",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Tài sản",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Đã vay",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Lãi suất",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: palette.grayColor,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                CoinAssets.bitcoin,
                                height: 14.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "1000SATS",
                                style: AppStyle.boldText(),
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.boldText(),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Có sẵn",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Tài sản",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Đã vay",
                            style: AppStyle.smallGrayText(),
                          ),
                          SizedBox(
                            width: 130.w,
                          ),
                          Text(
                            "Lãi suất",
                            style: AppStyle.smallGrayText(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          ),
                          SizedBox(
                            width: 145.w,
                          ),
                          Text(
                            "0.00",
                            style: AppStyle.smallText(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: palette.grayColor,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.29,
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: palette.mainYellowColor),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Vay",
                                style: TextStyle(
                                    fontSize: 15.sp,
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
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: palette.grayButton),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Trả nợ",
                                style: TextStyle(
                                    fontSize: 15.sp,
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
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: palette.grayButton),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Chuyển",
                                style: TextStyle(
                                    fontSize: 15.sp,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Isolated",
                            style: AppStyle.boldText(),
                          ),
                          Icon(
                            Icons.format_align_justify,
                            size: 14.h,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "1000SATS / USDT",
                                style: AppStyle.boldText(),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "5x",
                                style: AppStyle.smallGrayText(),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                size: 15.h,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "Rủi ro thấp 999.00",
                            style: AppStyle.smallGreenText(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư 1000SATS",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1000SATS đã vay",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1000SATS tài sản",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư BTC",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BTC đã vay",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BTC tài sản         ",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: palette.grayColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Isolated",
                            style: AppStyle.boldText(),
                          ),
                          Icon(
                            Icons.format_align_justify,
                            size: 14.h,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "1INCH / BTC",
                                style: AppStyle.boldText(),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "5x",
                                style: AppStyle.smallGrayText(),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                size: 15.h,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "Rủi ro thấp 999.00",
                            style: AppStyle.smallGreenText(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư 1INCH",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1INCH đã vay",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1INCH tài sản      ",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư BTC",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BTC đã vay",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BTC tài sản         ",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: palette.grayColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "AAVE / BTC",
                                style: AppStyle.boldText(),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "5x",
                                style: AppStyle.smallGrayText(),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Icon(
                                Icons.arrow_right_outlined,
                                size: 15.h,
                                color: palette.grayColor,
                              ),
                            ],
                          ),
                          Text(
                            "Rủi ro thấp 999.00",
                            style: AppStyle.smallGreenText(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư AAVE",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AAVE đã vay",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AAVE tài sản       ",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư BTC",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BTC đã vay",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BTC tài sản         ",
                                style: AppStyle.smallGrayText(),
                              ),
                              Text(
                                "0.00",
                                style: AppStyle.smallText(),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
