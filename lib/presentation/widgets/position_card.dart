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
              position['walletName'],
              position['symbol'],
              position['type'],
              position['entryPrice'],
              position['leverage'],
              position['margin'])
          .then((_) {
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
            double leverage = position['leverage'];
            double currentPrice = double.parse(tradeData.currentPrice);

            double userMargin = position['margin'];

            String pnl = calculatePNL(position['type'], entryPrice,
                currentPrice, position['margin'], leverage);
            double size = calculateSize(pnl, currentPrice, entryPrice);
            String formattedSize = NumberFormat("#,##0", "en_US").format(size);
            String roi = calculateROI(userMargin, pnl);
            Color pnlColor = double.parse(pnl.replaceAll(',', '')) > 0
                ? palette.mainGreenColor
                : palette.sellButtonColor;
            String marginRatio = calculateMarginRatio(size, userMargin);
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/futures_icon/icon_position.png",
                            width: 15.w,
                          ),
                          Gap(5.w),
                          CustomText(
                            text: "${position['symbol']} Vĩnh cửu",
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
                  Gap(5.h),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _smallContent(
                              context: context,
                              title: "Kích thước (${tradeData.quoteAsset})",
                              content: "${formattedSize}"),
                          _smallContent(
                              context: context,
                              title: "Giá vào lệnh (${tradeData.quoteAsset})",
                              content: "${entryPriceFormat}"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _smallContent(
                              context: context,
                              title: "Margin (${tradeData.quoteAsset})",
                              content: "${userMarginFormat}"),
                          _smallContent(
                              context: context,
                              title: "Giá đánh dấu (${tradeData.quoteAsset})",
                              content: "${markPriceFormat}"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _smallContent(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              context: context,
                              title: "Tỉ lệ ký quỹ",
                              content: "${marginRatio}",
                              color: pnlColor),
                          _smallContent(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              context: context,
                              title: "Giá thanh lý (${tradeData.quoteAsset})",
                              content: "--",
                              color: palette.appBarTitleColor),
                        ],
                      )
                    ],
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bottomButton(context: context, label: "Đòn bẩy"),
                      _bottomButton(context: context, label: "TP/SL"),
                      _bottomButton(context: context, label: "Đóng"),
                    ],
                  ),
                  Gap(20.h),
                  Container(
                    height: 1,
                    color: palette.selectedTabChipColor,
                  ),
                ],
              ),
            );
          });
    });
  }

  String calculateMarginRatio(
    double size,
    double userMargin,
  ) {
    double marginRatio = (10 * userMargin / size) * 100;
    return NumberFormat("#,##0.00%", "en_US").format(marginRatio);
  }

  String calculatePNL(String type, double entryPrice, double currentPrice,
      double margin, double leverage) {
    double pnlValue;
    if (type == "Long") {
      pnlValue = (currentPrice - entryPrice) / entryPrice * margin * leverage;
    } else if (type == "Short") {
      pnlValue = -(currentPrice - entryPrice) / entryPrice * margin * leverage;
    } else {
      pnlValue = 0.0;
    }
    return ParserUtil.formatPrice(pnlValue.toString());
  }

  String calculateROI(double userMargin, String pnl) {
    double pnlValue = double.parse(pnl.replaceAll(',', ''));
    if (pnlValue > 0) {
      return NumberFormat("+#,##0.00%", "en_US")
          .format(pnlValue / userMargin / 10);
    }
    return NumberFormat("#,##0.00%", "en_US")
        .format(pnlValue / userMargin / 10);
  }

  double calculateSize(String pnl, double currentPrice, double entryPrice) {
    double pnlValue = double.parse(pnl.replaceAll(',', ''));
    return pnlValue / (currentPrice - entryPrice);
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
          fontSize: 10.sp,
        ),
        CustomText(
          text: content,
          color: color,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
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
          color: palette.bgGray,
          borderRadius: BorderRadius.circular(5.r),
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
