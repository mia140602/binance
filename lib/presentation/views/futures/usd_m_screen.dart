import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/views/futures/chartview/fundingTime.dart';
import 'package:binance_clone/presentation/views/futures/widget/margin_futures_modal.dart';
import 'package:binance_clone/presentation/views/futures/widget/slider/usd_slider.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view.dart';
import 'package:binance_clone/presentation/views/trade_details/trading_view_detail.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/models/trade_data.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/local_data/sharepref.dart';
import '../../theme/palette.dart';
import '../../widgets/custom_tab_bar.dart';
import '../trade_details/trade_details_view_model.dart';
import 'future_position.dart';
import 'provider/future_provider.dart';
import 'widget/edit_future_modal.dart';

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
  TextEditingController _priceController = TextEditingController();
  TextEditingController _marginLeverageController = TextEditingController();
  int _index = 1;

  void _setIndex(int value) {
    if (_index != value) {
      setState(() {
        _index = value;
      });
    }
  }

  void createPosition(String type) async {
    try {
      double entryPrice = double.tryParse(_priceController.text) ?? 0;
      double marginLeverage =
          double.tryParse(_marginLeverageController.text) ?? 0;
      double leverage = ref.read(leverageProvider).toDouble();
      double margin = marginLeverage / leverage;
      String symbol = currentSymbol;

      List<Map<String, dynamic>> wallets = await SharePref.getAllWallets();
      if (wallets.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Không có ví nào được tìm thấy!")));
        return;
      }
      String walletName = wallets.first['name'];

      await SharePref.addPosition(
          walletName, symbol, type, entryPrice, leverage, margin);
      await loadPositions();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Tạo thành công!")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lỗi khi tạo vị thế: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    loadPositions();
    loadCurrentSymbol();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tradeDetailsViewModel =
          ref.read(tradeDetailsViewModelProvider(currentSymbol));
      String currentPrice = tradeDetailsViewModel.tradeData.value.currentPrice;
      String integerPart =
          currentPrice.split('.')[0]; // Lấy phần nguyên của giá
      _priceController.text = integerPart;
    });
  }

  Future<void> loadPositions() async {
    try {
      var positions = await SharePref.getAllPositions();
      setState(() {
        positionsList = positions;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lỗi khi tải vị thế: $e")));
    }
  }

  void loadCurrentSymbol() async {
    currentSymbol = await SharePref.getLocalSymbol();
    print("Giá trị symbol hiện tại: $currentSymbol");
    setState(
        () {}); // Call setState if you need to update the UI based on the new symbol
  }

  @override
  Widget build(BuildContext context) {
    // final marketData = ref.watch(marketViewModelProvider).marketData;

    double _value = 0;
    final tradeDetailsViewModel =
        ref.watch(tradeDetailsViewModelProvider(currentSymbol));

    final numberFormat = NumberFormat("#,##0", "en_US");
    final totalBalance = tradeDetailsViewModel.totalBalanceNotifier;
    final palette = Theme.of(context).extension<Palette>()!;
    double entryPrice = double.tryParse(_priceController.text) ?? 0;
    double marginLeverage =
        double.tryParse(_marginLeverageController.text) ?? 0;
    double leverage = ref.read(leverageProvider).toDouble();
    double maxOpenValue =
        calculateMaxOpenValue(marginLeverage, leverage, entryPrice);
    double cost = calculateCost(maxOpenValue, entryPrice, leverage);

    Widget selectedWidget = Container();

    if (_index == 0) {
      selectedWidget = vainOrder(palette);
    } else if (_index == 1) {
      selectedWidget = FuturePosition();
    } else if (_index == 2) {
      selectedWidget = Text("Lưới hợp đồng tương lai");
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
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: tradeDetailsViewModel.tradeData.value.symbol,
                            color: palette.selectedTabTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17.sp,
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
                              fontSize: 9.sp,
                              color: palette.appBarTitleColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
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
                          Stack(
                            children: [
                              Positioned(
                                right: 0,
                                child: Icon(
                                  Icons.circle,
                                  size: 6.h,
                                  color: Colors.yellow[700],
                                ),
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
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: palette.cardColor,
                                  context: context,
                                  builder: (_) => MarginFutureModal(),
                                );
                              },
                              child: borderContainer(
                                  palette: palette,
                                  title: '${ref.watch(marginProvider)}')),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: palette.cardColor,
                                context: context,
                                builder: (_) => EditLeverageFutureModal(),
                              );
                            },
                            child: borderContainer(
                                palette: palette,
                                title: "${ref.watch(leverageProvider)}x"),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          borderContainer(palette: palette, title: "S"),
                        ],
                      ),
                      Container(
                        height: 45.h,
                        width: 110.w,
                        child: FundingTime(
                          symbol: currentSymbol,
                        ),
                      )
                    ],
                  ),
                  // Gap(5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.52,
                          // padding: EdgeInsets.symmetric(horizontal: 2.w),
                          width: MediaQuery.of(context).size.width * 0.38,
                          // height: 520,
                          //color: Colors.red,
                          child: OrderBookView(
                            pair: currentSymbol,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.52,
                        height: MediaQuery.of(context).size.height * 0.52,
                        //color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    ValueListenableBuilder<double>(
                                      valueListenable: totalBalance,
                                      builder: (context, value, child) {
                                        return CustomText(
                                          // text: '${value.toStringAsFixed(2)}',
                                          text:
                                              '${numberFormat.format(value)} USDT',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        );
                                      },
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
                                    color: palette.selectedTimeChipColor,
                                  ),
                                  CustomText(
                                    text: "Limit",
                                    color: palette.appBarTitleColor,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    size: 16.h,
                                    color: palette.selectedTimeChipColor,
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
                                  padding: EdgeInsets.symmetric(
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
                                            text:
                                                "Giá (${tradeDetailsViewModel.tradeData.value.quoteAsset})",
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
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor:
                                                  palette.mainYellowColor,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: palette.appBarTitleColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
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
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
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
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _marginLeverageController,
                                      keyboardType: TextInputType.number,
                                      cursorColor: palette.mainYellowColor,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: palette.appBarTitleColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                        label: CustomText(
                                          text: "Số tiền",
                                          color: palette.selectedTimeChipColor,
                                          fontSize: 12.sp,
                                          textAlign: TextAlign.center,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
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
                                          text:
                                              "${tradeDetailsViewModel.tradeData.value.baseAsset}",
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
                              height: 10.h,
                            ),
                            UsdSlider(
                              divisions: 4,
                            ),
                            SizedBox(
                              height: 5.h,
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
                                Text(
                                  "TP/SL",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    decoration:
                                        TextDecoration.underline, // Gạch chân
                                    decorationStyle: TextDecorationStyle
                                        .dotted, // Kiểu gạch chân là chấm
                                    decorationColor:
                                        palette.selectedTimeChipColor,
                                    decorationThickness: 1.5,
                                  ),
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
                                  color: Color(0xFF757b87),
                                  fontSize: 10.sp,
                                ),
                                Text(
                                  "${maxOpenValue.toStringAsFixed(2)} ${tradeDetailsViewModel.tradeData.value.baseAsset}",
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
                                  color: Color(0xFF757b87),
                                  fontSize: 10.sp,
                                ),
                                Text(
                                  "${cost.toStringAsFixed(2)} ${tradeDetailsViewModel.tradeData.value.quoteAsset}",
                                  style: AppStyle.smallText(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                                height: 28.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: palette.mainGreenColor,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: TextButton(
                                    onPressed: () {
                                      createPosition("Long");
                                    },
                                    child: CustomText(
                                        text: "Mở lệnh long",
                                        color: Colors.white,
                                        fontSize: 12.sp))),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Mở tối đa",
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF757b87),
                                  fontSize: 11.sp,
                                ),
                                Text(
                                  "${maxOpenValue.toStringAsFixed(2)} ${tradeDetailsViewModel.tradeData.value.baseAsset}",
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
                                  color: Color(0xFF757b87),
                                  fontSize: 11.sp,
                                ),
                                Text(
                                  "${cost.toStringAsFixed(0)} ${tradeDetailsViewModel.tradeData.value.quoteAsset}",
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
                                height: 28.h,
                                decoration: BoxDecoration(
                                    color: palette.sellButtonColor,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: TextButton(
                                    onPressed: () {
                                      createPosition("Short");
                                    },
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
                  Container(
                    decoration: BoxDecoration(
                        color: palette.cardColor,
                        border: Border(
                            bottom: BorderSide(
                                width: 0.6,
                                color: palette.selectedTimeChipColor
                                    .withOpacity(0.5)))),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTabBar(
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
                        ),
                        Image.asset(
                          "assets/icons/time.png",
                          width: 15.w,
                        )
                      ],
                    ),
                  ),
                  Container(height: 400.h, child: selectedWidget),
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
            CustomText(text: "Số tiền khả dụng: 20,0000.00 USDC"),
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
          border: Border.all(
              color: palette.selectedTimeChipColor.withOpacity(0.4))),
      child: CustomText(
        text: title,
        color: palette.appBarTitleColor,
        fontSize: 10.sp,
        // fontWeight: FontWeight.w500,
      ),
    );
  }

  double calculateMaxOpenValue(
      double marginLeverage, double leverage, double entryPrice) {
    return marginLeverage * leverage / entryPrice;
  }

  // Hàm tính chi phí
  double calculateCost(
      double maxOpenValue, double entryPrice, double leverage) {
    return maxOpenValue / leverage * entryPrice;
  }
}
