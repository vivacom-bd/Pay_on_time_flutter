import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_confirmation_after_active.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class ActivateYourCardScreen extends StatefulWidget {
  const ActivateYourCardScreen({Key? key}) : super(key: key);

  @override
  State<ActivateYourCardScreen> createState() => _ActivateYourCardScreenState();
}

class _ActivateYourCardScreenState extends State<ActivateYourCardScreen> {

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CommonController commonController = Get.find<CommonController>();
  TextEditingController cardDigitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
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
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Activate your Card',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  'Please activate your card by entering the last four digits from your card number.',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                CustomTextFormField(
                                    controller: cardDigitController,
                                    enabled: true,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Field can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Enter the last four digits",
                                    hindText: "Enter the last four digits",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                              ],
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                DefaultButton(
                  buttonText: "Activate card",
                  onTap: () async {
                    // Get.to(const CardConfirmationScreen());
                    Utility.showLoadingDialog();
                    bool value = await commonController.activeCard(commonController.userProfile.value.id!, commonController.personalAccountCard.value.data![commonController.personalAccountCard.value.data!.length - 1 ].id!,cardDigitController.text);
                    if(value){
                      bool value = await commonController.getCardStatus(commonController.userProfile.value.id!, commonController.personalAccountCard.value.data![commonController.personalAccountCard.value.data!.length - 1].id!);
                      Get.back();
                      if(value){
                        Get.to(const CardConfirmationAfterActiveScreen());
                        //Utility.showSnackBar(commonController.cardActive.value.message!);
                      }else{Get.back();}
                    }else{
                      Get.back();
                    }
                  },
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
