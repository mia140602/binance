import 'dart:math';

import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_text.dart';

class MoneyContainer extends StatelessWidget {
  const MoneyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${AppStrings.total_balance} (USD)",
              style: AppStyle.regularBoldText(),
            ),
            SizedBox(
              width: 5.w,
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 12.h,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Countup(
              begin: 0,
              end: Random()
                  .nextDouble(), //here you insert the number or its variable
              duration: const Duration(milliseconds: 400),
              prefix: "\$", precision: 2,
              separator:
                  ',', //this is the character you want to add to seperate between every 3 digits
              style: TextStyle(
                  letterSpacing: 0.05,
                  fontSize: 32.sp,
                  fontFamily: 'moon_plex'),
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.20).w,
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
            )
          ],
        )
      ],
    );
  }
}
