import 'package:binance_clone/presentation/views/navigation_bar/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/theme/dark_palette.dart';
import 'package:binance_clone/presentation/theme/light_palette.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/theme/theme_mode_selector.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SissyphusApp extends StatelessWidget {
  const SissyphusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Binance',
          theme: ThemeData(
            extensions: const <ThemeExtension<Palette>>{LightPalette()},
            primarySwatch: Colors.grey,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xff1C2127),
              selectionColor: Colors.red,
            ),
            scaffoldBackgroundColor: const Color(0xfff8f8f9),
            colorScheme: const ColorScheme.light(
              primary: Color(0xff1C2127),
              secondary: Color(0xff737A91),
              background: Color(0xfff8f8f9),
            ),
            fontFamily: "Satoshi",
          ),
          home: BottomNavigationBarr(),
        );
      },
    );
  }
}
