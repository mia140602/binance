import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart'; // Import CustomTabBar
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/palette.dart';
import 'markets_screen.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  int check = 0;

  @override
  Widget build(BuildContext context) {
    Widget selectedWidget = Container();

    if (check == 0) {
      selectedWidget = Text("Danh sách yêu thích");
    } else if(check ==1){
      selectedWidget = MarketView();
    }
    else if(check ==2){
      selectedWidget = Text("Khám phá");
    }
    else if(check ==3){
      selectedWidget = Text("Square");
    }
    else {
      selectedWidget = Text("Dữ liệu");
    }
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: palette.cardColor,
        elevation: 0,
        titleSpacing: 0,
        title: Container(
            padding:
            EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: palette.cardColor),
            child: TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.search_sharp),
                  hintText: "Tìm kiếm Coin/Cặp giao dịch/Phát sinh",hintStyle: AppStyle.smallText()),
            )),
      ),
      body: Column(
      children: [
        CustomTabBar(
          index: check,
          tabs: [
            "Danh sách yêu thích",
            "Thị trường",
            "Khám phá",
            "Square",
            "Dữ liệu"
          ],
          onChanged: (value) {
            setState(() {
              check = value; // Update the index value when tab changes
            });
          },
        ),
        Expanded(
          child: selectedWidget,
        ),
      ],
    )
    );
  }
}
