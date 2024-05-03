import 'package:binance_clone/presentation/app_assets.dart';
import 'package:binance_clone/utils/app_strings.dart';
import 'package:binance_clone/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 15.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    AppStrings.total_balance,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(3.r)
                    ),
                    child: Row(
                      children: [
                        Text("BTC", style: AppStyle.minimumlBoldGrayText(),),
                        Icon(Icons.arrow_drop_down, size: 14.h,color: Colors.grey,)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset(WalletAssets.lineChart, height: 15.h,),
                  SizedBox(width: 10.w,),
                  Icon(
                    Icons.question_mark,
                    size: 14.h,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                "625,7274922",
                style: AppStyle.bigboldText(),
              ),
            ],
          ),
          Row(children: [
            Text("≈ 695,7274922", style: AppStyle.smallGrayText(),)
          ],),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(
          //       "PNL today",
          //       style: AppStyle.regularText().copyWith(decoration: TextDecoration.underline,decorationColor: Colors.grey),
          //     ),
          //     SizedBox(width: 2.w,),
          //     Text("+0,000241 \$", style: AppStyle.smallGreenText(),),
          //     Text("+0.02%",style: AppStyle.smallGreenText(),),
          //     Icon(Icons.arrow_right_outlined,size: 17.h,color: Colors.grey,)
          //   ],
          // ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.yellow[600],
                ),
                height: MediaQuery.of(context).size.height*0.05,
                width: MediaQuery.of(context).size.width*0.45,

                  child: TextButton(onPressed: (){}, child: Text("Buy",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),))),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey[200],
                  ),
                  height: MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.45,

                  child: TextButton(onPressed: (){}, child: Text("Deposite",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500)))),
            ],
          ),
          Divider(color: Colors.grey[300],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(AppStrings.account, style: AppStyle.boldText(),),
                  SizedBox(width: 10.w,),
                  Text(AppStrings.Cryptocurrency, style: AppStyle.boldText(),)
                ],
              ),
              Row(
                children: [
                  Image.asset(WalletAssets.edit, height: 14.h,color: Colors.grey,),
                  // SizedBox(width: 10.w,),
                  // Image.asset(WalletAssets.setting, height: 14.h,color: Colors.grey,),
                ],
              )
            ],
          ),
          SizedBox(height: 10.h,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Image.asset(WalletAssets.fdusd, height: 16.h,),
          //         SizedBox(width: 10.w,),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text("FDUSE", style: AppStyle.boldText(),),
          //             Text(AppStrings.fisrtDigital, style: AppStyle.smallGrayText(),)
          //           ],
          //         )
          //       ],
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Text("1.00",style: AppStyle.boldText(),),
          //         Text("0.00033 ETH", style: AppStyle.smallGrayText(),)
          //       ],
          //     )
          //   ],
          // ),
          // SizedBox(height: 20.h,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Image.asset(WalletAssets.memecoin, height: 16.h,),
          //         SizedBox(width: 10.w,),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text("MEME", style: AppStyle.boldText(),),
          //             Text("Memecoin", style: AppStyle.smallGrayText(),),
          //             Text("PNL today", style: AppStyle.smallGrayText(),),
          //             Text(AppStrings.avergeCost, style: AppStyle.smallGrayText(),),
          //           ],
          //         )
          //       ],
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         SizedBox(height: 15.h,),
          //         Text("0.928",style: AppStyle.boldText(),),
          //         Text("0 \$(-1,70%)", style: AppStyle.smallRedyText(),),
          //         SizedBox(height:1.h),
          //         Text("0.046719\$", style: AppStyle.smallGrayText(),)
          //       ],
          //     )
          //   ],
          // )
          Row(
            children: [
              Text(AppStrings.account, style: AppStyle.bolddText(),),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(WalletAssets.deposit, height: 17.h,),
                  SizedBox(width: 5.w,),
                  Text(AppStrings.spot, style: AppStyle.bolddText(),),
                ],
              ),
              Column(
                children: [
                  Text("44,93428732 BTC",style: AppStyle.boldText()),
                  Text("≈ 44,93428732 BTC",style: AppStyle.smallGrayText()),
                ],
              )
            ],
          ),
          SizedBox(height: 13.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.monetization_on_rounded,size: 16.h),
                  SizedBox(width: 5.w,),
                  Text('USD', style: AppStyle.bolddText(),),
                  Icon(Icons.monetization_on_outlined,size: 14.h),
                  Text("-M Futures",style: AppStyle.bolddText(), )
                ],
              ),
              Column(
                children: [
                  Text("44,93428732 BTC",style: AppStyle.boldText()),
                  Text("≈ 44,93428732 BTC",style: AppStyle.smallGrayText()),
                ],
              )
            ],
          ),
          SizedBox(height: 17.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.currency_bitcoin_outlined,size: 16.h,),
                  SizedBox(width: 5.w,),
                  Text('Funding', style: AppStyle.bolddText(),),

                ],
              ),
              Column(
                children: [
                  Text("0.00 BTC",style: AppStyle.boldText()),
                ],
              )
            ],
          ),
          SizedBox(height: 17.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(WalletAssets.salary,height: 15.h,),
                  SizedBox(width: 5.w,),
                  Text('Earn', style: AppStyle.bolddText(),),

                ],
              ),
              Column(
                children: [
                  Text("0.00 BTC",style: AppStyle.boldText()),
                ],
              )
            ],
          ),
          SizedBox(height: 17.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(WalletAssets.book,height: 15.h,),
                  SizedBox(width: 5.w,),
                  Text('COIN-M Futures', style: AppStyle.bolddText(),),

                ],
              ),
              Column(
                children: [
                  Text("0.00 BTC",style: AppStyle.boldText()),
                ],
              )
            ],
          ),
          SizedBox(height: 17.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.tire_repair_rounded,size: 16.h),
                  SizedBox(width: 5.w,),
                  Text('Cross Margin', style: AppStyle.bolddText(),),

                ],
              ),
              Column(
                children: [
                  Text("0.00 BTC",style: AppStyle.boldText()),
                ],
              )
            ],
          ),
          SizedBox(height: 17.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.tire_repair_outlined,size: 16.h,),
                  SizedBox(width: 5.w,),
                  Text('Isolated Margin', style: AppStyle.bolddText(),),

                ],
              ),
              Column(
                children: [
                  Text("0.00 BTC",style: AppStyle.boldText()),
                ],
              )
            ],
          ),
          SizedBox(height: 17.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.copy_all_rounded,size: 16.h,),
                  SizedBox(width: 5.w,),
                  Text('Copy Trading', style: AppStyle.bolddText(),),

                ],
              ),
              Column(
                children: [
                  Text("0.00 BTC",style: AppStyle.boldText()),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
