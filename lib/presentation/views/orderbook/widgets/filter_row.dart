import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/theme/palette.dart';

class FilterRow extends StatefulWidget {
  final Function(int) onChanged;

  const FilterRow({super.key, required this.onChanged});

  @override
  State<FilterRow> createState() => FilterRowState();
}

class FilterRowState extends State<FilterRow> {
  int _index = 0;

  void _setIndex() {
    setState(() {
      _index = (_index + 1) % 3; // Chuyển đổi giữa 0, 1, 2
    });
    widget.onChanged(_index);
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    List<Widget> filters = [
      _Filter(
        key: const ValueKey("BuysAndSells"),
        topColor: palette.sellButtonColor,
        bottomColor: palette.buyButtonColor,
        onPressed: _setIndex,
        selected: _index == 0,
        rightColumn: [
          _LineRight(color: palette.sellButtonColor),
          _LineRight(color: palette.buyButtonColor),
        ],
      ),
      _Filter(
        key: const ValueKey("BuysOnly"),
        bottomColor: palette.buyButtonColor,
        onPressed: _setIndex,
        selected: _index == 1,
        rightColumn: [_Right(color: palette.buyButtonColor)],
      ),
      _Filter(
        key: const ValueKey("SellsOnly"),
        topColor: palette.sellButtonColor,
        onPressed: _setIndex,
        selected: _index == 2,
        rightColumn: [_Right(color: palette.sellButtonColor)],
      ),
    ];

    return GestureDetector(
      onTap: _setIndex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
        child: filters[_index], // Chỉ hiển thị _Filter hiện tại
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? topColor;
  final Color? bottomColor;
  final bool selected;
  final List<Widget>? rightColumn;

  const _Filter({
    super.key,
    required this.onPressed,
    this.selected = false,
    this.topColor,
    this.bottomColor,
    this.rightColumn,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LineLeft(color: palette.filterLineColor),
              _LineLeft(color: palette.filterLineColor),
              _LineLeft(color: palette.filterLineColor),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rightColumn ?? [],
          )
        ],
      ),
    );
  }
}

class _LineLeft extends StatelessWidget {
  final Color color;
  
  const _LineLeft({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1.5, right: 1),
      height: 3,
      width: 6,
      decoration: BoxDecoration(
        color: color,
        // borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _Right extends StatelessWidget {
  final Color color;
  const _Right({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 2),
      height: 13,
      width: 6,
      decoration: BoxDecoration(
        color: color,
        // borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _LineRight extends StatelessWidget {
  final Color color;
  const _LineRight({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1.5),
      height: 5,
      width: 6,
      decoration: BoxDecoration(
        color: color,
        // borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
