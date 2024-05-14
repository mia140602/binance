import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/views/chart/charts_view_model.dart';
import 'package:binance_clone/presentation/widgets/custom_chip.dart';
import 'package:binance_clone/presentation/widgets/custom_icon.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';

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
    return Consumer(builder: (context, ref, _) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CustomText(
            text: "Thời gian",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Gap(2),
          for (final label in ref.read(chartsViewModelProvider).intervals)
            CustomChip(
              label: label,
              selected: label == _selectedLabel,
              onPressed: _setSelectedLabel,
            ),
          const Gap(2),
          Row(
            children: [
              Text(
                "2h",
                style: TextStyle(
                    fontSize: 11.sp,
                    color: palette.appBarTitleColor,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
              ),
            ],
          ),
          const Gap(2),
          const Gap(4),
          CustomText(
            text: "Độ sâu",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      );
    });
  }
}
