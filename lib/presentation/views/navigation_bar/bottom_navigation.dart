import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/views/futures/futures_screen.dart';
import 'package:binance_clone/presentation/views/home/home_screen.dart';
import 'package:binance_clone/presentation/views/markets/markets_screen.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view.dart';
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
    const TradeDetailsView(),
    FuturesScreen(),
    WalletScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
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
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.home_filled, color: _currentIndex == 0 ? AppStyle.select : AppStyle.unselect, size: 19.h),
                  onPressed: () {
                    _navigateToScreen(0);
                  },
                ),
                Text(AppStrings.home, style: AppStyle.navText())
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Image.asset(NavAssets.marketIcons, height: 17.h, color: _currentIndex == 1 ? AppStyle.select : AppStyle.unselect),
                  onPressed: () {
                    _navigateToScreen(1);
                  },
                ),
                Text(AppStrings.markets, style: AppStyle.navText())
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Image.asset(NavAssets.tradesIcons, height: 17.h, color: _currentIndex == 2 ? AppStyle.select : AppStyle.unselect),
                  onPressed: () {
                    _navigateToScreen(2);
                  },
                ),
                Text(AppStrings.trades,style: AppStyle.navText())
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Image.asset(NavAssets.futuresIcons, height: 19.h, color: _currentIndex == 3 ?  AppStyle.select : AppStyle.unselect),
                  onPressed: () {
                    _navigateToScreen(3);
                  },
                ),
                Text(AppStrings.fututes,style: AppStyle.navText())
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Image.asset(NavAssets.wallets, height: 18.h, color: _currentIndex == 4 ?  AppStyle.select : AppStyle.unselect),
                  onPressed: () {
                    _navigateToScreen(4);
                  },
                ),
                Text(AppStrings.wallets,style: AppStyle.navText())
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
