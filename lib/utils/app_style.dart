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
        fontSize: 15.sp,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
        fontFamily: 'Satoshi');
  }

  static TextStyle boldText() {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle smallboldText() {
    return TextStyle(
        color: Colors.black,
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

  static TextStyle bigboldText() {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle bigText() {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle regularText() {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        fontFamily: 'Satoshi');
  }

  static TextStyle regularGrayText() {
    return TextStyle(
        color: Colors.grey, fontSize: 15.sp, fontFamily: 'Satoshi');
  }

  static TextStyle regularBoldText() {
    return TextStyle(
        color: Colors.grey[500],
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

  static TextStyle smallGrayText() {
    return TextStyle(
        color: Colors.grey, fontSize: 13.sp, fontFamily: 'Satoshi');
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
        color: Colors.black, fontSize: 10.sp, fontFamily: 'Satoshi');
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
    return TextStyle(
        color: Colors.black,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Satoshi');
  }
}
