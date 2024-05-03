import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';

class MarketActivityHeader extends StatefulWidget {
  final int index;
  const MarketActivityHeader({
    super.key,
    // required this.onTabChanged,
    this.index = 0,
  });

  // final Function(int) onTabChanged;

  @override
  State<MarketActivityHeader> createState() => _MarketActivitySectionState();
}

class _MarketActivitySectionState extends State<MarketActivityHeader> {
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
          CustomTabBar(
            index: _index,
            tabs: const [
              "Danh sách yêu thích",
              "Thị trường",
              "Khám phá",
              "Square",
              "Dữ liệu"
            ],
            onChanged: (value) {
              _setIndex(value);
              // widget.onTabChanged.call(value);
            },
          ),
        ],
      ),
    );
  }
}
