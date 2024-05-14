import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../utils/app_strings.dart';
import '../../../utils/app_style.dart';
import '../../theme/palette.dart';
import '../../widgets/custom_text.dart';
import 'tabbar_option/earn_screen.dart';
import 'tabbar_option/funding_screen.dart';
import 'tabbar_option/margin_screen.dart';
import 'tabbar_option/overview_screen.dart';
import 'tabbar_option/spot_screen.dart';

class WalletsView extends StatefulWidget {
  const WalletsView({
    super.key,
  });

  @override
  State<WalletsView> createState() => _WalletsViewState();
}

class _WalletsViewState extends State<WalletsView>
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
      appBar: AppBar(
        backgroundColor: palette.cardColor,
        title: Row(
          children: [
            Gap(50.w),
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
                                fontSize: 12.sp)),
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
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: palette.selectedTimeChipColor))),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: TabBar(
            isScrollable: true,
            padding: EdgeInsets.zero,
            labelStyle: AppStyle.appBarText(),
            unselectedLabelColor: palette.selectedTimeChipColor,
            labelColor: palette.appBarTitleColor,
            indicator: const BoxDecoration(),
            controller: _tabController,
            dividerColor: palette.selectedTimeChipColor.withOpacity(0.4),
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
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewScreen(),
          SpotScreen(),
          FundingScreen(),
          EarnScreen(),
          Text('Content for Option 5'),
          MarginScreen(),
        ],
      ),
    );
  }
}
