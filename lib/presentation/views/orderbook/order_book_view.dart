import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/views/orderbook/order_book_view_model.dart';
import 'package:binance_clone/presentation/views/orderbook/widgets/column_header.dart';
import 'package:binance_clone/presentation/views/orderbook/widgets/filter_row.dart';
import 'package:binance_clone/presentation/views/orderbook/widgets/order_table.dart';
import 'package:binance_clone/presentation/views/orderbook/widgets/price_bar.dart';
import 'package:binance_clone/presentation/widgets/reactive_builder.dart';

import '../../theme/palette.dart';

class OrderBookView extends StatefulWidget {
  const OrderBookView({super.key});

  @override
  State<OrderBookView> createState() => _OrderBookViewState();
}

class _OrderBookViewState extends State<OrderBookView> {
  final _counts = [1, 2, 3, 4];
  late int _limit = 8;

  bool _showSells = true;
  bool _showBuys = true;
  int itemCount = 8;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Consumer(builder: (context, ref, _) {
        return Column(
          children: [
            Gap(5.h),
            const ColumnHeader(),
            // const Gap(12),
            if (_showSells)
              ReactiveBuilder(
                value: ref.read(orderBookViewModelProvider).sellOrders,
                builder: (orders) {
                  return OrderTable(
                    orders: orders.take(_limit),
                    isFuture: true,
                    itemCount: itemCount,
                  );
                },
              ),
            Gap(5.h),
            if (_showSells && _showBuys) ...{
              ReactiveBuilder(
                value: ref.read(orderBookViewModelProvider).prices,
                builder: (prices) {
                  return Pricebar(
                    oldPrice: prices.last,
                    newPrice: prices.first,
                  );
                },
              ),
              Gap(5.h),
            },
            if (_showBuys) ...{
              ReactiveBuilder(
                value: ref.read(orderBookViewModelProvider).buyOrders,
                builder: (orders) {
                  return OrderTable(
                    orders: orders.take(_limit),
                    isFuture: false,
                    itemCount: itemCount,
                  );
                },
              ),
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF29313C),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 9.w),
                        child: CustomText(
                          text: "0.1",
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 16.h,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                // const Spacer(),
                FilterRow(
                  onChanged: (value) {
                    setState(() {
                      _showSells = value == 0 || value == 2;
                      _showBuys = value == 0 || value == 1;

                      // Cập nhật itemCount dựa trên trạng thái của _showSells và _showBuys
                      if (_showSells && _showBuys) {
                        itemCount = 8;
                      } else if (_showSells || _showBuys) {
                        itemCount = 16;
                      } else {
                        itemCount = 8; // Có thể đặt giá trị này nếu cần
                      }
                      _limit = itemCount;
                    });
                  },
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
