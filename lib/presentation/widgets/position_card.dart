import 'package:binance_clone/presentation/widgets/reactive_builder.dart';
import 'package:binance_clone/utils/parser_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:binance_clone/presentation/views/trade_details/trade_details_view_model.dart';
import 'package:intl/intl.dart';
import '../../data/local_data/sharepref.dart';
import '../../models/trade_data.dart';
import '../theme/palette.dart';

class PositionCard extends StatelessWidget {
  const PositionCard({super.key, required this.position});
  final Map<String, dynamic> position;
  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    void _deletePosition(BuildContext context) {
      // Gọi hàm xóa position từ SharePref
      SharePref.deletePosition(
        position['symbol'],
        position['type'],
        position['entryPrice'],
        position['leverage'],
        position['margin'],
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Position deleted successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete position')),
        );
      });
    }

    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref
              .read(tradeDetailsViewModelProvider(position['symbol']))
              .tradeData,
          builder: (tradeData) {
            double entryPrice = position['entryPrice'];
            double currentPrice = double.parse(tradeData.currentPrice);
            String pnl =
                calculatePNL(position['type'], entryPrice, currentPrice);
            double userMargin = position['margin'];
            String roi = calculateROI(userMargin, pnl);

            Color pnlColor = double.parse(pnl.replaceAll(',', '')) > 0
                ? palette.mainGreenColor
                : palette.sellButtonColor;
            String marginRatio = calculateMarginRatio(userMargin, currentPrice);
            String entryPriceFormat =
                ParserUtil.formatPrice(entryPrice.toString());
            String userMarginFormat =
                ParserUtil.formatPrice(userMargin.toString());
            String markPriceFormat =
                ParserUtil.formatPrice(tradeData.currentPrice);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: palette.cardColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Gap(10.w),
                          CustomText(
                            text: "Cross ${position['leverage']}X",
                            color: palette.filterLineColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          Gap(5.w),
                          Image.asset(
                            "assets/icons/futures_icon/mark.png",
                            width: 10,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _deletePosition(context),
                        child: Image.asset(
                          "assets/icons/futures_icon/share.png",
                          width: 14,
                          color: palette.appBarTitleColor,
                        ),
                      )
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _largeContent(
                          context: context,
                          title: "PNL (${tradeData.quoteAsset})",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _smallContent(
                          context: context,
                          title: "Size (${tradeData.baseAsset})",
                          content: "75.000"),
                      _smallContent(
                          context: context,
                          title: "Margin (${tradeData.quoteAsset})",
                          content: "${userMarginFormat}"),
                      _smallContent(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          context: context,
                          title: "Margin Ratio",
                          content: "${marginRatio}",
                          color: pnlColor),
                    ],
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _smallContent(
                          context: context,
                          title: "Entry Price (${tradeData.quoteAsset})",
                          content: "${entryPriceFormat}"),
                      _smallContent(
                          context: context,
                          title: "Mark Price (${tradeData.quoteAsset})",
                          content: "${markPriceFormat}"),
                      _smallContent(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          context: context,
                          title: "Liq.Price (${tradeData.quoteAsset})",
                          content: "--",
                          color: palette.appBarTitleColor),
                    ],
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bottomButton(context: context, label: "Chốt lãi & lỗ"),
                      _bottomButton(context: context, label: "Đóng vị thế"),
                      _bottomButton(context: context, label: "Đảo ngược"),
                    ],
                  ),
                  Gap(20.h),
                  Container(
                    height: 1,
                    color: palette.selectedTimeChipColor,
                  ),
                ],
              ),
            );
          });
    });
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
          fontSize: 11.sp,
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
          fontSize: 11.sp,
        ),
        CustomText(
          text: content,
          color: color ?? palette.appBarTitleColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _bottomButton(
      {VoidCallback? onTap,
      required BuildContext context,
      required String label}) {
    final palette = Theme.of(context).extension<Palette>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        width: (MediaQuery.of(context).size.width - 60) / 3,
        decoration: BoxDecoration(
          color: palette.selectedTimeChipColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: CustomText(
          text: label,
          color: palette.appBarTitleColor,
          textAlign: TextAlign.center,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
