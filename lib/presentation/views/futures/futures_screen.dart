import 'package:binance_clone/presentation/views/futures/usd_m_screen.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/palette.dart';

class FuturesScreen extends StatefulWidget {
  @override
  _FuturesScreenState createState() => _FuturesScreenState();
}

class _FuturesScreenState extends State<FuturesScreen>
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
      backgroundColor: Color(0xFF1F2630),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 22.h),
        child: Column(
          children: [
            TabBar(
              dividerColor: palette.selectedTimeChipColor.withOpacity(0.5),
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelStyle: AppStyle.boldText(),
              unselectedLabelColor: Colors.grey[500],
              labelColor: palette.appBarTitleColor,
              indicator: const BoxDecoration(),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      const CustomText(
                        text: "USD",
                        fontSize: 15,
                        // color: palette.appBarTitleColor,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.monetization_on_outlined,
                        size: 14.h,
                        // color: palette.appBarTitleColor,
                      ),
                      const CustomText(
                        text: "-M",
                        // color: palette.appBarTitleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                const Tab(
                  icon: CustomText(
                    text: "COIN-M",
                    // color: palette.appBarTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Tab(
                  icon: CustomText(
                    text: "Quyền chọn",
                    // color: palette.appBarTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Tab(
                  icon: CustomText(
                    text: "Bot",
                    // color: palette.appBarTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Tab(
                  icon: CustomText(
                    text: "Sao chép giao dịch",
                    // color: palette.appBarTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Tab(
                  icon: CustomText(
                    text: "Bảng xếp hạng",
                    // color: palette.appBarTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              labelPadding: EdgeInsets.only(right: 20.w),
            ),
            // Divider(
            //   color: Colors.grey[700],
            // ),
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
