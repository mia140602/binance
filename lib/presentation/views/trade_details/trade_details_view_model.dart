import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/data/services/socket_service.dart';
import 'package:binance_clone/models/trade_data.dart';
import 'package:binance_clone/utils/app_strings.dart';

final tradeDetailsViewModelProvider =
    Provider.family<TradeDetailsViewModel, String>(
  (ref, pair) => TradeDetailsViewModel(pair),
);

class TradeDetailsViewModel {
  late final _socketService = SocketService();
  static const String _symbol = AppStrings.symbol;
  late final String _pair;
  TradeDetailsViewModel(String pair) {
    _pair = pair.toLowerCase();
    _init();
  }

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "$_pair@miniTicker",
    ]);
    print("check:$_pair@miniTicker ");
  }

  void updateData(String symbol) {
    if (_pair != symbol.toLowerCase()) {
      _pair = symbol.toLowerCase();
      _socketService.dispose(); // Hủy kết nối WebSocket hiện tại
      _init(); // Khởi tạo lại kết nối WebSocket với symbol mới
    }
  }

  final ValueNotifier<TradeData> _tradeData =
      ValueNotifier(TradeData.initial(_symbol));
  ValueNotifier<TradeData> get tradeData => _tradeData;

  void _onData(Map<String, dynamic> data) {
    final eventType = (data["e"] as String?) ?? "";

    if (eventType == "24hrMiniTicker") {
      data["symbol"] = _symbol;
      final newTradeData = TradeData.fromJson(data);
      _tradeData.value = newTradeData;
    }
  }

  void dispose() {
    _socketService.dispose();
  }
}
