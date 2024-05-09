import 'package:flutter/material.dart';
import 'package:binance_clone/models/order.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTable extends StatelessWidget {
  final Iterable<Order> orders;
  final bool isFuture; // Thêm biến isFuture
  final int itemCount;

  const OrderTable(
      {super.key,
      this.orders = const [],
      required this.isFuture, // Thêm tham số isFuture vào constructor
      required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var order in orders)
          _OrderRow(
            order: order,
            isFuture: isFuture,
            itemCount: itemCount,
          ),
      ],
    );
  }
}

class _OrderRow extends StatelessWidget {
  final Order order;
  final bool isFuture; // Thêm biến isFuture
  final int itemCount;

  const _OrderRow(
      {super.key,
      required this.order,
      required this.isFuture,
      required this.itemCount});

  List<String> get _items =>
      isFuture ? [order.price, order.amount] : [order.price, order.amount];
  @override
  Widget build(BuildContext context) {
    Color color(int index) {
      if (index != 0) return Theme.of(context).colorScheme.primary;

      final palette = Theme.of(context).extension<Palette>()!;
      if (order.isBuy) return palette.buyButtonColor;
      return palette.sellPriceColor;
    }

    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < _items.length; i++)
            SizedBox(
              // width: width / 2 - 40, // Chia đều cho 2 cột
              child: CustomText(
                text: _items[i],
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
                color: color(i),
                textAlign: i == 0
                    ? TextAlign.left
                    : TextAlign.right, // Căn chỉnh giá và tổng hoặc số lượng
              ),
            ),
        ],
      ),
    );
  }
}
