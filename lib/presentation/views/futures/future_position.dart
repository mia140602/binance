import 'package:binance_clone/presentation/widgets/position_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/local_data/sharePref.dart';
import '../../theme/palette.dart';

class FuturePosition extends StatefulWidget {
  const FuturePosition({super.key, this.symbol = "BTCUSDT"});
  final String symbol;

  @override
  State<FuturePosition> createState() => _FuturePositionState();
}

class _FuturePositionState extends State<FuturePosition> {
  List<Map<String, dynamic>> positionsList = [];
  void loadPositions() async {
    var positions = await SharePref.getAllPositions();
    setState(() {
      positionsList = positions;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPositions();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Scaffold(
        backgroundColor: palette.cardColor,
        body: ListView.builder(
          // shrinkWrap: true,
          padding: EdgeInsets.only(top: 0, bottom: 50),
          itemCount: positionsList.length,
          itemBuilder: (context, index) {
            var position = positionsList[index];
            return PositionCard(position: position);
          },
        ));
  }
}
