import 'package:binance_clone/utils/parser_util.dart';

class TradeData {
  final String symbol;
  final double priceChangeIn24H;
  final String currentPrice;
  final String highPrice;
  final String lowPrice;
  final double percentageChangeIn24H;
  final double highPercentageChangeIn24H;
  final double lowPercentageChangeIn24H;
  final String baseAssetVolume;
  final String quoteAssetVolume;

  TradeData(
      {required this.symbol,
      required this.priceChangeIn24H,
      required this.currentPrice,
      required this.highPrice,
      required this.lowPrice,
      required this.percentageChangeIn24H,
      required this.highPercentageChangeIn24H,
      required this.lowPercentageChangeIn24H,
      required this.baseAssetVolume,
      required this.quoteAssetVolume});

  bool get isPriceChangeIn24HNeg => priceChangeIn24H < 0;

  factory TradeData.initial(String symbol) {
    return TradeData(
      symbol: symbol,
      priceChangeIn24H: 0,
      currentPrice: "-",
      highPrice: "-",
      lowPrice: "-",
      baseAssetVolume: "-",
      quoteAssetVolume: "-",
      percentageChangeIn24H: 0,
      highPercentageChangeIn24H: 0,
      lowPercentageChangeIn24H: 0,
    );
  }

  factory TradeData.fromJson(Map<String, dynamic> json) {
    final lastPriceValue = double.tryParse(json["o"]) ?? 0;
    final currentPriceValue = double.tryParse(json["c"]) ?? 0;
    final highPriceValue = double.tryParse(json["h"]) ?? 0;
    final lowPriceValue = double.tryParse(json["l"]) ?? 0;

    final percentageChangeIn24HValue =
        100 * (currentPriceValue - lastPriceValue) / lastPriceValue;
    final highPercentageChangeIn24HValue =
        (highPriceValue - lastPriceValue) / lastPriceValue;
    final lowPercentageChangeIn24HValue =
        (lowPriceValue - lastPriceValue) / lastPriceValue;

    return TradeData(
      symbol: json["s"] ?? "NA",
      priceChangeIn24H: currentPriceValue - lastPriceValue,
      currentPrice: ParserUtil.clampDigits(json["c"] ?? "-"),
      highPrice: ParserUtil.clampDigits(json["h"] ?? "-"),
      lowPrice: ParserUtil.clampDigits(json["l"] ?? "-"),
      quoteAssetVolume: ParserUtil.clampDigits(json["q"] ?? '-'),
      baseAssetVolume: ParserUtil.clampDigits(json["v"] ?? '-'),
      percentageChangeIn24H: percentageChangeIn24HValue,
      highPercentageChangeIn24H: highPercentageChangeIn24HValue,
      lowPercentageChangeIn24H: lowPercentageChangeIn24HValue,
    );
  }
}
