import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view_model.dart';
import 'package:intl/intl.dart';
import '../../models/trade_data.dart';
import '../theme/palette.dart';

class PositionCard extends ConsumerWidget {
  const PositionCard({
    super.key,
    required this.position,
  });

  final Map<String, dynamic> position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = Theme.of(context).extension<Palette>()!;
    final TradeData data = ref
        .watch(tradeDetailsViewModelProvider(position['symbol']))
        .tradeData
        .value;

    double entryPrice = position['entryPrice'];
    double currentPrice = double.parse(data.currentPrice);
    String pnl = calculatePNL(position['type'], entryPrice, currentPrice);
    double userMargin =
        position['margin']; // Giả sử margin được lưu trong position
    String roi = calculateROI(userMargin, pnl);

    Color pnlColor = double.parse(pnl.replaceAll(',', '')) > 0
        ? palette.mainGreenColor
        : palette.sellButtonColor;
    String marginRatio = calculateMarginRatio(userMargin, currentPrice);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: palette.cardColor,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/futures_icon/icon_position.png",
                width: 18,
              ),
              Gap(10),
              CustomText(
                text: "${position['symbol']} Perpetual",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              Gap(20),
              CustomText(
                text: "Cross ${position['leverage']}X",
                color: palette.filterLineColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _largeContent(
                  context: context,
                  title: "PNL (${data.quoteAsset})",
                  content: pnl,
                  color: pnlColor),
              _largeContent(
                  context: context,
                  title: "ROI",
                  content: roi,
                  color: pnlColor,
                  crossAxisAlignment: CrossAxisAlignment.end)
            ],
          ),
          Gap(10),
          Row(
            children: [
              _smallContent(
                  context: context,
                  title: "Size (${data.baseAsset})",
                  content: "75.000"),
              _smallContent(
                  context: context,
                  title: "Margin (${data.quoteAsset})",
                  content: "${position['margin']}"),
              _smallContent(
                  context: context,
                  title: "Margin Ratio",
                  content: "${marginRatio}",
                  color: pnlColor),
            ],
          )
        ],
      ),
    );
  }

  String calculateMarginRatio(double userMargin, double currentPrice) {
    double marginRatio = (userMargin / (0.075 * currentPrice)) * 100;

    return NumberFormat("#,##0.00%", "en_US").format(marginRatio);
  }

  String calculatePNL(String type, double entryPrice, double currentPrice) {
    double pnlValue;
    if (type == "Long") {
      pnlValue = 0.075 * (currentPrice - entryPrice);
    } else if (type == "Short") {
      pnlValue = -0.075 * (currentPrice - entryPrice);
    } else {
      pnlValue = 0.0;
    }
    return NumberFormat("#,##0.00", "en_US").format(pnlValue);
  }

  String calculateROI(double userMargin, String pnl) {
    double pnlValue = double.parse(pnl.replaceAll(',', ''));
    if (pnlValue > 0) {
      return NumberFormat("+#,##0.00%", "en_US")
          .format(pnlValue / userMargin * 100);
    }
    return NumberFormat("-#,##0.00%", "en_US")
        .format(pnlValue / userMargin * 100);
  }

  Widget _largeContent(
      {required BuildContext context,
      required String title,
      required String content,
      required Color color,
      CrossAxisAlignment? crossAxisAlignment}) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: palette.filterLineColor,
          fontSize: 12.sp,
        ),
        CustomText(
          text: content,
          color: color,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _smallContent(
      {required BuildContext context,
      required String title,
      required String content,
      Color? color,
      CrossAxisAlignment? crossAxisAlignment}) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: palette.filterLineColor,
          fontSize: 12.sp,
        ),
        CustomText(
          text: content,
          color: color ?? palette.appBarTitleColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
