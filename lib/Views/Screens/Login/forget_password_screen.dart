import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Repositories/user_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';
import 'package:hidmona/Views/Screens/Login/signup_screen.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

import '../../Widgets/country_item.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "/ForgetPasswordScreen";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  TextEditingController emailController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(AppImage.getPath("splash_top"),width: SizeConfig.screenHeight,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(AppImage.getPath("splash_bottom"),width: SizeConfig.screenHeight,),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.7,),),
                      const SizedBox(height: 150.0),
                      Container(
                        alignment: Alignment.center,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomTextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Email can't be empty";
                                    }else if(!value.isEmail){
                                      return "Enter correct email address";
                                    }
                                    return null;
                                  },
                                  labelText: "Email",
                                  hindText: "example@domain.com",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 20,),
                              DefaultButton(buttonText: "Submit", onTap: (){

                                FocusScope.of(context).unfocus();

                                if(_formKey.currentState!.validate()){

                                  Utility.showLoadingDialog();

                                  UserRepository.forgetPassword(emailController.text).then((value){
                                    if(value.data != null){
                                      Get.back();
                                      Utility.showSnackBar(value.data??"An Error Occurred",durationInSeconds: 3);
                                    }else{
                                      Get.back();
                                      Utility.showSnackBar(value.message??"An Error Occurred",durationInSeconds: 2);
                                    }

                                  });
                                }
                              },),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
