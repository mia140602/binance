import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/models/trade_data.dart';
import 'package:gap/gap.dart';

import '../../../data/local_data/sharepref.dart';
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
  double _sliderValue = 0.0;

  // late TabController _tabController;
  String currentSymbol = "BTCUSDT";
  TextEditingController _priceController = TextEditingController();
  int _index = 0;

  void _setIndex(int value) {
    if (_index != value) {
      setState(() {
        _index = value;
      });
    }
  }

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
    print("Giá trị symbol hiện tại: $currentSymbol");
    setState(
        () {}); // Call setState if you need to update the UI based on the new symbol
  }

  @override
  Widget build(BuildContext context) {
    // final marketData = ref.watch(marketViewModelProvider).marketData;
    final tradeDetailsViewModel =
        ref.watch(tradeDetailsViewModelProvider(currentSymbol));
    final palette = Theme.of(context).extension<Palette>()!;

    bool _isOpen = false; // Flag to track drawer visibility

    void _toggleDrawer() {
      setState(() {
        _isOpen = !_isOpen;
      });
    }

    Widget selectedWidget = Container();

    if (_index == 0) {
      selectedWidget = Text("lệnh mở");
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
                          Image.asset(
                            FuturesAssets.stock,
                            color: palette.appBarTitleColor,
                            height: 10.h,
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
                              fontSize: 9.sp,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _toggleDrawer();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                      color: palette.selectedTimeChipColor)),
                              child: CustomText(
                                text: "20x",
                                color: palette.appBarTitleColor,
                                fontSize: 9.sp,
                              ),
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
                              fontSize: 9.sp,
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
                            fontSize: 9.sp,
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
                          child: OrderBookView(
                            pair: currentSymbol,
                          )),
                      Container(
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
                            // Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 20.h),
                            //   child: SliderTheme(
                            //     data: SliderTheme.of(context).copyWith(
                            //       thumbShape: SliderThumbImage(Image.asset(
                            //         FuturesAssets.rhombus,
                            //         height: 20.h,
                            //         color: palette.grayColor,
                            //       )),
                            //       activeTrackColor: Colors.white,
                            //       inactiveTrackColor: palette.grayColor,
                            //       overlayColor:
                            //           Colors.transparent, // Bỏ overlay mặc định
                            //     ),
                            //     child: Slider(
                            //       value: _sliderValue,
                            //       min: 0.0,
                            //       max: 100.0,
                            //       divisions: 4, // Chia thành 5 mốc
                            //       label: "${_sliderValue.round()}%",
                            //       onChanged: (double value) {
                            //         setState(() {
                            //           _sliderValue = value;
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // ),
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
                                CustomText(
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
                                  color: Color(0xFF757b87),
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
                                  color: Color(0xFF757b87),
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
                                  color: Color(0xFF757b87),
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
                                  color: Color(0xFF757b87),
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
}

class SliderThumbImage extends SliderComponentShape {
  final Widget image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(8.h, 8.h); // Kích thước của thumb
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final imageWidget = image as Image;
    final imageProvider = imageWidget.image as AssetImage;

    final paint = Paint()..filterQuality = FilterQuality.high;
    final imageSize = Size(8.h, 8.h); // Kích thước của hình ảnh
    final imageRect = Rect.fromCenter(
        center: center, width: imageSize.width, height: imageSize.height);
    imageProvider.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        // Chuyển đổi info.image.width và info.image.height sang double
        canvas.drawImageRect(
            info.image,
            Offset.zero &
                Size(info.image.width.toDouble(), info.image.height.toDouble()),
            imageRect,
            paint);
      }),
    );
  }
}
