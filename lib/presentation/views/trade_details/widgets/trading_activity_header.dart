import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';

class TradingActivityHeader extends StatefulWidget {
  final int index;
  const TradingActivityHeader({
    super.key,
    required this.onTabChanged,
    this.index = 0,
  });

  final Function(int) onTabChanged;

  @override
  State<TradingActivityHeader> createState() => _TradingActivitySectionState();
}

class _TradingActivitySectionState extends State<TradingActivityHeader> {
  late int _index = widget.index;

  void _setIndex(int value) {
    if (_index != value) {
      setState(() {
        _index = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: palette.cardColor,
      child: Column(
        children: [
          const Gap(8),
          CustomTabBar(
            index: _index,
            tabs: const [
              "Charts",
              "Orderbook",
              "Recent trades",
            ],
            onChanged: (value) {
              _setIndex(value);
              widget.onTabChanged.call(value);
            },
          ),
        ],
      ),
    );
  }
}
