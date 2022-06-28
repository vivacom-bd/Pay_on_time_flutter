import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class DefaultDialogs{
  //showDeleteDialog
  static Future<dynamic> showDialog({String title = "Title",String text = "Stay with AIID", String onSubmitText = "Submit", Function()? onSubmit, String cancelText="Cancel",Function()? onCancel}) {


    return showModal(
      configuration: const FadeScaleTransitionConfiguration(barrierDismissible: false),
      context: Get.context!,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: WillPopScope(
          onWillPop: (){
            return Future.value(false);
          },
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title,textAlign: TextAlign.center,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                Divider(color: AppColor.defaultColor,thickness: .5,),
                Text(text,textAlign: TextAlign.center,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    if(onCancel!=null) SizedBox(
                      width: 120,
                      child: DefaultButton(
                        onTap: onCancel,
                        buttonText: cancelText,
                        linearGradient: AppGradient.getColorGradient("grey"),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: 120,
                      child: DefaultButton(
                        onTap: onSubmit,
                        buttonText: onSubmitText,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}