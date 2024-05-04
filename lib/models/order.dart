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
    this.amount = ParserUtil.formatPrice(amount); // Sử dụng formatPrice nếu cần
    this.total = ParserUtil.formatTotal(total);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final priceValue = double.tryParse(json["p"]) ?? 0;
    final amountValue = double.tryParse(json["q"]) ?? 0;
    return Order(
      price: ParserUtil.formatPrice(json["p"]),
      amount: ParserUtil.formatPrice(json["q"]),
      total:
          ParserUtil.formatTotal(((priceValue * amountValue) * 100).toString()),
      isBuy: json["m"] ?? false,
    );
  }
}
