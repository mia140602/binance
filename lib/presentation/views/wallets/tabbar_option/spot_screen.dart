import 'package:binance_clone/presentation/views/wallets/model/money_enum.dart';
import 'package:binance_clone/presentation/views/wallets/widgets/crypto_widget.dart';
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
import '../../../widgets/custom_text.dart';

class SpotScreen extends StatefulWidget {
  const SpotScreen({super.key});

  @override
  State<SpotScreen> createState() => _SpotScreenState();
}

class _SpotScreenState extends State<SpotScreen> {
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
                      SizedBox(
                        width: 8.h,
                      ),
                      DropSymbolContainer(
                        onChange: (MoneyEnum value) {
                          setState(() {
                            symbol = value;
                          });
                        },
                        symbol: symbol,
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
                  Countup(
                    begin: 0,
                    end: MoneyEnumExt.generateMoney(
                        symbol), //here you insert the number or its variable
                    duration: const Duration(milliseconds: 400),
                    prefix: "\$", precision: 2,
                    separator:
                        ',', //this is the character you want to add to seperate between every 3 digits
                    style: TextStyle(
                        letterSpacing: 0.05,
                        fontSize: 32.sp,
                        fontFamily: 'moon_plex'),
                  ),
                ],
              ),
              Row(
                children: [
                  Countup(
                    begin: 0,
                    end: MoneyEnumExt.generateMoney(
                        symbol), //here you insert the number or its variable
                    duration: const Duration(milliseconds: 400),
                    prefix: "≈", precision: 6,
                    separator:
                        '', //this is the character you want to add to seperate between every 3 digits
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
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(color: palette.grayColor),
                    borderRadius: BorderRadius.circular(7.r)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    Image.asset(
                      WalletAssets.bnb,
                      height: 16.h,
                    ),
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
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số dư",
                    style: AppStyle.bigboldText(),
                  ),
                  Row(
                    children: [
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
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              const CryptoWidget(
                showDescription: false,
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
