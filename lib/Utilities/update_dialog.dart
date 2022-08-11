import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Views/Widgets/default_button.dart';

class UpdateDialog{
  UpdateDialog();

  //showDeleteDialog
  Future<dynamic> showDialog({String text = "New version is available.\nPlease update the app.",String url = 'https://play.google.com/store/apps/details?id=com.mahmud.hidmona'}) {

    return showModal(
      context: Get.context!,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: WillPopScope(
          onWillPop: ()async{return false;},
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                SvgPicture.asset("assets/svgs/update.svg",height: 60,),
                const SizedBox(height: 25,),
                Text(text,textAlign: TextAlign.center,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150,
                      child: DefaultButton(
                        onTap: () async{
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            //throw 'Could not launch $url';
                          }
                        },
                        buttonText: "◄  Update  ►",
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