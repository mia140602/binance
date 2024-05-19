import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/future_provider.dart';
import 'customslidethumb.dart';
import 'customvalue.dart';

class CustomSlider extends ConsumerStatefulWidget {
  CustomSlider({Key? key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends ConsumerState<CustomSlider> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
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
        thumbShape: CustomSliderThumbDiamond(),
        tickMarkShape: CustomSliderTickMarkDiamond(),
        valueIndicatorShape: CustomValueIndicatorShape(suffix: 'x'),
        overlayShape: NoOverlay(), // Tắt overlay
        overlayColor: Colors.transparent,
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        divisions: 5, // Giữ lại các cột mốc
        min: 0,
        max: 50,
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          ref.read(leverageProvider.notifier).state = value.round();
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
