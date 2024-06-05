import 'package:binance_clone/models/trade_data.dart';
import 'package:binance_clone/presentation/views/home/widgets/item/item_home_container.dart';
import 'package:binance_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../theme/palette.dart';
import '../home_view_models.dart';
import 'app_bar_home.dart';
import 'money_container.dart';

class HomeContainer extends ConsumerStatefulWidget {
  const HomeContainer({super.key});

  @override
  ConsumerState<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends ConsumerState<HomeContainer>
    with SingleTickerProviderStateMixin {
  var indexMarket = 1;
  var indexNewspaper = 0;
  late HomeViewModel homeViewModel;
  bool hasScroll = false;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeViewModel = ref.watch(homeViewModelProvider);

    final palette = Theme.of(context).extension<Palette>()!;
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                backgroundColor: palette.cardColor,
                scrolledUnderElevation: 0,
                title: const AppBarHome(),
              ),
            ],
        body: SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            if (!mounted) return;
            _refreshController.refreshCompleted();
            setState(() {});
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: MoneyContainer(),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: palette.grayColor,
                ),
              ),
              SliverAppBar(
                backgroundColor: palette.cardColor,
                scrolledUnderElevation: 0,
                pinned: false,
                primary: false,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 56.h,
                  title: CustomTabBar(
                    index: indexMarket,
                    tabs: const [
                      "Danh sách yêu thích",
                      "Phổ biến",
                      "Tăng giá",
                      "Giảm giá",
                      "Danh sách niêm yết mới",
                    ],
                    onChanged: (value) {
                      setState(() {
                        indexMarket =
                            value; // Update the index value when tab changes
                      });
                    },
                    enableDecoration: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _itemMarket(palette),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: palette.grayColor,
                ),
              ),
              SliverAppBar(
                backgroundColor: palette.cardColor,
                scrolledUnderElevation: 0,
                pinned: true,
                primary: false,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 56.h,
                  title: CustomTabBar(
                    index: indexNewspaper,
                    tabs: const [
                      "Khám phá",
                      "Đang theo dõi",
                      "Thông báo",
                      "Tin tức",
                      "Academy",
                      "ĐANG PHÁT TRỰC TIẾP",
                    ],
                    onChanged: (value) {
                      setState(() {
                        indexNewspaper =
                            value; // Update the index value when tab changes
                      });
                    },
                    enableDecoration: false,
                  ),
                ),
              ),
              homeViewModel.paper.value.isEmpty
                  ? const SliverFillRemaining(
                      fillOverscroll: true,
                      child: Center(child: Text("Chưa có dữ liệu")),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (context, index) {
                        return Container(
                          color: Colors.red,
                          child: Text("$index"),
                        );
                      },
                      addRepaintBoundaries: false,
                    ))
            ],
          ),
        ));
  }

  Widget _itemMarket(Palette palette) =>
      ValueListenableBuilder<List<TradeData>>(
        valueListenable: homeViewModel.marketData,
        builder: (context, tradeData, child) {
          if (indexMarket == 0) {
            return SizedBox(
              height: 255.h,
              child: const Center(child: Text("Chưa có dữ liệu")),
            );
          }
          if (tradeData.isEmpty) {
            return SizedBox(
              height: 255.h,
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          final data = switch (indexMarket) {
            1 => _convertDataPopular([...tradeData]),
            2 => _convertDataIncrement([...tradeData]),
            3 => _convertDataDecrement([...tradeData]),
            _ => [...tradeData].getRange(0, 5).toList(),
          };

          if (data.isEmpty) {
            return const SizedBox(
              height: 250,
              child: Center(child: Text("Chưa có dữ liệu")),
            );
          }

          return ItemHomeContainer(indexMarket: indexMarket, data: data);
        },
      );

  List<TradeData> _convertDataPopular(List<TradeData> dataCurrent) {
    List<TradeData> popularData = [];
    // lay gia tri cua BNB/USDT
    final bnb =
        dataCurrent.where((element) => element.symbol == "BNBUSDT").firstOrNull;
    if (bnb != null) {
      popularData.add(bnb);
      dataCurrent.removeWhere((element) => element.symbol == "BNBUSDT");
    } else {
      popularData.add(dataCurrent.last.copyWith(symbol: "BNBUSDT"));
      dataCurrent.removeLast();
    }

    // lay gia tri cua BTC/USDT
    final btc =
        dataCurrent.where((element) => element.symbol == "BTCUSDT").firstOrNull;
    if (btc != null) {
      popularData.add(btc);
      dataCurrent.removeWhere((element) => element.symbol == "BTCUSDT");
    } else {
      popularData.add(dataCurrent.last.copyWith(symbol: "BNBUSDT"));
      dataCurrent.removeLast();
    }

    final eth =
        dataCurrent.where((element) => element.symbol == "ETHUSDT").firstOrNull;
    if (eth != null) {
      popularData.add(eth);
      dataCurrent.removeWhere((element) => element.symbol == "ETHUSDT");
    } else {
      popularData.add(dataCurrent.last.copyWith(symbol: "BNBUSDT"));
      dataCurrent.removeLast();
    }

    var i = 2;
    while (i > 0) {
      popularData.add(dataCurrent.last);
      dataCurrent.removeLast();
      i = i - 1;
    }

    return popularData.toList();
  }

  List<TradeData> _convertDataIncrement(List<TradeData> dataCurrent) {
    final dataIncrement = [...dataCurrent];
    dataIncrement.sort(
      (a, b) {
        if (a.highPercentageChangeIn24H < b.highPercentageChangeIn24H) return 1;
        return -1;
      },
    );
    return dataIncrement.getRange(0, 5).toList();
  }

  List<TradeData> _convertDataDecrement(List<TradeData> dataCurrent) {
    final dataIncrement = [...dataCurrent];
    dataIncrement.sort(
      (a, b) {
        if (a.highPercentageChangeIn24H > b.highPercentageChangeIn24H) return 1;
        return -1;
      },
    );
    return dataIncrement.getRange(0, 5).toList();
  }
}
