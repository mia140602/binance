import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static String keyWallets = "key_wallets";
  static String keyPositions = "key_positions";

  static Future<void> addPosition(String symbol, String type, double entryPrice,
      double leverage, double margin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> positions = prefs.getStringList(keyPositions) ?? [];

    String newPosition = "$symbol:$type:$entryPrice:$leverage:$margin";
    positions.insert(0, newPosition); // Thêm vào đầu danh sách

    await prefs.setStringList(keyPositions, positions);
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
        wallets.add({"name": parts[0], "amount": double.parse(parts[1])});
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
