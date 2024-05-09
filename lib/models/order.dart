import '../utils/parser_util.dart';

class Order {
  late final String price;
  late final String amount;
  late final String total;
  final bool isBuy;

  Order({
    required String price,
    required String amount,
    required String total,
    required this.isBuy,
  }) {
    this.price = ParserUtil.formatPrice(price);
    this.amount =
        ParserUtil.formatAmount(amount); // Sử dụng formatPrice nếu cần
    this.total = ParserUtil.formatTotal(total);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final priceValue = double.tryParse(json["p"]) ?? 0;
    final amountValue = double.tryParse(json["q"]) ?? 0;
    final totalValue = priceValue * amountValue * 100;
    return Order(
      price: ParserUtil.formatPrice(json["p"]),
      amount: ParserUtil.formatPrice(json["q"]),
      // total: ParserUtil.formatPrice(totalValue.toString()),
      total: ParserUtil.formatTotal(totalValue.toString()),
      // isBuy: json["m"] ?? false,
      isBuy: !(json["m"] as bool? ?? false),
    );
  }
}
