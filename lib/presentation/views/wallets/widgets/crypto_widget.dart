import 'dart:async';

import 'package:binance_clone/presentation/views/wallets/model/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_style.dart';

class CryptoWidget extends StatefulWidget {
  final bool showDescription;
  const CryptoWidget({super.key, this.showDescription = true});

  @override
  State<CryptoWidget> createState() => _CryptoWidgetState();
}

class _CryptoWidgetState extends State<CryptoWidget> {
  List<CryptoModel> cryptos = CryptoModelExt.mockData();
  Timer? timerCrypto;

  @override
  void initState() {
    super.initState();
    timerCrypto = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        cryptos = CryptoModelExt.mockData();
      });
    });
  }

  @override
  void dispose() {
    timerCrypto?.cancel();
    timerCrypto = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    cryptos[index].logo,
                    height: 22.h,
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cryptos[index].title,
                        style: AppStyle.bigText(),
                      ),
                      Text(
                        cryptos[index].description,
                        style: AppStyle.smallGrayText(),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cryptos[index].percent.toStringAsFixed(6),
                    style: AppStyle.regularBoldText(),
                  ),
                  if (widget.showDescription)
                    Text(
                      "\$${cryptos[index].percent.toStringAsFixed(6)}",
                      style: AppStyle.regularText(),
                    )
                ],
              )
            ],
          ),
        ),
        itemCount: cryptos.length,
      ),
    );
  }
}
