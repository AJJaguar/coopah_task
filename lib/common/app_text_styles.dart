import 'package:flutter/material.dart';


class AppTextStyle {

  /// 20 - extraBold
  static TextStyle headline1({
    Color? color,
    FontWeight fontWeight = FontWeight.w400
  }) {
    return _baseTextStyle(
      color: color,
      fontSize: 20,
      fontWeight: fontWeight,
    );
  }

  /// 16 - SemiBold
  static TextStyle headline2({
    Color? color,
    FontWeight fontWeight = FontWeight.w400
  }) {
    return _baseTextStyle(
      color: color,
      fontSize: 16,
      fontWeight: fontWeight,
    );
  }


  /// 16 - medium
  static TextStyle headline3({
    Color? color,
    FontWeight fontWeight = FontWeight.w500
  }) {
    return _baseTextStyle(
      color: color,
      fontSize: 15,
      fontWeight: fontWeight,
    );
  }


  static TextStyle _baseTextStyle({
    Color? color =  Colors.black,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'CircularStd',
    );
  }
}

