import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view.dart';
import 'package:binance_clone/presentation/views/chart/charts_view.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view_model.dart';
import 'package:binance_clone/presentation/views/trade_details/recent_trades_view.dart';
import 'package:binance_clone/presentation/views/trade_details/widgets/coin_pair_header.dart';
import 'package:binance_clone/presentation/views/trade_details/widgets/trading_activity_header.dart';

class TradeViewDetails extends StatefulWidget {
  TradeViewDetails({super.key, required this.symbol});
  String symbol;

  @override
  State<TradeViewDetails> createState() => _TradeViewDetailsState();
}

class _TradeViewDetailsState extends State<TradeViewDetails> {
  final ScrollController _controller = ScrollController();
  bool _showCurrentPrice = false;
  int _tabIndex = 0;

  void _setTabIndex(int value) {
    if (_tabIndex != value) {
      setState(() {
        _tabIndex = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    // Future.microtask(() =>
    //     ProviderScope.containerOf(context).read(orderBookViewModelProvider));
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showCurrentPrice =
          _controller.offset > 0; // Hiển thị khi cuộn trang xuống
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Scaffold(
      backgroundColor: palette.cardColor,
      appBar: AppBar(
        backgroundColor: palette.cardColor,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20.w,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoinPairHeader(
              showCurrentPrice: _showCurrentPrice,
              symbol: widget.symbol,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: TradingActivityHeader(
              index: _tabIndex, onTabChanged: _setTabIndex),
        ),
      ),
      body: SizedBox.expand(
        child: ListView(
          controller: _controller,
          children: [
            // const CoinPairHeader(),
            // TradingActivityHeader(index: _tabIndex, onTabChanged: _setTabIndex),
            _ActivityView(
              activeIndex: _tabIndex,
              symbol: widget.symbol,
            ),
            const Gap(4),
            // const UserTradingActivitySection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(palette),
    );
  }

  BottomAppBar _buildBottomAppBar(Palette palette) {
    return BottomAppBar(
      height: 50.h,
      color: palette.cardColor,
      padding: EdgeInsets.zero,
      surfaceTintColor: palette.cardColor,
      elevation: 4,
      // shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 40.w) / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomIcon(
                      palette: palette, image: "more", text: "Xem th..."),
                  _bottomIcon(
                      palette: palette,
                      image: "warning",
                      text: "Cảnh b...",
                      width: 13.w),
                  _bottomIcon(palette: palette, image: "luoi", text: "Lưới"),
                ],
              ),
            ),
            Gap(10),
            Container(
              width: (MediaQuery.of(context).size.width - 40.w) / 3,
              padding: EdgeInsets.symmetric(
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: palette.mainGreenColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomText(
                text: "Mua",
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(10),
            Container(
              width: (MediaQuery.of(context).size.width - 40.w) / 3,
              padding: EdgeInsets.symmetric(
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: palette.sellButtonColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomText(
                text: "Bán",
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _bottomIcon(
      {required Palette palette,
      required String image,
      required String text,
      double? width}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/futures_icon/${image}.png",
          width: width ?? 14.w,
        ),
        Gap(2.h),
        CustomText(
          text: text,
          color: palette.appBarTitleColor,
          fontSize: 10.sp,
        )
      ],
    );
  }
}

class _ActivityView extends StatelessWidget {
  final int activeIndex;
  final String symbol;
  const _ActivityView(
      {super.key, required this.activeIndex, required this.symbol});

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (activeIndex == 0)
      child = ChartsView(
        symbol: symbol,
      );
    if (activeIndex == 1)
      child = OrderBookView(
        pair: symbol,
      );
    if (activeIndex == 2) child = const RecentTradesView();
    if (child == null) return const SizedBox();
    return Container(
      color: Theme.of(context).extension<Palette>()!.cardColor,
      child: child,
    );
  }
}
