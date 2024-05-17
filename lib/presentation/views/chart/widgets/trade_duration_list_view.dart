import 'package:binance_clone/presentation/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_clone/presentation/views/chart/charts_view_model.dart';

import '../../../theme/palette.dart';

class TradeDurationListView extends StatefulWidget {
  const TradeDurationListView({super.key});

  @override
  State<TradeDurationListView> createState() => _TradeDurationListViewState();
}

class _TradeDurationListViewState extends State<TradeDurationListView> {
  String? _selectedLabel;

  void _setSelectedLabel(String value) {
    if (_selectedLabel != value) {
      ProviderScope.containerOf(context)
          .read(chartsViewModelProvider)
          .updateInterval(value);
      setState(() {
        _selectedLabel = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        _selectedLabel = ProviderScope.containerOf(context)
            .read(chartsViewModelProvider)
            .currentKlineInterval
            .toUpperCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 0.5.h,
                  color: palette.selectedTimeChipColor.withOpacity(0.5)))),
      child: Row(
        children: [
          Expanded(
            child: TabBarSelect(
              tabs: const [
                "Thời gian",
                "15m",
                "1h",
                "4h",
                "1ngày",
                "Xem thêm",
                "Độ sâu"
              ],
              index: 4,
              selectedTabBorderColor: palette.appBarTitleColor,
            ),
          ),
          GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        width: 0.5.h,
                        color: palette.selectedTimeChipColor.withOpacity(0.5)),
                  ),
                ),
                padding: EdgeInsets.only(left: 10.w),
                child: Image.asset(
                  "assets/icons/futures_icon/settime.png",
                  width: 14.w,
                ),
              ))
        ],
      ),
    );
  }
}
