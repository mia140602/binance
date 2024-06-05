import 'dart:math';

enum MoneyEnum {
  BTC,
  ETH,
  BNB,
  USDT,
  USD,
}

extension MoneyEnumExt on MoneyEnum {
  static double generateMoney(MoneyEnum typeMoney) {
    Random random = Random();
    return random.nextDouble();
  }
}
