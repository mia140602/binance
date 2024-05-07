import 'package:binance_clone/utils/app_strings.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/local_data/sharepref.dart';

class BinanceTestnetAPI {
  String apiKey = AppStrings.testApiKey;
  String apiSecret = AppStrings.testSecretKey;
  final String baseUrl = AppStrings.testBaseUrl;

  BinanceTestnetAPI();

  Future<Map<String, dynamic>> getAccountInfo() async {
    String endpoint = '/api/v3/account';
    String url = '$baseUrl$endpoint';
    var headers = _createHeaders();

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load account info');
    }
  }

  Map<String, String> _createHeaders() {
    return {
      'X-MBX-APIKEY': apiKey,
    };
  }

  Future<String> placeOrder(String symbol, double quantity, String side) async {
    final String endpoint = '/fapi/v1/order';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int recvWindow =
        10000; // Tăng recvWindow lên 10000 milliseconds (10 giây)

    // Tạo signature
    final String query =
        'symbol=$symbol&side=$side&type=LIMIT&quantity=$quantity&price=9000&timestamp=$timestamp&recvWindow=$recvWindow';
    final String signature = generateSignature(query);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
      body: {
        'symbol': symbol,
        'side': side.toUpperCase(),
        'type': 'LIMIT',
        // 'timeInForce': 'GTC',
        'quantity': quantity.toString(),
        'price': '9000',
        'timestamp': timestamp.toString(),
        'recvWindow': recvWindow.toString(),
        'signature': signature,
      },
    );

    if (response.statusCode == 200) {
      return 'Order placed: ${response.body}';
    } else {
      return 'Failed to place order: ${response.body}';
    }
  }

  String generateSignature(String query) {
    var key = utf8.encode(apiSecret);
    var bytes = utf8.encode(query);

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }

  Future<List<dynamic>> getPositionInformation() async {
    final String endpoint = '/fapi/v2/positionRisk';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    final String query = 'timestamp=$timestamp';
    final String signature = generateSignature(query);

    final response = await http.get(
      Uri.parse('$url?${query}&signature=$signature'),
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load position information: ${response.body}');
    }
  }

  Future<double> getWalletBalance(String walletName) async {
    List<Map<String, dynamic>> wallets = await SharePref.getAllWallets();
    for (var wallet in wallets) {
      if (wallet['name'] == walletName) {
        return wallet['amount'];
      }
    }
    return 0.0; // Trả về 0 nếu không tìm thấy ví
  }

  Future<String> placeOrderWithWalletBalance(String walletName, String symbol,
      String side, double quantity, double currentPrice) async {
    double walletBalance = await getWalletBalance(walletName);
    return await this.placeOrder(symbol, quantity, side);
    // if (walletBalance >= quantity * currentPrice) {
    //
    // } else {
    //   return "Số dư không đủ.";
    // }
  }

  void updateWalletBalance(String walletName, double newBalance) async {
    await SharePref.updateWallet(walletName, newBalance);
  }
}
