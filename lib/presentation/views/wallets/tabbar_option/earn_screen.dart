import 'package:binance_clone/presentation/views/wallets/widgets/drop_symbol_container.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/app_strings.dart';
import '../../../../utils/app_style.dart';
import '../../../app_assets.dart';
import '../../../theme/palette.dart';
import '../model/money_enum.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  bool isChecked = true;
  MoneyEnum symbol = MoneyEnum.USDT;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 10.h),
      child: SmartRefresher(
        controller: _refreshController,
        physics: const AlwaysScrollableScrollPhysics(),
        primary: true,
        enablePullUp: true,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          if (!mounted) return;
          _refreshController.refreshCompleted();
          setState(() {});
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.total_earn,
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: palette.textColor),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: palette.grayColor,
                      size: 15.h,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Countup(
                  begin: 0,
                  end: MoneyEnumExt.generateMoney(
                      symbol), //here you insert the number or its variable
                  duration: const Duration(milliseconds: 400),
                  prefix: "\$", precision: 2,
                  separator:
                      ',', //this is the character you want to add to seperate between every 3 digits
                  style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: palette.textColor),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0.w),
                  child: DropSymbolContainer(
                    onChange: (MoneyEnum value) {
                      setState(() {
                        symbol = value;
                      });
                    },
                    symbol: symbol,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'PNL hôm qua(USD)',
                        style: AppStyle.smallText().copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: palette.grayColor,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ),
                    Countup(
                      begin: 0,
                      end: MoneyEnumExt.generateMoney(
                          symbol), //here you insert the number or its variable
                      duration: const Duration(milliseconds: 400),
                      prefix: "\$", precision: 2,
                      separator:
                          ',', //this is the character you want to add to seperate between every 3 digits
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: palette.textColor),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Lợi nhuận trong 30 ngày',
                          style: AppStyle.smallText()),
                    ),
                    Text(
                      "(USD)",
                      style: AppStyle.smallText(),
                    ),
                    Text(
                      "\$0",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: palette.textColor),
                    )
                  ],
                )
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
                          border: Border.all(color: palette.grayColor)),
                      padding: EdgeInsets.all(10.h),
                      child: Image.asset(
                        WalletAssets.salary,
                        color: palette.mainYellowColor,
                        height: 24.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Earn",
                      style: AppStyle.smallboldText(),
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
                        WalletAssets.workflow,
                        height: 24.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Tự động đầu tư",
                      style: AppStyle.smallboldText(),
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
                        WalletAssets.loan,
                        height: 24.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Cho vay",
                      style: AppStyle.smallboldText(),
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
                        WalletAssets.salary,
                        color: palette.mainYellowColor,
                        height: 24.h,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Earn một chạm",
                      style: AppStyle.smallboldText(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isChecked = true;
                        });
                      },
                      child: Text(
                        "Theo tài sản",
                        style: isChecked
                            ? AppStyle.boldText()
                            : AppStyle.boldgreyText(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isChecked = false;
                        });
                      },
                      child: Text(
                        "Theo sản phẩm",
                        style: isChecked
                            ? AppStyle.boldgreyText()
                            : AppStyle.boldText(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      WalletAssets.search,
                      height: 15.h,
                      color: palette.grayColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.format_align_justify,
                      size: 15.h,
                      color: palette.grayColor,
                    )
                  ],
                )
              ],
            ),
            isChecked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        WalletAssets.bigsearch,
                        height: 80.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Không có dữ liệu được ghi nhận",
                        style: AppStyle.regularGrayText(),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          height: 32.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: palette.mainYellowColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Đăng kí ngay",
                                style: GoogleFonts.roboto(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )))
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        WalletAssets.bigsearch,
                        height: 80.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Không có dữ liệu được ghi nhận",
                        style: AppStyle.regularGrayText(),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          height: 32.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: palette.mainYellowColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Đăng kí ngay",
                                style: GoogleFonts.roboto(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
