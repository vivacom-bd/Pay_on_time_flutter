import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'colors.dart';

class Utility{

  static void showSnackBar(String value,{ Function()? onRetry,int durationInSeconds= 2}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: onRetry==null?10:0),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: durationInSeconds),
      content: Text(value, textAlign: onRetry == null? TextAlign.center : TextAlign.start, style: const TextStyle(fontSize: 17,color: Colors.white),),
      backgroundColor: AppColor.defaultColor,
      action: onRetry==null?null:SnackBarAction(label: 'Retry',textColor: Colors.black54,onPressed: onRetry,),
    ));
  }

  static Future<bool> isInternetConnected() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  static showLoadingDialog(){
    showModal(
        configuration: const FadeScaleTransitionConfiguration(barrierDismissible: false),
        context: Get.context!,
        builder:(context) => SpinKitCircle(size: 85,color: AppColor.defaultColor,)
    );
  }

}