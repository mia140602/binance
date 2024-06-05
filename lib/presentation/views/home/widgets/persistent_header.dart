import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final palette = Theme.of(context).extension<Palette>()!;
    double _animationValue = 1.0;
    final scale = 1 - shrinkOffset / maxExtent;
    final isReduced = shrinkOffset >= maxExtent * 0.12;
    return Opacity(
      opacity: scale,
      child: Container(
        color: palette.cardColor,
        child: Opacity(
          opacity: _animationValue,
          child: Transform.scale(
            alignment: Alignment.centerLeft,
            scale: _animationValue,
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
