import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/data/services/socket_service.dart';
import 'package:binance_clone/models/trade_data.dart';

final homeViewModelProvider = Provider<HomeViewModel>(
  (ref) => HomeViewModel(),
);

class HomeViewModel {
  HomeViewModel() {
    _init();
  }

  final _socketService = SocketService();
  final ValueNotifier<List<TradeData>> _marketData = ValueNotifier([]);
  final ValueNotifier<List<TradeData>> _paper = ValueNotifier([]);

  void _init() {
    _socketService.attachListListener(_onData);
    _socketService.subscribe([
      "!ticker@arr",
    ]);
    print("WebSocket subscribed to !miniTicker@arr");
  }

  void _onData(dynamic data) {
    final List<dynamic> tickers = data as List<dynamic>;
    List<TradeData> updatedMarketData = tickers.map((ticker) {
      return TradeData.fromJson(ticker as Map<String, dynamic>);
    }).toList();

    _marketData.value = updatedMarketData;
    // print("Updated market data: $updatedMarketData"); // Log the updated data
  }

  ValueNotifier<List<TradeData>> get marketData => _marketData;
  ValueNotifier<List<TradeData>> get paper => _paper;

  void dispose() {
    _socketService.dispose();
    _marketData.dispose();
    print("Disposed MarketViewModel");
  }
}
