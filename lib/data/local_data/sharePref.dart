import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static String keyWallets = "key_wallets";
  static String keyPositions = "key_positions";
  static String keyWalletPositionsCount = "key_wallet_positions_count";
  static String keyTotalBalance = "key_total_balance";

  static Future<void> updateTotalBalance(double newTotalBalance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyTotalBalance, newTotalBalance);
  }

  static Future<double> getTotalBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(keyTotalBalance) ?? 0.0;
  }

  static Future<void> addPosition(String walletName, String symbol, String type,
      double entryPrice, double leverage, double margin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> positions = prefs.getStringList(keyPositions) ?? [];

    String newPosition = "$symbol:$type:$entryPrice:$leverage:$margin";
    positions.insert(0, newPosition); // Thêm vào đầu danh sách
    await prefs.setStringList(keyPositions, positions);

    // Cập nhật số lượng position trong ví
    Map<String, int> walletPositionsCount = _getWalletPositionsCount(prefs);
    walletPositionsCount[walletName] =
        (walletPositionsCount[walletName] ?? 0) + 1;
    await prefs.setString(
        keyWalletPositionsCount, json.encode(walletPositionsCount));
  }

  static Map<String, int> _getWalletPositionsCount(SharedPreferences prefs) {
    String? jsonString = prefs.getString(keyWalletPositionsCount);
    if (jsonString == null) return {};
    return Map<String, int>.from(json.decode(jsonString));
  }

  static Future<void> deletePosition(String walletName, String symbol,
      String type, double entryPrice, double leverage, double margin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> positions = prefs.getStringList(keyPositions) ?? [];
    String targetPosition = "$symbol:$type:$entryPrice:$leverage:$margin";
    int initialCount = positions.length;

    positions.removeWhere((position) => position == targetPosition);
    await prefs.setStringList(keyPositions, positions);

    // Kiểm tra nếu có position nào được xóa
    if (initialCount > positions.length) {
      // Giảm số lượng position trong ví
      Map<String, int> walletPositionsCount = _getWalletPositionsCount(prefs);
      if (walletPositionsCount.containsKey(walletName) &&
          walletPositionsCount[walletName]! > 0) {
        walletPositionsCount[walletName] =
            walletPositionsCount[walletName]! - 1;
        await prefs.setString(
            keyWalletPositionsCount, json.encode(walletPositionsCount));
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getAllPositions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> positions = [];
    List<String> positionsString = prefs.getStringList(keyPositions) ?? [];

    for (String position in positionsString) {
      List<String> parts = position.split(":");
      positions.add({
        "symbol": parts[0],
        "type": parts[1],
        "entryPrice": double.parse(parts[2]),
        "leverage": double.parse(parts[3]),
        "margin": double.parse(parts[4])
      });
    }
    return positions;
  }

  static Future<void> addWallet(String walletName, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wallets = [];

    var walletsString = prefs.getStringList(keyWallets);
    if (walletsString != null) {
      wallets = walletsString;
    }

    wallets.add("$walletName:$amount");

    await prefs.setStringList(keyWallets, wallets);
  }

 static Future<List<Map<String, dynamic>>> getAllWallets() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> wallets = [];
  var walletsString = prefs.getStringList(keyWallets);
  if (walletsString != null) {
    for (var walletString in walletsString) {
      var parts = walletString.split(":");
      if (parts.length == 2) {
        String name = parts[0];
        double amount = double.tryParse(parts[1]) ?? 0.0;
        wallets.add({"name": name, "amount": amount});
      }
    }
  }
  return wallets;
}

  static Future<void> updateWallet(String walletName, double newAmount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wallets = [];
    var walletsString = prefs.getStringList(keyWallets);
    if (walletsString != null) {
      wallets = walletsString;
    }
    for (int i = 0; i < wallets.length; i++) {
      var parts = wallets[i].split(":");
      if (parts[0] == walletName) {
        wallets[i] = "$walletName:$newAmount";
        break;
      }
    }
    await prefs.setStringList(keyWallets, wallets);
  }

  static Future<void> deleteWallet(String walletName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wallets = [];
    var walletsString = prefs.getStringList(keyWallets);
    if (walletsString != null) {
      wallets = walletsString;
    }

    wallets.removeWhere((wallet) => wallet.split(":")[0] == walletName);

    await prefs.setStringList(keyWallets, wallets);
  }
}
