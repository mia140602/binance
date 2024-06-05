import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/palette.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          _icon(palette),
          _padding,
          _searchBar(palette),
          _padding,
          Image.asset(
            'assets/icons/scan.png',
            height: 16.h,
            color: Colors.white,
          ),
          _padding,
          Image.asset(
            'assets/icons/headphone.png',
            height: 16.h,
            color: Colors.white,
          ),
          _padding,
          Image.asset(
            'assets/icons/bell-ring.png',
            height: 16.h,
            color: Colors.white,
          ),
          _padding,
          Image.asset(
            'assets/icons/wallet_icon/pool.png',
            height: 16.h,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget get _padding => SizedBox(
        width: 16.w,
      );

  Widget _icon(Palette palette) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 24.h,
            height: 24.h,
            decoration: BoxDecoration(
                color: palette.mainYellowColor,
                borderRadius: BorderRadius.circular(8)),
          ),
          Positioned(
            child: Image.asset(
              'assets/icons/ic_binance.png',
              height: 16.h,
              color: palette.bgColor,
            ),
          ),
        ],
      );

  Widget _searchBar(Palette palette) => Flexible(
          child: Container(
        decoration: BoxDecoration(
          color: palette.grayButton,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'NON',
                prefixIcon: Icon(Icons.search))),
      ));
}
