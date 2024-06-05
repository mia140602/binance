import 'dart:async';

import 'package:binance_clone/presentation/views/wallets/model/crypto_model.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundingContainer extends StatefulWidget {
  const FundingContainer({super.key});

  @override
  State<FundingContainer> createState() => _FundingContainerState();
}

class _FundingContainerState extends State<FundingContainer> {
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
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: cryptos.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Row(
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
                    Text(
                      cryptos[index].price.toStringAsFixed(2),
                      style: AppStyle.bigText(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 35.0.w),
                      child: Text(
                        "Khả dụng",
                        style: AppStyle.smallGrayText(),
                      ),
                    ),
                    Text(
                      cryptos[index].percent.toStringAsFixed(6),
                      style: AppStyle.smallText(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 35.0.w),
                      child: Text(
                        "Đóng băng",
                        style: AppStyle.smallGrayText(),
                      ),
                    ),
                    Text(
                      cryptos[index].freeze.toStringAsFixed(4),
                      style: AppStyle.smallText(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            )));
  }
}
