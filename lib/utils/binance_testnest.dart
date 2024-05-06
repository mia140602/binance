import 'package:binance_clone/utils/app_strings.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> placeOrder(String symbol, double quantity, String side) async {
    final String endpoint = '/fapi/v1/order';
    final String url = '$baseUrl$endpoint';
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Tạo signature
    final String query =
        'symbol=$symbol&side=$side&type=MARKET&quantity=$quantity&timestamp=$timestamp';
    final String signature = generateSignature(query);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
      body: {
        'symbol': symbol,
        'side': side,
        'type': 'MARKET',
        'quantity': quantity.toString(),
        'timestamp': timestamp.toString(),
        'signature': signature,
      },
    );

    if (response.statusCode == 200) {
      print('Order placed: ${response.body}');
    } else {
      print('Failed to place order: ${response.body}');
    }
  }

  String generateSignature(String query) {
    var key = utf8.encode(apiSecret); // `apiSecret` là secret key của bạn
    var bytes = utf8.encode(query);

    var hmacSha256 = Hmac(sha256, key); // Tạo một HMAC SHA256 với secret key
    var digest = hmacSha256.convert(bytes); // Tạo chữ ký

    return digest.toString(); // Trả về chữ ký dưới dạng chuỗi hex
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
}
