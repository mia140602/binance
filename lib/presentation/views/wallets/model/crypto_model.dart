import 'dart:math';

import 'package:binance_clone/presentation/app_assets.dart';

class CryptoModel {
  String title;
  String description;
  String logo;
  double percent;
  double price;
  double freeze;

  CryptoModel({
    required this.title,
    required this.description,
    required this.logo,
    required this.percent,
    required this.price,
    required this.freeze,
  });
}

extension CryptoModelExt on CryptoModel {
  static List<CryptoModel> mockData() {
    Random random = Random();
    return [
      CryptoModel(
          description: "BNB",
          logo: CoinAssets.bnb,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.12222,
          title: "BNB"),
      CryptoModel(
          description: "BTC",
          logo: CoinAssets.bitcoin,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.1232,
          title: "BTC"),
      CryptoModel(
          description: "ethereum",
          logo: CoinAssets.eth,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.0522,
          title: "ETH"),
      CryptoModel(
          description: "dogecoin",
          logo: CoinAssets.dogecoin,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.2223699,
          title: "DOGE"),
      CryptoModel(
          description: "solana",
          logo: CoinAssets.solana,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.1000021,
          title: "SOL"),
      CryptoModel(
          description: "Wormhole",
          logo: CoinAssets.w,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.0,
          title: "W"),
      CryptoModel(
          description: "SHIB INU",
          logo: CoinAssets.shib,
          percent: random.nextDouble(),
          price: random.nextDouble(),
          freeze: 0.5555222,
          title: "SHIB"),
    ];
  }
}
