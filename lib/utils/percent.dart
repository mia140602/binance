import 'dart:async';
import 'dart:math';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../presentation/theme/palette.dart';

class PercentageBar extends StatefulWidget {
  @override
  _PercentageBarState createState() => _PercentageBarState();
}

class _PercentageBarState extends State<PercentageBar> {
  late double leftPercentage;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    leftPercentage = Random().nextDouble() * 100; // Khởi tạo giá trị ban đầu
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => randomizePercentages());
  }

  void randomizePercentages() {
    setState(() {
      double newPercentage;
      do {
        newPercentage = Random().nextDouble() * 100;
      } while ((newPercentage - leftPercentage).abs() >
          10); // Đảm bảo thay đổi không quá 30%
      leftPercentage = newPercentage;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double rightPercentage = 100 - leftPercentage;
    double width = MediaQuery.of(context).size.width * 0.68;
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      backgroundColor: palette.cardColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomText(
              text: '${leftPercentage.toStringAsFixed(2)}% ',
              fontSize: 11.sp,
              color: palette.mainGreenColor),
          SizedBox(width: 10.w),
          Stack(
            children: <Widget>[
              Container(
                height: 4,
                width: width,
                decoration: BoxDecoration(
                  color: palette.sellButtonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 4,
                width: width * leftPercentage / 100,
                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: palette.cardColor, width: 2)),
                  color: palette.mainGreenColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Gap(10.w),
          CustomText(
              text: '${rightPercentage.toStringAsFixed(2)}% ',
              fontSize: 11.sp,
              color: palette.sellButtonColor),
        ],
      ),
    );
  }
}
