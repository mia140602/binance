import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Image.asset(
                "assets/icons/binance.png",
                height: 20.h,
              ),
            ),
            Container(
              height: 30.h,
              width: MediaQuery.of(context).size.width * 0.52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100]),
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
                    "Megadrop",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 8.0.w),
                child: Image.asset(
                  "assets/icons/scan.png",
                  height: 15.h,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Image.asset(
                  "assets/icons/headphone.png",
                  height: 15.h,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Image.asset(
                  "assets/icons/bell-ring.png",
                  height: 15.h,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Image.asset(
                  "assets/icons/coin.png",
                  height: 15.h,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
