import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/data/services/socket_service.dart';
import 'package:binance_clone/models/trade_data.dart';

final marketViewModelProvider = Provider<MarketViewModel>(
  (ref) => MarketViewModel(),
);

class MarketViewModel {
  MarketViewModel() {
    _init();
  }

  late final _socketService = SocketService();
  final ValueNotifier<List<TradeData>> _marketData = ValueNotifier([]);

  void _init() {
    _socketService.attachListListener(_onData);
    _socketService.subscribe([
      "!miniTicker@arr",
    ]);
    
    if (kDebugMode) {
      print("WebSocket subscribed to !miniTicker@arr");
    }
  }

  void _onData(dynamic data) {
    // print("Data received: $data"); // Log the data received
    final List<dynamic> tickers = data as List<dynamic>;
    List<TradeData> updatedMarketData = tickers.map((ticker) {
      return TradeData.fromJson(ticker as Map<String, dynamic>);
    }).toList();

    _marketData.value = updatedMarketData;
    // print("Updated market data: $updatedMarketData"); // Log the updated data
  }

  ValueNotifier<List<TradeData>> get marketData => _marketData;

  void dispose() {
    _socketService.dispose();
    _marketData.dispose();
    
    if (kDebugMode) {
      print("Disposed MarketViewModel");
    }
  }
}
