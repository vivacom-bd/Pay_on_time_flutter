import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class DefaultDialogs{
  BuildContext context;
  DefaultDialogs({required this.context});

  //showDeleteDialog
  Future<dynamic> showDialog({
    String title = "Title",
    String text = "",
    String onSubmitText = "Submit",
    final Function()? onSubmit,
    String cancelText="Cancel",
    final Function()? onCancel
  }) {

    return showModal(
      configuration: const FadeScaleTransitionConfiguration(barrierDismissible: false),
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: WillPopScope(

          onWillPop: () {
            return null!;
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColor.boxColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title,textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Jost"
                  ),
                ),
                Divider(color: AppColor.defaultColor,thickness: .5,),
                Center(
                  child:Text(text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Jost"
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      //width: 100,
                      child: DefaultButton(
                        onTap: onSubmit,
                        buttonText: onSubmitText,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if(onCancel!=null) SizedBox(
                      //width: 100,
                      child: DefaultButton(
                        onTap: onCancel,
                        buttonText: cancelText,
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