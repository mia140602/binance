import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:gap/gap.dart';

import '../provider/future_provider.dart';

class MarginFutureModal extends ConsumerStatefulWidget {
  const MarginFutureModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MarginFutureModalState();
}

class _MarginFutureModalState extends ConsumerState<MarginFutureModal> {
  @override
  Widget build(BuildContext context) {
    String currentMargin = ref.watch(marginProvider);
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      // height: 450.h,
      decoration: BoxDecoration(
        color: palette.cardColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          CustomText(
            text: "Chế độ Margin",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: palette.appBarTitleColor,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              ref.read(marginProvider.notifier).state = "Cross";
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: currentMargin == "Cross"
                        ? palette.appBarTitleColor
                        : palette.selectedTimeChipColor,
                    width: 1),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Cross",
                    color: palette.appBarTitleColor,
                    fontSize: 16.sp,
                  ),
                  Gap(5.h),
                  CustomText(
                    text:
                        "Tất cả vị thế cross margin sử dụng tài sản ký quỹ sẽ cùng chia sẻ số dư tài sản crossmargin trong thời gian thanh lý, số dư tài khoản kí quỹ của bạn cùng với tất cả các vị thế đang mở có thể sẽ bị tịch thu.",
                    color: palette.selectedTimeChipColor,
                    fontSize: 12.sp,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              ref.read(marginProvider.notifier).state = "Isolated";
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: currentMargin == "Isolated"
                        ? palette.appBarTitleColor
                        : palette.selectedTimeChipColor,
                    width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Isolated",
                    color: palette.appBarTitleColor,
                    fontSize: 16.sp,
                  ),
                  CustomText(
                    text:
                        "Lượng margin của vị thế được giới hạn trong một khoản nhất định. Nếu giảm xuống thấp hơn mức Margin Duy trì, vị thế sẽ bị thanh lý. Tuy nhiên chế độ này cho phép bạn thêm hoặc gỡ margin tùy ý muốn.",
                    color: palette.selectedTimeChipColor,
                    fontSize: 12.sp,
                  )
                ],
              ),
            ),
          ),
          Gap(20.h),
          CustomText(
            text:
                "* Chuyển chế độ margin chỉ áp dụng cho những hợp đồng được chọn.",
            fontSize: 12.sp,
            color: palette.selectedTimeChipColor,
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}
