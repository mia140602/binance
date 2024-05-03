// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:binance_clone/presentation/theme/palette.dart';
// import 'package:binance_clone/presentation/views/orderbook/order_book_view.dart';
// import 'package:binance_clone/presentation/views/chart/charts_view.dart';
// import 'package:binance_clone/presentation/views/orderbook/order_book_view_model.dart';
// import 'package:binance_clone/presentation/views/trade_details/recent_trades_view.dart';
// import 'package:binance_clone/presentation/views/trade_details/widgets/app_bar.dart';
// import 'package:binance_clone/presentation/views/trade_details/widgets/coin_pair_header.dart';
// import 'package:binance_clone/presentation/views/trade_details/widgets/trading_activity_header.dart';
// import 'package:binance_clone/presentation/views/trade_details/widgets/user_trading_activity_section.dart';

// class TradeDetailsView extends StatefulWidget {
//   const TradeDetailsView({super.key});

//   @override
//   State<TradeDetailsView> createState() => _TradeDetailsViewState();
// }

// class _TradeDetailsViewState extends State<TradeDetailsView> {
//   int _tabIndex = 0;

//   void _setTabIndex(int value) {
//     if (_tabIndex != value) {
//       setState(() {
//         _tabIndex = value;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() =>
//         ProviderScope.containerOf(context).read(orderBookViewModelProvider));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final palette = Theme.of(context).extension<Palette>()!;

//     return Scaffold(
//       appBar: CustomAppBar(
//         color: palette.cardColor,
//         logoPath: palette.logo,
//       ),
//       body: SizedBox.expand(
//         child: ListView(
//           children: [
//             const Gap(8),
//             CoinPairHeader(),
//             const Gap(12),
//             TradingActivityHeader(index: _tabIndex, onTabChanged: _setTabIndex),
//             _ActivityView(activeIndex: _tabIndex),
//             const Gap(4),
//             const UserTradingActivitySection(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ActivityView extends StatelessWidget {
//   final int activeIndex;
//   const _ActivityView({
//     super.key,
//     required this.activeIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Widget? child;
//     if (activeIndex == 0) child = const ChartsView();
//     if (activeIndex == 1) child = const OrderBookView();
//     if (activeIndex == 2) child = const RecentTradesView();
//     if (child == null) return const SizedBox();
//     return Container(
//       color: Theme.of(context).extension<Palette>()!.cardColor,
//       child: child,
//     );
//   }
// }
