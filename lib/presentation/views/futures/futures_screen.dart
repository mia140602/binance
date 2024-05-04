import 'package:binance_clone/presentation/views/futures/usd_m_screen.dart';
import 'package:flutter/material.dart';

import 'package:binance_clone/presentation/views/wallets/tabbar_option/overview_screen.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuturesScreen extends StatefulWidget {
  @override
  _FuturesScreenState createState() => _FuturesScreenState();
}

class _FuturesScreenState extends State<FuturesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelStyle: AppStyle.boldText(),
              unselectedLabelColor: Colors.grey[500],
              labelColor: Colors.black,
              indicator: const BoxDecoration(),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Text("USD"),
                      Icon(Icons.monetization_on_outlined,size: 14.h,),
                      Text("-M"),
                    ],
                  ),
                ),
                Tab(
                  text: 'COIN-M',
                ),
                Tab(
                  text: 'Options',
                ),
                Tab(
                  text: 'Bots',
                ),
                Tab(
                  text: 'Copy Trading',
                ),
                Tab(
                  text: 'Leaderboard',
                ),
              ],
              labelPadding: EdgeInsets.only(right: 20.w),
            ),
            Divider(color: Colors.grey[400],),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: USDScreen()),
                  Center(child: Text('Content for Option 2')),
                  Center(child: Text('Content for Option 3')),
                  Center(child: Text('Content for Option 4')),
                  Center(child: Text('Content for Option 5')),
                  Center(child: Text('Content for Option 6')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

