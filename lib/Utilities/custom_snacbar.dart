import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar{
  //snack bar
  static void showSnackBar(String value, {Function()? onRetry,int durationInSeconds= 2, Color color = const Color(0xffAD4C1F)}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      duration: Duration(seconds: durationInSeconds),
      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      padding: const EdgeInsets.all(12.0),
      behavior: SnackBarBehavior.floating,
      content: Text(value,style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500),),
      backgroundColor: color,
      action: onRetry==null? null : SnackBarAction(label: 'Retry',textColor: Colors.white60,onPressed: onRetry,),
    ));
  }
}