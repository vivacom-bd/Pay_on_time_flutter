import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/load_card_screen.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Widgets/custom_dialogbox.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:intl/intl.dart';


class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({Key? key}) : super(key: key);

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  final _formKey = GlobalKey<FormState>();


  CommonController commonController = Get.find<CommonController>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Row(
                  children: [
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
                                  'Verify OTP',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  'To login successful kindly enter the One Time Password (OTP) we just sent to your email. It will expire with in 2 minute',
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
                                const SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: ()   async {
                                        Utility.showLoadingDialog();
                                        bool value = await commonController.sendOTP();
                                        Get.back();
                                        if(value){
                                          Utility.showSnackBar("Otp send to your email again");
                                        } else {Get.back();}
                                      },
                                      child: Text(
                                        'Resend OTP',
                                        style: TextStyle(
                                          color: AppColor.hyperlinkColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
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
                  buttonText: "Verify",
                  onTap: () async {
                    Utility.showLoadingDialog();
                    bool value = await commonController.verifyOTP(int.parse(otpController.text));
                    Get.back();
                    if(value){
                      Get.find<CommonController>().getStorage.write("loginChecker", true);
                      Get.offAll(()=> const HomeScreen());
                      //bool value = await commonController.kycUserData();
                      // if(value){
                      //   Get.find<CommonController>().getStorage.write("loginChecker", true);
                      //   Get.offAll(()=> const HomeScreen());
                      // }
                      //Get.offAll(()=> const HomeScreen());
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
