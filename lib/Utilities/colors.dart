import 'package:flutter/material.dart';

class AppColor{
  static Color defaultColor = const Color(0xffAD4C1F);
  static Color defaultColorLight = const Color(0xffE94F07);
  static Color colorLight = const Color(0xffE94F07);
  // static Color defaultColor = const Color(0xff97D700);
  // static Color defaultColorLight = const Color(0xff108d2c);
  static Color dialogBackgroundColor = const Color(0xffFBF9F9);
  static Color textColor = const Color(0xffa1a1a1);
  static Color boxColor = const Color(0xffeeeded);
  static Color cardColor = const Color(0xffffffff);
  static Color dropdownBoxColor = const Color(0xffcac9c9);
  static Color defaultTextColor = Colors.black;
  static Color successfulTextColor = const Color(0xff97D700);
  static Color hyperlinkColor = const Color(0xff3366CC);
}




class AppGradient{
  static LinearGradient getColorGradient(String name){

    switch(name){
      case "default" : {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:  [
              AppColor.defaultColor,
              AppColor.defaultColorLight,
            ]);
      }
      case "default-horizontal" : {
        return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors:  [
              AppColor.defaultColor,
              AppColor.defaultColorLight,
            ]);
      }
      case "red" : {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:  [
              Colors.red,
              Colors.red[900]!,
            ]);
      }
      case "grey" : {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:  [
              Colors.grey[300]!,
              Colors.grey,
            ]);
      }
      default: {
        //default
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:  [
              AppColor.defaultColor,
              AppColor.defaultColorLight,
            ]);
      }
    }

  }
}

