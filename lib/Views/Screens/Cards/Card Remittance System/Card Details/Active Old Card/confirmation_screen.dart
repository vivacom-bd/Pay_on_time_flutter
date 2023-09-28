import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/my_card_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/load_card_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/View%20Pin/view_pin_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';


class CardConfirmationAfterOldCardActiveScreen extends StatefulWidget {
  const CardConfirmationAfterOldCardActiveScreen({Key? key}) : super(key: key);

  @override
  State<CardConfirmationAfterOldCardActiveScreen> createState() => _CardConfirmationAfterOldCardActiveScreenState();
}

class _CardConfirmationAfterOldCardActiveScreenState extends State<CardConfirmationAfterOldCardActiveScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          _globalKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: AppColor.defaultColorLight,
                        ),
                      ),
                      const SizedBox(width: 40,),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Card Activation Confirmation",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 3,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 0),
                    padding: const EdgeInsets.only(left: 8.0, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.dropdownBoxColor.withOpacity(0.39),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Your prepaid card has been activated successfully!",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 25),
                              DefaultButton(
                                buttonText: "View card details",
                                onTap: () async {

                                  Get.to(const MyCardScreen());
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}