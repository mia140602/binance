import 'package:binance_clone/presentation/views/trade_details/trading_view_detail.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/views/futures/futures_screen.dart';
import 'package:binance_clone/presentation/views/home/home_screen.dart';
import 'package:binance_clone/presentation/views/markets/markets_screen.dart';
import 'package:binance_clone/presentation/views/wallets/wallets_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBarr extends StatefulWidget {
  const BottomNavigationBarr({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarr> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<BottomNavigationBarr> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MarketsScreen(),
    TradeViewDetails(),
    const FuturesScreen(),
    const WalletScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        surfaceTintColor: Colors.white,
        elevation: 4,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.home_filled,
                      color:
                          _currentIndex == 0 ? Colors.black : Color(0XFF929ba5),
                      size: 19.h),
                  onPressed: () {
                    _navigateToScreen(0);
                  },
                ),
                Text(
                  "Home",
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
                  icon: Image.asset(
                      'assets/icons/bottom_nav_icon/bar-chart.png',
                      height: 17.h,
                      color: _currentIndex == 1
                          ? Colors.black
                          : Color(0XFFa2A8AF)),
                  onPressed: () {
                    _navigateToScreen(1);
                  },
                ),
                Text("Markets",
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
                  icon: Image.asset('assets/icons/bottom_nav_icon/exchange.png',
                      height: 17.h,
                      color: _currentIndex == 2
                          ? Colors.black
                          : Color(0XFFa2A8AF)),
                  onPressed: () {
                    _navigateToScreen(2);
                  },
                ),
                Text("Trades",
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
                  icon: Image.asset(
                      'assets/icons/bottom_nav_icon/web-feature-service.png',
                      height: 19.h,
                      color: _currentIndex == 3
                          ? Colors.black
                          : Color(0XFFa2A8AF)),
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
                  icon: Image.asset(
                      'assets/icons/bottom_nav_icon/money-bag.png',
                      height: 18.h,
                      color: _currentIndex == 4
                          ? Colors.black
                          : Color(0XFFa2A8AF)),
                  onPressed: () {
                    _navigateToScreen(4);
                  },
                ),
                Text("Wallets",
                    style: TextStyle(
                        fontSize: 11.sp,
                        height: -0.5,
                        fontWeight: FontWeight.w500))
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
