import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_strings.dart';
import '../../../../utils/app_style.dart';
import '../../../app_assets.dart';
import '../../../theme/palette.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.03, vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    AppStrings.total_earn,
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 15.h,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 14.h,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$ 0",
                style: AppStyle.bigboldText(),
              ),
              SizedBox(
                width: 8.w,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.0.w),
                child: Row(
                  children: [
                    Text(
                      "USD",
                      style: AppStyle.smallText(),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 14.h,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'PNL hôm qua(USD)',
                      style: AppStyle.smallText().copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey.shade500,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                  ),
                  Text(
                    "\$0",
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Lợi nhuận trong 30 ngày',
                        style: AppStyle.smallText()
                    ),
                  ),
                  Text("(USD)", style: AppStyle.smallText(),),
                  Text(
                    "\$0",
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade700)),
                    padding: EdgeInsets.all(10.h),
                    child: Image.asset(
                      WalletAssets.salary,
                      color: Colors.orange,
                      height: 24.h,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Earn",
                    style: AppStyle.smallboldText(),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade700)),
                    padding: EdgeInsets.all(10.h),
                    child: Image.asset(
                      WalletAssets.workflow,
                      height: 24.h,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Tự động đầu tư",
                    style: AppStyle.smallboldText(),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade700)),
                    padding: EdgeInsets.all(10.h),
                    child: Image.asset(
                      WalletAssets.loan,
                      height: 24.h,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Cho vay",
                    style: AppStyle.smallboldText(),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade700)),
                    padding: EdgeInsets.all(10.h),
                    child: Image.asset(
                      WalletAssets.salary,
                      color: Colors.orange,
                      height: 24.h,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Earn một chạm",
                    style: AppStyle.smallboldText(),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Container(
            width: double.infinity,
            height: 1.h,
            color: Colors.grey.shade700,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton(onPressed: () {
                    setState(() {
                      isChecked = true;
                    });
                  },
                    child: Text("Theo tài sản", style:isChecked ?  AppStyle.boldText(): AppStyle.boldgreyText(),),),
                  TextButton(onPressed: () {
                    setState(() {
                      isChecked = false;
                    });
                  },
                    child: Text("Theo sản phẩm", style:isChecked ?  AppStyle.boldgreyText(): AppStyle.boldText(),),)
                ],
              ),
              Row(
                children: [
                  Image.asset(WalletAssets.search,height: 15.h,color: Colors.grey,),
                  SizedBox(width: 10.w,),
                  Icon(Icons.format_align_justify,size: 15.h,color: Colors.grey,)
                ],
              )
            ],
          ),
          isChecked?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              Image.asset(WalletAssets.bigsearch,height: 80.h,),
              SizedBox(height: 20.h,),
              Text("Không có dữ liệu được ghi nhận", style: AppStyle.regularGrayText(),),
              SizedBox(height: 20.h,),
              Container(
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade700,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Đăng kí ngay",
                              style: GoogleFonts.roboto(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )))
                  ],
          ): Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              Image.asset(WalletAssets.bigsearch,height: 80.h,),
              SizedBox(height: 20.h,),
              Text("Không có dữ liệu được ghi nhận", style: AppStyle.regularGrayText(),),
              SizedBox(height: 20.h,),
              Container(
                  height: 32.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade700,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Đăng kí ngay",
                              style: GoogleFonts.roboto(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )))
                  ],
          )
        ],
      ),

    );
  }
}
