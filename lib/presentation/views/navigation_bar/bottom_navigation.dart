import 'package:binance_clone/presentation/views/transaction_screen/transaction_screen.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/views/futures/futures_screen.dart';
import 'package:binance_clone/presentation/views/home/home_screen.dart';
import 'package:binance_clone/presentation/views/markets/markets_screen.dart';
import 'package:binance_clone/presentation/views/wallets/wallets_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/palette.dart';

class BottomNavigationBarr extends StatefulWidget {
  const BottomNavigationBarr({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarr> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<BottomNavigationBarr> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MarketView(),
    TransactionScreen(),
    // OrderBookView(),
    FuturesScreen(),
    WalletScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      backgroundColor: Color(0xFF1F2630),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1F2630),
        padding: EdgeInsets.all(0),
        surfaceTintColor: palette.cardColor,
        elevation: 4,
        shape: const CircularNotchedRectangle(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
      ),
      body: _screens[_currentIndex],
    );
  }

  void _navigateToScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }
}
