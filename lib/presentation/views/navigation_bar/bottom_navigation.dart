import 'package:binance_clone/presentation/views/futures/chartview/chartview.dart';

import 'package:binance_clone/presentation/views/wallets/wallets_screen.dart';
import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/views/futures/futures_screen.dart';
import 'package:binance_clone/presentation/views/home/home_screen.dart';
import 'package:binance_clone/presentation/views/markets/markets_screen.dart';
import 'package:flutter/widgets.dart';
// import 'package:binance_clone/presentation/views/wallets/wallets_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';

import '../../../data/local_data/sharepref.dart';
import '../../theme/palette.dart';
import '../futures/chartview/fundingTime.dart';
import '../transaction_screen/transaction_screen.dart';

class BottomNavigationBarr extends StatefulWidget {
  const BottomNavigationBarr({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarr> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<BottomNavigationBarr> {
  int _currentIndex = 0;
  String currentSymbol = "BTCUSDT";
  bool _showContainer = false;
  double bottomHeight = 0.0;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    loadCurrentSymbol();
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const MarketView(),
    TransactionScreen(),
    // FundingTime(
    //   symbol: "BTCUSDT",
    // ),
    FuturesScreen(),
    WalletScreen()
  ];
  void toggleContainer() {
    setState(() {
      _showContainer =
          !_showContainer; // Đảo ngược trạng thái hiển thị của Container
    });
    print("Giá trị showcontainer: $_showContainer");
  }

  void loadCurrentSymbol() async {
    currentSymbol = await SharePref.getLocalSymbol();
    print("Giá trị symbol hiện tại: $currentSymbol");
    setState(
        () {}); // Call setState if you need to update the UI based on the new symbol
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      backgroundColor: palette.cardColor,
      extendBody: true,
      bottomNavigationBar: _buildBottomAppBar(palette),
      body: _screens[_currentIndex],
    );
  }

  Widget _topbottom(Palette palette) {
    Widget topNavWidget = Container();
    if (_showContainer == false) {
      topNavWidget = Column(
        children: [
          Container(
            height: 0.5.h,
            color: palette.selectedTimeChipColor.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                toggleContainer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Biểu đồ ${currentSymbol} Vĩnh cửu",
                    fontSize: 11.sp,
                  ),
                  Icon(
                    Icons.arrow_drop_up_rounded,
                    color: palette.selectedTimeChipColor,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 0.5.h,
            color: palette.selectedTimeChipColor.withOpacity(0.4),
          ),
        ],
      );
    } else {
      topNavWidget = Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 200.h,
        color: palette.cardColor,
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: CustomTabBar(tabs: [
                    "Thời gian",
                    "1m",
                    "3m",
                    "15m",
                    "30m",
                    "1h",
                    "2h",
                    "4h",
                    "6h",
                    "8h",
                    "12h",
                    "1ngày",
                    "3d",
                    "1w",
                    '1M'
                  ], index: 11),
                ),
                GestureDetector(
                    onTap: () {
                      toggleContainer();
                    },
                    child: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: palette.selectedTimeChipColor,
                    ))
              ],
            ),
            Container(
                height: 160.h,
                child: TradingChartScreen(
                  symbol: currentSymbol,
                  isSmall: true,
                )),
          ],
        ),
      );
    }
    return topNavWidget;
  }

  BottomAppBar _buildBottomAppBar(Palette palette) {
    return BottomAppBar(
      height: _showContainer == false ? 70.h : 270.h,
      color: palette.cardColor,
      padding: EdgeInsets.zero,
      surfaceTintColor: palette.cardColor,
      elevation: 4,
      // shape: const CircularNotchedRectangle(),
      child: Column(
        children: [
          _currentIndex == 3 ? _topbottom(palette) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    constraints: BoxConstraints(),
                    icon: _currentIndex == 0
                        ? Image.asset(
                            'assets/icons/bottom_nav_icon/home_clicked.png',
                            height: 16.h)
                        : Image.asset('assets/icons/bottom_nav_icon/home.png',
                            height: 16.h),
                    onPressed: () {
                      _navigateToScreen(0);
                    },
                  ),
                  Text(
                    AppStrings.home,
                    style: TextStyle(
                        fontSize: 11.sp,
                        height: -0.5,
                        fontWeight: FontWeight.w500,
                        color: _currentIndex == 0
                            ? palette.appBarTitleColor
                            : palette.selectedTimeChipColor),
                  )
                ],
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: _currentIndex == 1
                        ? Image.asset(
                            'assets/icons/bottom_nav_icon/bar_chart_clicked.png',
                            height: 20.h,
                          )
                        : Image.asset(
                            'assets/icons/bottom_nav_icon/bar_chart.png',
                            height: 14.h,
                          ),
                    onPressed: () {
                      _navigateToScreen(1);
                    },
                  ),
                  Text(AppStrings.markets,
                      style: TextStyle(
                          fontSize: 11.sp,
                          height: -0.5,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 1
                              ? palette.appBarTitleColor
                              : palette.selectedTimeChipColor))
                ],
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: _currentIndex == 2
                        ? Image.asset(
                            'assets/icons/bottom_nav_icon/exchange_clicked.png',
                            height: 14.h,
                          )
                        : Image.asset(
                            'assets/icons/bottom_nav_icon/exchange.png',
                            height: 14.h,
                          ),
                    onPressed: () {
                      _navigateToScreen(2);
                    },
                  ),
                  Text(AppStrings.trades,
                      style: TextStyle(
                          fontSize: 11.sp,
                          height: -0.5,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 2
                              ? palette.appBarTitleColor
                              : palette.selectedTimeChipColor))
                ],
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: _currentIndex == 3
                        ? Image.asset(
                            'assets/icons/bottom_nav_icon/future_clicked.png',
                            height: 14.h,
                          )
                        : Image.asset(
                            'assets/icons/bottom_nav_icon/future.png',
                            height: 14.h,
                          ),
                    onPressed: () {
                      _navigateToScreen(3);
                    },
                  ),
                  Text("Futures",
                      style: TextStyle(
                          fontSize: 11.sp,
                          height: -0.5,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 3
                              ? palette.appBarTitleColor
                              : palette.selectedTimeChipColor))
                ],
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: _currentIndex == 4
                        ? Image.asset(
                            'assets/icons/bottom_nav_icon/wallet_clicked.png',
                            height: 14.h)
                        : Image.asset(
                            'assets/icons/bottom_nav_icon/wallets.png',
                            height: 14.h),
                    onPressed: () {
                      _navigateToScreen(4);
                    },
                  ),
                  Text(AppStrings.wallets,
                      style: TextStyle(
                          fontSize: 11.sp,
                          height: -0.5,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 4
                              ? palette.appBarTitleColor
                              : palette.selectedTimeChipColor))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 3) {
      // Kiểm tra nếu tab hiện tại là tab 'Futures'
      loadCurrentSymbol(); // Tải lại symbol khi chuyển đến tab này
    }
    if (index != 3) {
      _showContainer = false;
    }
  }
}
