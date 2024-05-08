import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/palette.dart';
import '../../widgets/custom_tab_bar.dart';

class OverviewScreen extends StatefulWidget {
  final int index;
  const OverviewScreen({super.key, this.index = 0, required this.onTabChanged});
  final Function(int) onTabChanged;

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  late int _index = widget.index;
  void _setIndex(int value) {
    if (_index != value) {
      setState(() {
        _index = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      color: palette.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                    color: Colors.grey,
                    size: 15.h,
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    WalletAssets.lineChart,
                    height: 15.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
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
            children: [
              Text(
                "0,00033 \tETH",
                style: AppStyle.bigboldText(),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 16.h,
              )
            ],
          ),
          Row(
            children: [
              Text(
                "≈ 1,02",
                style: AppStyle.smallGrayText(),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "PNL today",
                style: AppStyle.regularText().copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "+0,000241 \$",
                style: AppStyle.smallGreenText(),
              ),
              Text(
                "+0.02%",
                style: AppStyle.smallGreenText(),
              ),
              Icon(
                Icons.arrow_right_outlined,
                size: 17.h,
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.yellow[600],
                  ),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextButton(onPressed: () {}, child: Text("Recharge"))),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey[200],
                  ),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextButton(onPressed: () {}, child: Text("Purchase"))),
            ],
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTabBar(
                index: _index,
                tabs: const ["Giá", "Thông tin", "Dữ liệu giao dịch", "Square"],
                onChanged: (value) {
                  _setIndex(value);
                  widget.onTabChanged.call(value);
                },
              ),
              Row(
                children: [
                  Image.asset(
                    WalletAssets.edit,
                    height: 14.h,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset(
                    WalletAssets.setting,
                    height: 14.h,
                    color: Colors.grey,
                  ),
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
              Row(
                children: [
                  Image.asset(
                    WalletAssets.fdusd,
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FDUSE",
                        style: AppStyle.boldText(),
                      ),
                      Text(
                        AppStrings.fisrtDigital,
                        style: AppStyle.smallGrayText(),
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "1.00",
                    style: AppStyle.boldText(),
                  ),
                  Text(
                    "0.00033 ETH",
                    style: AppStyle.smallGrayText(),
                  )
                ],
              )
            ],
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
                    WalletAssets.memecoin,
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MEME",
                        style: AppStyle.boldText(),
                      ),
                      Text(
                        "Memecoin",
                        style: AppStyle.smallGrayText(),
                      ),
                      Text(
                        "PNL today",
                        style: AppStyle.smallGrayText(),
                      ),
                      Text(
                        AppStrings.avergeCost,
                        style: AppStyle.smallGrayText(),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "0.928",
                    style: AppStyle.boldText(),
                  ),
                  Text(
                    "0 \$(-1,70%)",
                    style: AppStyle.smallRedyText(),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "0.046719\$",
                    style: AppStyle.smallGrayText(),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
