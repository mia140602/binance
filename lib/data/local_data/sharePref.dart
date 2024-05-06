import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static String keyWallets = "key_wallets";

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
