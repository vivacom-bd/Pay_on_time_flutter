import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/Set%20Pin/set_pin_successful_my_card_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Set%20Pin/set_pin_successful_loading_screen.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class DialogForSetPinMyCard extends StatelessWidget {
  const DialogForSetPinMyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find<CommonController>();
    TextEditingController pinController = TextEditingController();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Container(
        height: SizeConfig.screenHeight*0.25,
        width: double.infinity,
        margin: EdgeInsets.only(top:40, left: 8, right: 8),
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(),
          color:AppColor.boxColor,
        ),
        child: Column(
          children: [
            CustomTextFormField(
                controller: pinController,
                enabled: true,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Pin can't be empty";
                  }
                  return null;
                },
                labelText: "PIN",
                hindText: "Enter your PIN",
                keyboardType: TextInputType.text,
                onChanged: (value) {

                }
            ),
            const SizedBox(height: 20),
            DefaultButton(
              buttonText: "Set Pin",
              onTap: () async {
                if(pinController.text.isNotEmpty){
                  Utility.showLoadingDialog();
                  bool value = await commonController.cardPinSet(commonController.personalAccountCard.value.data![commonController.cardIndexNo].id!, pinController.text);
                  Get.back();
                  if(value){
                    Utility.showSnackBar(commonController.pinSet.value.reason!);
                    Get.to(const SetPinSuccessfulMyCardScreen());
                  }
                } else {Utility.showSnackBar("Pin Can't Empty");}
              },
            ),
          ],
        ),
      ),
    );
  }
}
