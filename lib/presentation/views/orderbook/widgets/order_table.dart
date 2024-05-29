import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:binance_clone/models/order.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTable extends StatelessWidget {
  final Iterable<Order> orders;
  final bool isFuture; // Thêm biến isFuture
  final int itemCount;
  final Color? backColor;

  const OrderTable(
      {super.key,
      this.orders = const [],
      required this.isFuture, // Thêm tham số isFuture vào constructor
      required this.itemCount,
      this.backColor});

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
            backColor: backColor,
          ),
      ],
    );
  }
}

class _OrderRow extends StatefulWidget {
  final Order order;
  final bool isFuture; // Thêm biến isFuture
  final int itemCount;
  final Color? backColor;

  const _OrderRow(
      {super.key,
      required this.order,
      required this.isFuture,
      this.backColor,
      required this.itemCount});

  @override
  State<_OrderRow> createState() => _OrderRowState();
}

class _OrderRowState extends State<_OrderRow> {
  late double leftPercentage;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    leftPercentage = Random().nextDouble() * 100;
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => randomizePercentages());
  }

  void randomizePercentages() {
    setState(() {
      double newPercentage;
      do {
        newPercentage = Random().nextDouble() * 100;
      } while ((newPercentage - leftPercentage).abs() > 10);
      leftPercentage = newPercentage;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<String> get _items => widget.isFuture
      ? [widget.order.price, widget.order.total]
      : [widget.order.price, widget.order.total];

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    Color color(int index) {
      if (index != 0) return Theme.of(context).colorScheme.primary;

      if (widget.order.isBuy) return palette.buyButtonColor;
      return palette.sellPriceColor;
    }

    final width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          height: 16.h,
          width: width * leftPercentage / 100,
          color: widget.backColor ?? palette.sellButtonColor.withOpacity(0.05),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < _items.length; i++)
              Column(
                children: [
                  SizedBox(
                    child: CustomText(
                      text: _items[i],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: color(i),
                      textAlign: i == 0 ? TextAlign.left : TextAlign.right,
                    ),
                  ),
                  SizedBox(height: 1.h,)
                ],
              ),
          ],
        ),
      ],
    );
  }
}
