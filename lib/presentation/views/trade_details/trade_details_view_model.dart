import 'package:binance_clone/data/local_data/share_pref.dart';
import 'package:flutter/foundation.dart';
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
  final ValueNotifier<double> totalBalanceNotifier = ValueNotifier(0.0);
  static const String _symbol = AppStrings.symbol;
  late final String _pair;
  TradeDetailsViewModel(String pair) {
    _pair = pair.toLowerCase();
    _init();
    _updateTotalBalance();
  }

  void _init() {
    _socketService.attachListener(_onData);
    _socketService.subscribe([
      "$_pair@miniTicker",
    ]);
    
    if (kDebugMode) {
      print("check:$_pair@miniTicker ");
    }
  }

  void _updateTotalBalance() async {
    double totalWalletBalance = await calculateTotalWalletBalance();
    double totalPNL = await calculateTotalPNL();
    totalBalanceNotifier.value = totalWalletBalance + totalPNL;
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
      _updateTotalBalance();
    }
  }
  // ValueNotifier<double> totalBalance = ValueNotifier(0.0);

  Future<void> updateTotalBalance() async {
    double totalWalletBalance = await calculateTotalWalletBalance();
    double totalPNL = await calculateTotalPNL();
    await SharePref.updateTotalBalance(totalWalletBalance + totalPNL);
  }

  Future<double> calculateTotalWalletBalance() async {
    List<Map<String, dynamic>> wallets = await SharePref.getAllWallets();
    return wallets.fold<double>(0.0, (double sum, Map<String, dynamic> wallet) {
      return sum + (wallet['amount'] as double);
    });
  }

Future<double> calculateTotalPNL() async {
  List<Map<String, dynamic>> positions = await SharePref.getAllPositions();
  double totalPNL = 0.0;
  // Sử dụng tryParse và xử lý trường hợp null
  double? currentPrice = double.tryParse(_tradeData.value.currentPrice);

  if (currentPrice == null) {

    if (kDebugMode) {
      print("Invalid current price data: ${_tradeData.value.currentPrice}");
    }
    
    return 0.0;  // Trả về 0 hoặc xử lý phù hợp nếu giá trị không hợp lệ
  }

  for (var position in positions) {
    totalPNL += calculatePNLForPosition(position, currentPrice);
  }
  return totalPNL;
}

  double calculatePNLForPosition(
      Map<String, dynamic> position, double currentPrice) {
    double entryPrice = position['entryPrice'];
    String type = position['type'];
    double pnlValue;
    if (type == "Long") {
      pnlValue = 0.075 * (currentPrice - entryPrice);
    } else if (type == "Short") {
      pnlValue = -0.075 * (currentPrice - entryPrice);
    } else {
      pnlValue = 0.0;
    }
    return pnlValue;
  }

  void dispose() {
    _socketService.dispose();
  }
}
