import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/views/chart/widgets/edit_future_modal.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view.dart';
import 'package:binance_clone/presentation/views/trade_details/trading_view_detail.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/models/trade_data.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/local_data/share_pref.dart';
import '../../theme/palette.dart';
import '../../widgets/custom_tab_bar.dart';
import '../trade_details/trade_details_view_model.dart';
import 'future_position.dart';

class USDScreen extends ConsumerStatefulWidget {
  final Function(int)? onTabChanged; // Optional callback

  const USDScreen({super.key, this.onTabChanged});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _USDScreenState();
}

class _USDScreenState extends ConsumerState<USDScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> positionsList = [];

  // late TabController _tabController;
  String currentSymbol = "BTCUSDT";
  final TextEditingController _priceController = TextEditingController();
  int _index = 1;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    loadPositions();
    loadCurrentSymbol();
  }

  void loadPositions() async {
    var positions = await SharePref.getAllPositions();
    setState(() {
      positionsList = positions;
    });
  }

  void loadCurrentSymbol() async {
    currentSymbol = await SharePref.getLocalSymbol();

    if (kDebugMode) {
      print("Giá trị symbol hiện tại: $currentSymbol");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final marketData = ref.watch(marketViewModelProvider).marketData;
    final tradeDetailsViewModel =
        ref.watch(tradeDetailsViewModelProvider(currentSymbol));
    final palette = Theme.of(context).extension<Palette>()!;

    Widget selectedWidget = Container();

    if (_index == 0) {
      selectedWidget = vainOrder(palette);
    } else if (_index == 1) {
      selectedWidget = const FuturePosition();
    } else if (_index == 2) {
      selectedWidget = const Text("Lưới hợp đồng tương lai");
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: palette.cardColor,
        body: Stack(children: [
          Container(
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
                            text: tradeDetailsViewModel.tradeData.value.symbol,
                            color: palette.appBarTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
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
                            width: 2.w,
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
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return TradeViewDetails(
                                symbol: tradeDetailsViewModel
                                    .tradeData.value.symbol,
                              );
                            })),
                            child: Image.asset(
                              FuturesAssets.stock,
                              color: palette.appBarTitleColor,
                              height: 10.h,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Image.asset(
                            FuturesAssets.caculate,
                            color: palette.appBarTitleColor,
                            height: 10.h,
                          ),
                          SizedBox(
                            width: 15.w,
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
                        textK = palette.sellButtonColor;
                      } else {
                        prePercent = '+';
                      }
                      return CustomText(
                        text:
                            "$prePercent${value.percentageChangeIn24H.toStringAsFixed(2)}%",
                        color: textK,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
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
                          borderContainer(palette: palette, title: "Cross"),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: (_) => const EditFutureModal(),
                              );
                            },
                            child:
                                borderContainer(palette: palette, title: "55x"),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          borderContainer(palette: palette, title: "S"),
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
                            fontSize: 9.sp,
                          )
                        ],
                      )
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          // padding: EdgeInsets.symmetric(horizontal: 2.w),
                          width: MediaQuery.of(context).size.width * 0.37,
                          // height: 520,
                          //color: Colors.red,
                          child: OrderBookView(
                            pair: currentSymbol,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.52,
                        // height: 520,
                        //color: Colors.blue,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Khả dụng",
                                  color: Colors.grey,
                                  fontSize: 10.sp,
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
                                  horizontal: 8.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                  color: palette.bgGray,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.info_sharp,
                                    size: 12.h,
                                    color: palette.grayColor,
                                  ),
                                  CustomText(
                                    text: "Limit",
                                    color: palette.appBarTitleColor,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 16.h,
                                    color: palette.grayColor,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: palette.bgGray,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        "−",
                                        style: TextStyle(
                                            color: palette.grayColor,
                                            fontSize: 25.sp),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Giá (USDC)",
                                            color: palette.appBarTitleColor
                                                .withOpacity(0.5),
                                            fontSize: 10.sp,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                            width: 80.w,
                                            child: TextField(
                                              controller: _priceController,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor:
                                                  palette.mainYellowColor,
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
                                        width: 5.w,
                                      ),
                                      Text(
                                        "+",
                                        style: TextStyle(
                                            color: palette.grayColor,
                                            fontSize: 23.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: palette.bgGray,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 9.h, horizontal: 16.w),
                                  child: CustomText(
                                    text: "BBO",
                                    color: palette.appBarTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: palette.bgGray,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 7.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "−",
                                    style: TextStyle(
                                        color: palette.grayColor,
                                        fontSize: 25.sp),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                          text: "Số tiền",
                                          color: Colors.grey,
                                          fontSize: 10.sp),
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
                                        color: palette.grayColor,
                                        fontSize: 23.sp),
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 1.w,
                                    color: palette.grayColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: "BTC",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: palette.selectedTimeChipColor,
                                        )
                                      ],
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
                                  color: palette.grayColor,
                                ),
                                Container(
                                  width: 25.w,
                                  height: 1.h,
                                  color: palette.grayColor,
                                ),
                                Image.asset(
                                  FuturesAssets.rhombus,
                                  height: 8.h,
                                  color: palette.grayColor,
                                ),
                                Container(
                                  width: 25.w,
                                  height: 1.h,
                                  color: palette.grayColor,
                                ),
                                Image.asset(
                                  FuturesAssets.rhombus,
                                  height: 8.h,
                                  color: palette.grayColor,
                                ),
                                Container(
                                  width: 25.w,
                                  height: 1.h,
                                  color: palette.grayColor,
                                ),
                                Image.asset(
                                  FuturesAssets.rhombus,
                                  height: 8.h,
                                  color: palette.grayColor,
                                ),
                                Container(
                                  width: 25.w,
                                  height: 1.h,
                                  color: palette.grayColor,
                                ),
                                Image.asset(
                                  FuturesAssets.rhombus,
                                  height: 8.h,
                                  color: palette.grayColor,
                                ),
                                Container(
                                  width: 25.w,
                                  height: 1.h,
                                  color: palette.grayColor,
                                ),
                                Image.asset(
                                  FuturesAssets.rhombus,
                                  height: 8.h,
                                  color: palette.grayColor,
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
                                  color: palette.grayColor,
                                  size: 14.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                const CustomText(
                                  text: "TP/SL",
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
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
                                    Text(
                                      "GTC",
                                      style: AppStyle.smallText(),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: palette.grayColor,
                                      size: 18.h,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Mở tối đa",
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF757b87),
                                  fontSize: 11.sp,
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
                                CustomText(
                                  text: "Chi phí",
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF757b87),
                                  fontSize: 11.sp,
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
                                height: 30.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: palette.mainGreenColor,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: TextButton(
                                    onPressed: () {},
                                    child: CustomText(
                                        text: "Mở lệnh long",
                                        color: Colors.white,
                                        fontSize: 12.sp))),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Mở tối đa",
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF757b87),
                                  fontSize: 11.sp,
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
                                CustomText(
                                  text: "Chi phí",
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF757b87),
                                  fontSize: 11.sp,
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
                                // height: 35.h,
                                width: double.infinity,
                                height: 30.h,
                                decoration: BoxDecoration(
                                    color: palette.sellButtonColor,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: TextButton(
                                    onPressed: () {},
                                    child: CustomText(
                                        text: "Mở lệnh short",
                                        color: Colors.white,
                                        fontSize: 12.sp))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(10.h),
                  CustomTabBar(
                    index: _index,
                    tabs: [
                      "Lệnh mở (0)",
                      "Vị thế (${positionsList.length})",
                      "Lưới hợp đồng tương lai",
                    ],
                    onChanged: (value) {
                      setState(() {
                        _index =
                            value; // Update the index value when tab changes
                      });
                    },
                  ),
                  SizedBox(height: 400.h, child: selectedWidget),
                  // SizedBox(
                  //   height: 50,
                  // ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Center vainOrder(Palette palette) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CustomText(text: "Số tiền khả dụng: 20,0000.00 USDC"),
            Text(
              "Chuyển tiền vào ví hợp đồng tương lai của bạn để giao dịch hoặc tham gia giao dịch thử nghiệm an toàn",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 10.sp, color: palette.selectedTimeChipColor),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                borderContainer(palette: palette, title: "Học hỏi"),
                borderContainer(palette: palette, title: "Chuyển tiền"),
                borderContainer(palette: palette, title: "Giao dịch thử nghiệm")
              ],
            )
          ],
        ),
      ),
    );
  }

  Container borderContainer({required Palette palette, required String title}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: palette.selectedTimeChipColor)),
      child: CustomText(
        text: title,
        color: palette.appBarTitleColor,
        fontSize: 9.sp,
        // fontWeight: FontWeight.w500,
      ),
    );
  }
}
