import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/views/futures/bottom_tabbar.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/models/trade_data.dart';
import 'package:binance_clone/presentation/views/markets/market_view_model.dart';

import '../../theme/palette.dart';
import '../../widgets/custom_tab_bar.dart';
import '../trade_details/trade_details_view_model.dart';

class USDScreen extends ConsumerStatefulWidget {
  final Function(int)? onTabChanged; // Optional callback

  const USDScreen({super.key, this.onTabChanged});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _USDScreenState();
}

class _USDScreenState extends ConsumerState<USDScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String currentSymbol = "BTCUSDT";
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final marketData = ref.watch(marketViewModelProvider).marketData;
    final tradeDetailsViewModel =
        ref.watch(tradeDetailsViewModelProvider(currentSymbol));
    final palette = Theme.of(context).extension<Palette>()!;

    int _index = 0;
    // @override
    // void initState() {
    //   super.initState();
    //   _tabController = TabController(
    //       length: 4,
    //       vsync:
    //           this); // Số lượng tabs phải khớp với số lượng trong CustomTabBar
    //   // _tabController.addListener(_handleTabSelection);
    // }

    void _setIndex(int newIndex) {
      setState(() {
        _index = newIndex;
      });
    }

    @override
    void initState() {
      super.initState();
      // _tabController = TabController(length: 3, vsync: this);

      // Thiết lập giá trị ban đầu cho _priceController
      _priceController = TextEditingController(text: '1234');
      print("Giá trị ban đầu: ${_priceController.text}");
    }

    return Scaffold(
      backgroundColor: palette.cardColor,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: "BTCUSDC",
                        color: palette.appBarTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: palette.selectedTabChipColor,
                            borderRadius: BorderRadius.circular(4.r)),
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: CustomText(
                          text: "Hợp đồng tương lai vĩnh cửu",
                          fontSize: 8,
                          color: palette.appBarTitleColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 18.h,
                        color: palette.appBarTitleColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.settings_input_composite_sharp,
                        size: 16.h,
                        color: palette.appBarTitleColor,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Image.asset(
                        FuturesAssets.caculate,
                        color: palette.appBarTitleColor,
                        height: 16.h,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8.h,
                            color: Colors.yellow[700],
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: palette.appBarTitleColor,
                            size: 21.h,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              ValueListenableBuilder<TradeData>(
                valueListenable: tradeDetailsViewModel.tradeData,
                builder: (context, value, child) {
                  Color textK = palette.mainGreenColor;
                  String prePercent = '';
                  if (value.isPriceChangeIn24HNeg == true) {
                    textK = Colors.red;
                  } else {
                    prePercent = '+';
                  }
                  return CustomText(
                    text:
                        "$prePercent${value.percentageChangeIn24H.toStringAsFixed(2)}%",
                    color: textK,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                                color: palette.selectedTimeChipColor)),
                        child: CustomText(
                          text: "Cross",
                          color: palette.appBarTitleColor,
                          fontSize: 10.sp,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                                color: palette.selectedTimeChipColor)),
                        child: CustomText(
                          text: "20x",
                          color: palette.appBarTitleColor,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                                color: palette.selectedTimeChipColor)),
                        child: CustomText(
                          text: "S",
                          color: palette.appBarTitleColor,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Funding / Countdown",
                        style: AppStyle.minimumlGrayText(),
                      ),
                      CustomText(
                        text: "-0.0060%/00:53:12",
                        color: palette.appBarTitleColor,
                        fontSize: 10.sp,
                      )
                    ],
                  )
                ],
              ),
              // OrderBookView(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // padding: EdgeInsets.symmetric(horizontal: 2.w),
                      width: MediaQuery.of(context).size.width * 0.4,
                      // height: 520,
                      //color: Colors.red,
                      child: OrderBookView()),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.52,
                    height: 520,
                    //color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Avbl",
                              style: AppStyle.minimumlGrayText(),
                            ),
                            Row(
                              children: [
                                Text(
                                  "--",
                                  style: AppStyle.minimumText(),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Icon(
                                  Icons.swap_horiz,
                                  size: 13.h,
                                  color: Colors.yellow[700],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 1.h),
                          decoration: BoxDecoration(
                              color: palette.selectedTabChipColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.info_sharp,
                                size: 12.h,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "Limit",
                                color: palette.appBarTitleColor,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 16.h,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: palette.selectedTabChipColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              child: Row(
                                children: [
                                  Text(
                                    "−",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 25.sp),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Giá (USDC)",
                                        color: palette.appBarTitleColor
                                            .withOpacity(0.5),
                                        fontSize: 10.sp,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 80.w,
                                        child: TextField(
                                          controller: _priceController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          cursorColor: palette.mainYellowColor,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: palette.appBarTitleColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 23.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: palette.selectedTabChipColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 9.h, horizontal: 16.w),
                              child: CustomText(
                                text: "BBO",
                                color: palette.appBarTitleColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: palette.selectedTabChipColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 7.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "−",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 25.sp),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Amount",
                                    style: AppStyle.minimumlGrayText(),
                                  ),
                                  Text(
                                    "0%",
                                    style: AppStyle.boldText(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "+",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 23.sp),
                              ),
                              Container(
                                height: 20.h,
                                width: 1.w,
                                color: Colors.grey.shade400,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  "BTC",
                                  style: AppStyle.boldText(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              FuturesAssets.rhombus,
                              height: 13.h,
                            ),
                            Container(
                              width: 27.w,
                              height: 1.h,
                              color: Colors.grey,
                            ),
                            Image.asset(
                              FuturesAssets.rhombus,
                              height: 8.h,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 27.w,
                              height: 1.h,
                              color: Colors.grey,
                            ),
                            Image.asset(
                              FuturesAssets.rhombus,
                              height: 8.h,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 27.w,
                              height: 1.h,
                              color: Colors.grey,
                            ),
                            Image.asset(
                              FuturesAssets.rhombus,
                              height: 8.h,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 27.w,
                              height: 1.h,
                              color: Colors.grey,
                            ),
                            Image.asset(
                              FuturesAssets.rhombus,
                              height: 8.h,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 27.w,
                              height: 1.h,
                              color: Colors.grey,
                            ),
                            Image.asset(
                              FuturesAssets.rhombus,
                              height: 8.h,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                              size: 14.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "TP/SL",
                              style: AppStyle.smallText(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey,
                                  size: 14.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Reduce Only",
                                  style: AppStyle.smallText(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "GTC",
                                  style: AppStyle.smallText(),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                  size: 18.h,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Max",
                              style: AppStyle.smallGrayText(),
                            ),
                            Text(
                              "0.000 BTC",
                              style: AppStyle.smallText(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cost",
                              style: AppStyle.smallGrayText(),
                            ),
                            Text(
                              "0.00 USDC",
                              style: AppStyle.smallText(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6.r)),
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Buy/Long",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ))),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Max",
                              style: AppStyle.smallGrayText(),
                            ),
                            Text(
                              "0.000 BTC",
                              style: AppStyle.smallText(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cost",
                              style: AppStyle.smallGrayText(),
                            ),
                            Text(
                              "0.00 USDC",
                              style: AppStyle.smallText(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6.r)),
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Sell/Short",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Open your Futures Account",
                          style: AppStyle.smallText(),
                        ),
                        Text("Embark on your Trading ",
                            style: AppStyle.smallGrayText()),
                        Text("journey with us",
                            style: AppStyle.smallGrayText()),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          FuturesAssets.graphic,
                          height: 50.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              CustomTabBar(
                index: _index,
                tabs: const [
                  "Lệnh mở",
                  "Vị thế",
                  "Lưới hợp đồng tương lai",
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
