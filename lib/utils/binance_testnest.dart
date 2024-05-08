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

  Future<String> placeOrder(
      String symbol, double quantity, String side, double price) async {
    final String endpoint = '/fapi/v1/order';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch -
        1000; // Trừ đi 1000 milliseconds

    final String query =
        'symbol=$symbol&side=$side&type=LIMIT&timeInForce=GTC&quantity=$quantity&price=$price&timestamp=$timestamp';
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
        'timeInForce': 'GTC',
        'quantity': quantity.toString(),
        'price': price.toString(),
        'timestamp': timestamp.toString(),
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
      String side, double price, double percentageOfBalance) async {
    double walletBalance = await getWalletBalance(walletName);
    double quantity =
        (walletBalance * percentageOfBalance) / price; // Tính toán số lượng

    // Giới hạn số lượng tối đa cho phép (ví dụ: 1000)
    double maxQuantity = 1000; // Giá trị này nên được lấy từ API hoặc cấu hình

    // Kiểm tra và điều chỉnh số lượng nếu cần
    if (quantity > maxQuantity) {
      quantity = maxQuantity;
    }

    return await placeOrder(symbol, quantity, side, price);
  }

  void updateWalletBalance(String walletName, double newBalance) async {
    await SharePref.updateWallet(walletName, newBalance);
  }

  Future<String> placeMarketOrder(
      String symbol, double quantity, String side) async {
    final String endpoint = '/fapi/v1/order';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch - 1000;

    Map<String, dynamic> order = {
      'symbol': symbol,
      'side': side.toUpperCase(), // BUY or SELL
      'type': 'MARKET',
      'quantity': quantity.toString(),
      'timestamp': timestamp.toString(),
    };

    String queryString = Uri(queryParameters: order).query;
    String signature = generateSignature(queryString);
    String signedQuery = '$queryString&signature=$signature';

    var response = await http.post(Uri.parse(url),
        headers: {
          'X-MBX-APIKEY': apiKey,
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: signedQuery);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to place market order: ${response.body}');
    }
  }

  // String generateSignature(String query) {
  //   var key = utf8.encode(apiSecret);
  //   var bytes = utf8.encode(query);

  //   var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  //   var digest = hmacSha256.convert(bytes);

  //   return digest.toString();
  // }

  Future<String> placeMarketOrderWithWalletBalance(String walletName,
      String symbol, String side, double percentageOfBalance) async {
    double walletBalance = await getWalletBalance(walletName);
    double quantity = walletBalance *
        percentageOfBalance; // Tính toán số lượng dựa trên phần trăm số dư

    // Giới hạn số lượng tối đa cho phép (ví dụ: 1000)
    double maxQuantity = 1000; // Giá trị này nên được lấy từ API hoặc cấu hình

    // Kiểm tra và điều chỉnh số lượng nếu cần
    if (quantity > maxQuantity) {
      quantity = maxQuantity;
    }

    return await placeMarketOrder(symbol, quantity, side);
  }

  Future<String> adjustLeverage(String symbol, int leverage) async {
    final String endpoint = '/fapi/v1/leverage';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    final String query =
        'symbol=$symbol&leverage=$leverage&timestamp=$timestamp';
    final String signature = generateSignature(query);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
      body: {
        'symbol': symbol,
        'leverage': leverage.toString(),
        'timestamp': timestamp.toString(),
        'signature': signature,
      },
    );
    print('timestamp' + timestamp.toString());
    if (response.statusCode == 200) {
      return 'Leverage adjusted: ${response.body}';
    } else {
      return 'Failed to adjust leverage: ${response.body}';
    }
  }

  Future<void> checkPositionLimits(String symbol) async {
    final String endpoint = '/fapi/v1/positionLimit';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    final String query = 'symbol=$symbol&timestamp=$timestamp';
    final String signature = generateSignature(query);

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      print("Position limits: ${response.body}");
    } else {
      print("Failed to fetch position limits: ${response.statusCode}");
    }
  }

  Future<int> getServerTime() async {
    final String url = '${AppStrings.testBaseUrl}/api/v3/time';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return body['serverTime'];
    } else {
      throw Exception('Failed to get server time');
    }
  }
}
