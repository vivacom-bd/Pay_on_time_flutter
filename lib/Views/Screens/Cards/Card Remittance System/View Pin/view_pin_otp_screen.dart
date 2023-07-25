import 'package:country_currency_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/load_card_screen.dart';
import 'package:hidmona/Views/Widgets/custom_dialogbox.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';


class ViewPinOtpScreen extends StatefulWidget {
  const ViewPinOtpScreen({Key? key}) : super(key: key);

  @override
  State<ViewPinOtpScreen> createState() => _ViewPinOtpScreenState();
}

class _ViewPinOtpScreenState extends State<ViewPinOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  CommonController commonController = Get.find<CommonController>();
  TextEditingController otpController = TextEditingController();

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
                                  'View Card PIN',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  'To view the card PIN kindly enter the One Time Password (OTP) we just sent to your email.',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                CustomTextFormField(
                                    controller: otpController,
                                    enabled: true,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "OTP can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "OTP Code",
                                    hindText: "OTP Code",
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
                  buttonText: "View Pin",
                  onTap: () async {
                    //Get.to(()=> const LoadCardScreen());
                    Utility.showLoadingDialog();
                    bool value = await commonController.verifyOTP(int.parse(otpController.text));
                    if(value){
                      bool value = await commonController.getCardPin(commonController.userProfile.value.id!,commonController.personalAccountCard.value.data![0].id!);
                      Get.back();
                      if(value){
                        DefaultDialogs(context: context).showDialog(title: "View Pin", text: "Your Pin is ${commonController.cardPin.value.pin}",
                          onSubmit: () {
                            Get.to(()=> const LoadCardScreen());
                          },
                          onSubmitText: "Ok",
                        );
                        print(commonController.cardPin.value.pin);
                      }
                    } else {Get.back();}

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
