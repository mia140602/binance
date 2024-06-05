import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/wallets/model/money_enum.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropSymbolContainer extends StatefulWidget {
  final MoneyEnum symbol;
  final Function(MoneyEnum value) onChange;

  const DropSymbolContainer(
      {super.key, required this.symbol, required this.onChange});

  @override
  State<DropSymbolContainer> createState() => _DropSymbolContainerState();
}

class _DropSymbolContainerState extends State<DropSymbolContainer> {
  MoneyEnum? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.symbol;
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<MoneyEnum>(
          value: _value,
          onChanged: (value) {
            if (!mounted) return;

            setState(() {
              _value = value;
            });
            if (value != null) widget.onChange(value);
          },
          customButton: (_value != null)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: _value!.name,
                      fontSize: 14.sp,
                      color: palette.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                    const Icon(Icons.arrow_drop_down_sharp),
                  ],
                )
              : null,
          items: MoneyEnum.values
              .map((MoneyEnum item) => DropdownMenuItem<MoneyEnum>(
                    value: item,
                    child: CustomText(
                      text: item.name,
                      fontSize: 14.sp,
                      color: palette.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ))
              .toList(),
          buttonStyleData: ButtonStyleData(
            width: 60.w,
            decoration: BoxDecoration(
              color: palette.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: palette.cardColor,
            ),
            offset: const Offset(-16, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          )),
    );
  }
}
