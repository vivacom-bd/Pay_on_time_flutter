import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hidmona/Utilities/colors.dart';

class ThemeController extends GetxController{
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.defaultColor,
    colorScheme: ThemeData.light().colorScheme.copyWith(primary: AppColor.defaultColor,),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: AppColor.defaultColor,
      // titleTextStyle: TextStyle(color: Colors.red,fontSize: 23,fontWeight: FontWeight.w700),
      // iconTheme: IconThemeData(color: Colors.red,size: 30)
    ),
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: Colors.white
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.defaultColor,
    colorScheme: ThemeData.dark().colorScheme.copyWith(primary: AppColor.defaultColor),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: AppColor.defaultColor,
      // titleTextStyle: TextStyle(color: Colors.redAccent[700],fontSize: 23,fontWeight: FontWeight.w700),
      // iconTheme: IconThemeData(color: Colors.redAccent[700],size: 30)
    ),
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: Colors.grey[900],
  );

  //brightness mode
  final getStorage = GetStorage();
  final brightnessModeKey = "isDarkMode";

  //init method
  static void init(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  ThemeMode getThemeData(){
    return getIsDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool getIsDarkMode(){
    return getStorage.read(brightnessModeKey) ?? Get.theme.brightness == Brightness.dark;
  }

  void changeThemeMode(){
    Get.changeThemeMode(getIsDarkMode() ? ThemeMode.light : ThemeMode.dark );
    getStorage.write(brightnessModeKey, !getIsDarkMode());
    update();
  }


  BoxShadow getShadow(){
    return getIsDarkMode()? BoxShadow(color: Colors.grey[800]!) : BoxShadow(color: Colors.grey[100]!);
  }

}