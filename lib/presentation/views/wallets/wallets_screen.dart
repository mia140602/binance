import 'package:binance_clone/presentation/views/wallets/tabbar_option/earn_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/funding_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/margin_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/overview_screen.dart';
import 'package:binance_clone/presentation/views/wallets/tabbar_option/spot_screen.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/palette.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Scaffold(
      backgroundColor: palette.cardColor,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.045,
              decoration: BoxDecoration(
                  color: palette.selectedTimeChipColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: palette.selectedTabChipColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        // border: Border.all(color: Colors.grey.shade300)),),
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.045,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: palette.cardColor),
                        child: TextButton(
                            onPressed: () {},
                            child: CustomText(
                                text: "Sàn giao dịch",
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp)),
                      )),
                  Container(
                      decoration: BoxDecoration(
                        color: palette.selectedTabChipColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        // border: Border.all(color: Colors.grey.shade300)
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextButton(
                          onPressed: () {},
                          child: CustomText(
                              text: "Web3",
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: palette.selectedTimeChipColor))),
                ],
              ),
            ),
            TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelStyle: AppStyle.appBarText(),
              unselectedLabelColor: palette.selectedTimeChipColor,
              labelColor: palette.appBarTitleColor,
              indicator: const BoxDecoration(),
              controller: _tabController,
              dividerColor: palette.selectedTimeChipColor,
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
