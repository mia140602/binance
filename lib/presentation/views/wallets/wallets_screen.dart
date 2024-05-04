
import 'package:binance_clone/presentation/views/wallets/tabbar_option/earn_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/funding_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/marin/margin_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/overview_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/spot_screen.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with SingleTickerProviderStateMixin {
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
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    border: Border.all(
                      color: Colors.grey.shade300
                    )
                  ),
                  width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.height*0.05,
                child: TextButton(onPressed: (){}, child: Text("Exchange",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 14.sp),))),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: Border.all(
                            color: Colors.grey.shade300
                        )
                    ),
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: TextButton(onPressed: (){}, child: Text("Web3",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Colors.grey),))),
              ],
            ),
            TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelStyle: AppStyle.boldText(),
              unselectedLabelColor: Colors.grey[500],
              labelColor: Colors.black,
              indicator: const BoxDecoration(),
              controller: _tabController,
              tabs: const [
                Tab(text: AppStrings.overview),
                Tab(text: AppStrings.spot),
                Tab(text: AppStrings.funding),
                Tab(text: AppStrings.earn),
                Tab(text: AppStrings.fututes),
                Tab(text: AppStrings.margin),
              ],
              labelPadding: EdgeInsets.only(right: 20.w),
            ),
            Divider(color: Colors.grey[200],),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: OverviewScreen()),
                  Center(child: SpotScreen()),
                  Center(child: FundingScreen()),
                  Center(child: EarnScreen()),
                  Center(child: Text('Content for Option 5')),
                  Center(child: MarginScreen()),
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
