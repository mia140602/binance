// ignore_for_file: library_private_types_in_public_api

import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/futures/provider/future_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customslidethumb.dart';
import 'customvalue.dart';

class UsdSlider extends ConsumerStatefulWidget {
  const UsdSlider({Key? key, this.divisions}) : super(key: key);
  final int? divisions;

  @override
  _UsdSliderState createState() => _UsdSliderState();
}

class _UsdSliderState extends ConsumerState<UsdSlider> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    // _value = ref.read(leverageProvider).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 0.5,
        activeTrackColor: palette.appBarTitleColor,
        inactiveTrackColor: palette.selectedTimeChipColor.withOpacity(0.3),
        thumbColor: palette.cardColor,
        valueIndicatorColor: palette.appBarTitleColor,
        activeTickMarkColor: palette.appBarTitleColor,
        inactiveTickMarkColor: palette.selectedTabChipColor,
        thumbShape: CustomSliderThumbDiamond(),
        tickMarkShape: CustomSliderTickMarkDiamond(),
        valueIndicatorShape: CustomValueIndicatorShape(suffix: 'x'),
        overlayShape: NoOverlay(), // Tắt overlay
        overlayColor: Colors.transparent,
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        divisions: widget.divisions ?? 5, // Giữ lại các cột mốc
        min: 0,
        max: 100,
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
            print(value);
          });
          // ref.read(leverageProvider.notifier).state = value.round();
        },
      ),
    );
  }
}

class NoOverlay extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.zero; // Không có kích thước, không hiển thị
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    // Không vẽ gì cả
  }
}

//---------------------------------------------------------------------------------------------------

// class CoinMSlider extends ConsumerStatefulWidget {
//   const CoinMSlider({Key? key, this.divisions}) : super(key: key);
//   final int? divisions;

//   @override
//   _CoinMSliderState createState() => _CoinMSliderState();
// }

// class _CoinMSliderState extends ConsumerState<CoinMSlider> {
//   double _value = 0;

//   @override
//   void initState() {
//     super.initState();
//     // _value = ref.read(leverageProvider).toDouble();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final palette = Theme.of(context).extension<Palette>()!;
//     return SliderTheme(
//       data: SliderTheme.of(context).copyWith(
//         trackHeight: 0.5,
//         activeTrackColor: palette.appBarTitleColor,
//         inactiveTrackColor: palette.selectedTimeChipColor.withOpacity(0.3),
//         thumbColor: palette.cardColor,
//         valueIndicatorColor: palette.appBarTitleColor,
//         activeTickMarkColor: palette.appBarTitleColor,
//         inactiveTickMarkColor: palette.selectedTabChipColor,
//         thumbShape: CustomSliderThumbDiamond(),
//         tickMarkShape: CustomSliderTickMarkDiamond(),
//         valueIndicatorShape: CustomValueIndicatorShape(suffix: 'x'),
//         overlayShape: NoOverlay(), // Tắt overlay
//         overlayColor: Colors.transparent,
//         showValueIndicator: ShowValueIndicator.always,
//       ),
//       child: Slider(
//         divisions: widget.divisions ?? 5, // Giữ lại các cột mốc
//         min: 0,
//         max: 100,
//         value: _value,
//         onChanged: (value) {
//           setState(() {
//             _value = value;
//             print(value);
//           });
//           // ref.read(leverageProvider.notifier).state = value.round();
//         },
//       ),
//     );
//   }
// }

class CoinMSlider extends ConsumerStatefulWidget {
  const CoinMSlider({Key? key, this.divisions = 5}) : super(key: key);

  final int divisions;

  @override
  _CoinMSliderState createState() => _CoinMSliderState();
}

class _CoinMSliderState extends ConsumerState<CoinMSlider> {
  double _value = 0.0; // Khởi tạo với 0.0 để có độ chính xác tốt hơn

  @override
  void initState() {
    super.initState();
    // Cân nhắc sử dụng ref.watch ở đây nếu leverageProvider được cập nhật thường xuyên
    _value = ref.read(leverageProvider).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 0.5,
        activeTrackColor: palette.appBarTitleColor,
        inactiveTrackColor: palette.selectedTimeChipColor.withOpacity(0.3),
        thumbColor: palette.cardColor,
        valueIndicatorColor: palette.appBarTitleColor,
        activeTickMarkColor: palette.appBarTitleColor,
        inactiveTickMarkColor: palette.selectedTabChipColor,
        thumbShape: CustomSliderThumbDiamond(), // Hoặc bạn có thể tạo hình dạng nút trượt tùy chỉnh của mình
        tickMarkShape: CustomSliderTickMarkDiamond(), // Hoặc bạn có thể tạo hình dạng dấu tích tùy chỉnh của mình
        valueIndicatorShape: CustomValueIndicatorShape(suffix: 'x'),
        overlayShape: NoOverlay(),
        overlayColor: Colors.transparent,
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        divisions: widget.divisions,
        min: 0.0, // Sử dụng 0.0 để có độ chính xác tốt hơn
        max: 100.0, // Sử dụng 100.0 để rõ ràng
        value: _value,
        onChanged: (double value) {
          setState(() {
            _value = value;
            print('Giá trị hiện tại: $value (tương đương với ${(value / 100.0) * 100.0}% đòn bẩy)'); // Đầu ra được cải thiện
          });
          // Logic cập nhật của nhà cung cấp đòn bẩy (cân nhắc sử dụng ref.read ở đây)
          // ref.read(leverageProvider.notifier).state = value.round(); // Giả định .round() là phù hợp
        },
      ),
    );
  }
}
