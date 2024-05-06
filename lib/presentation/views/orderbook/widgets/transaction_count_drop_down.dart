import 'package:flutter/material.dart';
import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/widgets/custom_icon.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';

class TransactionCountDropDown<T> extends StatefulWidget {
  final List<T> counts;
  final Function(T) onChanged;

  const TransactionCountDropDown({
    super.key,
    required this.counts,
    required this.onChanged,
  });

  @override
  State<TransactionCountDropDown<T>> createState() =>
      TransactionCountDropDownState<T>();
}

class TransactionCountDropDownState<T>
    extends State<TransactionCountDropDown<T>> {
  T? Countselected;

  @override
  void initState() {
    super.initState();
    if (widget.counts.isNotEmpty) Countselected = widget.counts.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<Palette>()!.dropDownBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<T>(
        dropdownColor: Theme.of(context).extension<Palette>()!.cardColor,
        underline: const SizedBox(),
        icon: CustomIcon(
          iconPath: AppAssets.dropDown,
          width: 8,
          height: 9,
          color: Theme.of(context).colorScheme.secondary,
        ),
        value: Countselected,
        items: [
          for (final item in widget.counts)
            DropdownMenuItem(
              value: item,
              child: CustomText(
                text: "$item",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).extension<Palette>()!.appBarTitleColor,
              ),
            )
        ],
        onChanged: (value) {
          if (value != null) {
            widget.onChanged.call(value);
          }

          setState(() {
            Countselected = value;
          });
        },
      ),
    );
  }
}
