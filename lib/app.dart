import 'package:binance_clone/presentation/theme/dark_palette.dart';
import 'package:binance_clone/presentation/views/navigation_bar/bottom_navigation.dart';
import 'package:flutter/material.dart';
// import 'package:binance_clone/presentation/theme/light_palette.dart';
import 'package:binance_clone/presentation/theme/palette.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        return RefreshConfiguration(
          headerBuilder: () => ClassicHeader(
            failedText: "",
            refreshingText: "",
            releaseText: "",
            idleText: "",
            completeText: "",
            completeIcon: Container(),
            releaseIcon: Column(
              children: [
                Image.asset(
                  "assets/icons/ic_binance.png",
                  height: 16.h,
                ),
                const Text("Loading...")
              ],
            ),
            idleIcon: Column(
              children: [
                Image.asset(
                  "assets/icons/ic_binance.png",
                  height: 16.h,
                ),
                const Text("Loading...")
              ],
            ),
            refreshingIcon: Column(
              children: [
                Image.asset(
                  "assets/icons/ic_binance.png",
                  height: 16.h,
                ),
                const Text("Loading...")
              ],
            ),
            completeDuration: Duration.zero,
          ), // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
          footerBuilder: () =>
              ClassicFooter(), // Configure default bottom indicator
          headerTriggerDistance:
              80.0, // header trigger refresh trigger distance
          // custom spring back animate,the props meaning see the flutter api
          maxOverScrollExtent:
              100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
          maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
          enableScrollWhenRefreshCompleted:
              true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
          enableLoadingWhenFailed:
              true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
          hideFooterWhenNotFull:
              false, // Disable pull-up to load more functionality when Viewport is less than one screen
          enableBallisticLoad: true,
          enableLoadMoreVibrate: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Binance',
            theme: ThemeData(
              extensions: const <ThemeExtension<Palette>>{DarkPalette()},
              primarySwatch: Colors.grey,
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xff1C2127),
                selectionColor: Colors.red,
              ),
              scaffoldBackgroundColor: const Color(0xfff8f8f9),
              colorScheme: ColorScheme.dark(
                primary: Color(0xffFFFFFF).withOpacity(0.8),
                secondary: Color(0xff737A91),
                background: Color(0xfff8f8f9),
              ),
              fontFamily: "Satoshi",
            ),
            home: BottomNavigationBarr(),
          ),
        );
      },
    );
  }
}
