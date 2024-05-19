import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:gap/gap.dart';

import '../provider/future_provider.dart';
import 'slider/customslider.dart';

class EditLeverageFutureModal extends ConsumerStatefulWidget {
  const EditLeverageFutureModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditLeverageFutureModalState();
}

class _EditLeverageFutureModalState
    extends ConsumerState<EditLeverageFutureModal> {
  late TextEditingController _leverageController;

  @override
  void initState() {
    super.initState();
    // Đọc giá trị hiện tại từ leverageProvider
    int currentLeverage = ref.read(leverageProvider);
    // Khởi tạo TextEditingController với giá trị hiện tại
    _leverageController = TextEditingController(text: '${currentLeverage}x');
    _leverageController.addListener(_updateLeverage);
  }

  void _updateLeverage() {
    String currentText = _leverageController.text.replaceAll('x', '');
    if (currentText.isNotEmpty) {
      int currentValue = int.parse(currentText);
      if (currentValue > 100) {
        currentValue = 100;
      }
      String newText = '${currentValue}x';
      if (newText != _leverageController.text) {
        // Chỉ cập nhật nếu có thay đổi
        _leverageController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    } else {
      if (_leverageController.text != 'x') {
        // Tránh cập nhật nếu không cần thiết
        _leverageController.text = 'x';
        _leverageController.selection = TextSelection.collapsed(offset: 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentLeverage =
        ref.watch(leverageProvider); // Đảm bảo rằng giá trị được cập nhật
    _leverageController.text = '${currentLeverage}x';
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
            text: "Điều chỉnh đòn bẩy",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: palette.appBarTitleColor,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
            decoration: BoxDecoration(
              color: palette.bgGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.remove, color: palette.selectedTimeChipColor),
                Expanded(
                  child: TextField(
                    controller: _leverageController,
                    keyboardType: TextInputType.number,
                    cursorColor: palette.mainYellowColor,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: palette.appBarTitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.add, color: palette.selectedTimeChipColor),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Text(
          //   'Giá trị hiện tại: ${currentLeverage}x', // Hiển thị giá trị hiện tại
          //   style: TextStyle(
          //     fontSize: 16.sp,
          //     color: palette.appBarTitleColor,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          SizedBox(child: CustomSlider()),
          Gap(20.h),
          CustomText(
            text: "* Kích thước tối đa của vị thế ở mức đòn bẩy hiện tại:",
            fontSize: 12.sp,
            color: palette.selectedTimeChipColor,
          ),
          Gap(10.h),
          CustomText(
            text:
                "Xin lưu ý rằng việc thay đổi đòn bẩy cũng sẽ áp dụng cho các vị thế mở và lệnh đang mở.",
            fontSize: 12.sp,
            color: palette.selectedTimeChipColor,
          ),
          Gap(20.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      "* Việc chọn đòn bẩy cao hơn, chẳng hạn như [10x] có thể làm tắng rủi ro thanh lý. Hãy luôn kiểm soát mức độ rủi ro của bạn. Xem ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: palette.appBarTitleColor,
                  ),
                ),
                TextSpan(
                  text: "bài viết trợ giúp ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: palette.mainYellowColor,
                  ),
                ),
                TextSpan(
                  text: "của chúng tôi để biết thêm thông tin.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: palette.appBarTitleColor,
                  ),
                ),
              ],
            ),
          ),

          Gap(20.h),

          GestureDetector(
            onTap: () {
              int leverageValue =
                  int.parse(_leverageController.text.replaceAll('x', ''));
              ref.read(leverageProvider.notifier).state = leverageValue;
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: palette.mainYellowColor,
                  borderRadius: BorderRadius.circular(10.r)),
              child: CustomText(
                text: "Xác nhận",
                color: palette.cardColor,
                textAlign: TextAlign.center,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _leverageController.removeListener(_updateLeverage);
    _leverageController.dispose();
    super.dispose();
  }
}
