import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    if (activeIndex == 1) child = const OrderBookView();
    if (activeIndex == 2) child = const RecentTradesView();
    if (child == null) return const SizedBox();
    return Container(
      color: Theme.of(context).extension<Palette>()!.cardColor,
      child: child,
    );
  }
}
