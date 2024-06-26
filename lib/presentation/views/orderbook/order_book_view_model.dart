import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/data/services/socket_service.dart';
import 'package:binance_clone/models/order.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view_model.dart';
// import 'package:binance_clone/utils/app_strings.dart';

final orderBookViewModelProvider = Provider.family<OrderBookViewModel, String>(
  (ref, _pair) => OrderBookViewModel(ref, _pair),
);

class OrderBookViewModel {
  final ProviderRef _ref;
  final String _pair;

  OrderBookViewModel(this._ref, this._pair) {
    _init();
  }

  late final _socketService = SocketService();

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "${_pair.toLowerCase()}@aggTrade",
    ]);
    print("Pair: ${_pair.toLowerCase()}");
    _listenToTradeDetails();
  }

  void _tradeDataListener() {
    final oldPrice = _prices.value.first;
    final newPrice = _ref
        .read(tradeDetailsViewModelProvider(_pair))
        .tradeData
        .value
        .currentPrice;
    _prices.value = [double.tryParse(newPrice) ?? 0, oldPrice];
  }

  void _listenToTradeDetails() {
    _ref
        .read(tradeDetailsViewModelProvider(_pair))
        .tradeData
        .addListener(_tradeDataListener);
    ;
  }

  final ValueNotifier<List<Order>> _orders = ValueNotifier([]);
  ValueNotifier<List<Order>> get orders => _orders;

  final ValueNotifier<List<Order>> _buyOrders = ValueNotifier([]);
  ValueNotifier<List<Order>> get buyOrders => _buyOrders;

  final ValueNotifier<List<Order>> _sellOrders = ValueNotifier([]);
  ValueNotifier<List<Order>> get sellOrders => _sellOrders;

  final ValueNotifier<List<double>> _prices = ValueNotifier([0, 0]);
  ValueNotifier<List<double>> get prices => _prices;

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    if (eventType == "aggTrade") {
      final order = Order.fromJson(data);

      _orders.value = [order, ..._orders.value.take(99)];
      if (order.isBuy == true) {
        _buyOrders.value = [order, ..._buyOrders.value.take(99)];
      } else {
        _sellOrders.value = [order, ..._sellOrders.value.take(99)];
      }
    }
  }

  void dispose() {
    _ref
        .read(tradeDetailsViewModelProvider(_pair))
        .tradeData
        .removeListener(_tradeDataListener);
    _socketService.dispose();
    _prices.dispose();
    _sellOrders.dispose();
    _buyOrders.dispose();
    _orders.dispose();
  }
}
