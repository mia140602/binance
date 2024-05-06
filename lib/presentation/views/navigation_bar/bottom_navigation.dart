import 'package:binance_clone/presentation/views/markets/markets.dart';
import 'package:binance_clone/presentation/views/trade_details/trading_view_detail.dart';
import 'package:binance_clone/presentation/views/transaction_screen/transaction_screen.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/views/futures/futures_screen.dart';
import 'package:binance_clone/presentation/views/home/home_screen.dart';
import 'package:binance_clone/presentation/views/markets/markets_screen.dart';
import 'package:binance_clone/presentation/views/wallets/wallets_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/palette.dart';
import '../orderbook/order_book_view.dart';

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
      backgroundColor: palette.cardColor,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: palette.cardColor,
        padding: EdgeInsets.all(0),
        surfaceTintColor: palette.cardColor,
        elevation: 4,
        shape: const CircularNotchedRectangle(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 1.h,
              color: Colors.white12,
            ),
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
                              height: 20.h)
                          : Image.asset('assets/icons/bottom_nav_icon/home.png',
                              height: 20.h),
                      onPressed: () {
                        _navigateToScreen(0);
                      },
                    ),
                    Text(
                      AppStrings.home,
                      style: TextStyle(
                          fontSize: 11.sp,
                          height: -0.5,
                          fontWeight: FontWeight.w500),
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
                              height: 23.h,
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
                            fontWeight: FontWeight.w500))
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: _currentIndex == 2
                          ? Image.asset(
                              'assets/icons/bottom_nav_icon/exchange_clicked.png',
                              height: 17.h,
                            )
                          : Image.asset(
                              'assets/icons/bottom_nav_icon/exchange.png',
                              height: 17.h,
                            ),
                      onPressed: () {
                        _navigateToScreen(2);
                      },
                    ),
                    Text(AppStrings.trades,
                        style: TextStyle(
                            fontSize: 11.sp,
                            height: -0.5,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: _currentIndex == 3
                          ? Image.asset(
                              'assets/icons/bottom_nav_icon/future_clicked.png',
                              height: 16.h,
                            )
                          : Image.asset(
                              'assets/icons/bottom_nav_icon/future.png',
                              height: 16.h,
                            ),
                      onPressed: () {
                        _navigateToScreen(3);
                      },
                    ),
                    Text("Futures",
                        style: TextStyle(
                            fontSize: 11.sp,
                            height: -0.5,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: _currentIndex == 4
                          ? Image.asset(
                              'assets/icons/bottom_nav_icon/wallet_clicked.png',
                              height: 16.h)
                          : Image.asset(
                              'assets/icons/bottom_nav_icon/wallets.png',
                              height: 16.h),
                      onPressed: () {
                        _navigateToScreen(4);
                      },
                    ),
                    Text(AppStrings.wallets,
                        style: TextStyle(
                            fontSize: 11.sp,
                            height: -0.5,
                            fontWeight: FontWeight.w500))
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
