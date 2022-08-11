import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class PaymentDialog{
  //showDeleteDialog
  static Future<dynamic> showDialog({String text = "Your Payment Is Successful.\nWe'll update your transaction after manual verification!"}) {


    return showModal(
      configuration: const FadeScaleTransitionConfiguration(barrierDismissible: false),
      context: Get.context!,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: WillPopScope(
          onWillPop: ()async{return false;},
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                //Image.asset("assets/images/update.png",height: 60,),
                Text("Success",textAlign: TextAlign.center,style: TextStyle(color: AppColor.successfulTextColor,fontSize: 30,fontWeight: FontWeight.w700),),
                const SizedBox(height: 25,),
                Text(text,textAlign: TextAlign.center,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                const SizedBox(
                  height: 25.0,
                ),
                DefaultButton(
                  onTap: () async{
                    Get.offAll(const HomeScreen());
                  },
                  buttonText: "Back to Home",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}