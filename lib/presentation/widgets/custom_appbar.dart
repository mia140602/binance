import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/palette.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return AppBar(
      backgroundColor: const Color(0xFF1F2630),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Image.asset(
            AppAssets.lightLogo,
            height: 20.h,
          ),
        ),
        Container(
          height: 29.h,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade800),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Icon(
                Icons.search,
                color: Colors.grey,
                size: 20.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                AppStrings.megadrop,
                style: AppStyle.boldgreyText(),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 8.0.w),
            child: Image.asset(
              AppAssets.scanIcon,
              height: 15.h,
              color: palette.appBarTitleColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Image.asset(
              AppAssets.headphoneIcon,
              height: 15.h,
              color: palette.appBarTitleColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Image.asset(
              AppAssets.bellringIcon,
              height: 15.h,
              color: palette.appBarTitleColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 15.0.w,left: 8.0.w),
            child: Image.asset(
              AppAssets.coinIcon,
              color: palette.appBarTitleColor,
              height: 15.h,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
