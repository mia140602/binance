import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  //Color
  static const Color select = Color(0xff1F2630);
  static const Color unselect = Color(0XFF929ba5);

  static const Color primaryColor = Color(0xffECB800);
  static const Color secondaryColor = Color(0xff29313E);

  static const Color textColor = Color(0xff6E7683);
  static const Color boxColor = Color(0xff434C5B);

  static const Color borderColor = Color(0xff252B39);
  static const Color primaryButtonColor = Color(0xffFCD434);
  static const Color backgroundColor = Color(0xff333B48);
  static const black = Color(0xFF000000);
  static const orange = Color(0xFFE58E32);
  static const yellow = Color(0xFFEEE9D6);

  //Text style
  static TextStyle navText() {
    return TextStyle(
        height: -0.5,
        color: black,
        fontSize: 11.0.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Satoshi');
  }

  static TextStyle boldgreyText() {
    return TextStyle(
        fontSize: 13.sp,
        color: Colors.white12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Satoshi');
  }

  static TextStyle boldText() {
    return GoogleFonts.roboto(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 13.sp,
    );
  }

  static TextStyle smallboldText() {
    return TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle bolddText() {
    return TextStyle(
        color: black,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        fontFamily: 'Satoshi');
  }




  static TextStyle regularGrayText() {
    return TextStyle(
        color: Colors.white, fontSize: 15.sp, fontFamily: 'Satoshi');
  }

  static TextStyle regularBoldText() {
    return TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle orangeSmallText() {
    return TextStyle(
        color: Colors.orange,
        fontWeight: FontWeight.w600,
        fontSize: 10.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle minimumlGrayText() {
    return TextStyle(
        color: Colors.grey, fontSize: 10.sp, fontFamily: 'Satoshi');
  }

  static TextStyle minimumlBoldGrayText() {
    return TextStyle(
        color: Colors.grey,
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Satoshi');
  }

  static TextStyle regularlBoldGrayText() {
    return TextStyle(
        color: Colors.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Satoshi');
  }

  static TextStyle minimumText() {
    return TextStyle(
        color: Colors.grey, fontSize: 10.sp, fontFamily: 'Satoshi');
  }

  static TextStyle smallRedyText() {
    return TextStyle(color: Colors.red, fontSize: 12.sp, fontFamily: 'Satoshi');
  }

  static TextStyle smallblackText() {
    return TextStyle(
        color: Colors.black, fontSize: 12.sp, fontFamily: 'Satoshi');
  }

  static TextStyle smallGreenText() {
    return TextStyle(
        color: Colors.green,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Satoshi');
  }

  static TextStyle bigGreenText() {
    return TextStyle(
        color: Colors.green,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Satoshi');
  }

  static TextStyle smallText() {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static TextStyle smallGrayText() {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: Color(0xFF757b87),
        fontSize: 13,
      ),
    );
  }

  static TextStyle bigText() {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
    );
  }

  static TextStyle bigboldText() {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 19.sp,
      ),
    );
  }

  static TextStyle regularText() {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
    );
  }
}
