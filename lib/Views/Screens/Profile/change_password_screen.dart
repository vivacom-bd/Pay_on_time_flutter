import 'package:country_currency_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/user_profile.dart';
import 'package:hidmona/Repositories/user_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = "/ChangePasswordScreen";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  CommonController commonController = Get.find<CommonController>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isOldPasswordHide = true.obs;
  var isNewPasswordHide = true.obs;
  var isConfirmPasswordHide = true.obs;


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
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
                  child: Obx(()=>Column(
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
                                  controller: oldPasswordController,
                                  obscureText: isOldPasswordHide.value,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Password can't be empty";
                                    }else if(value.length <8){
                                      return "Password at least 8 digits";
                                    }
                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      isOldPasswordHide.toggle();
                                    },
                                    child: Icon(isOldPasswordHide.value? Icons.visibility : Icons.visibility_off,color: AppColor.textColor,size: 25,),
                                  ),
                                  labelText: "Current Password",
                                  hindText: "*******",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller: newPasswordController,
                                  obscureText: isNewPasswordHide.value,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Password can't be empty";
                                    }else if(value.length <8){
                                      return "Password at least 8 digits";
                                    }
                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      isNewPasswordHide.toggle();
                                    },
                                    child: Icon(isNewPasswordHide.value? Icons.visibility : Icons.visibility_off,color: AppColor.textColor,size: 25,),
                                  ),
                                  labelText: "New Password",
                                  hindText: "*******",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: isConfirmPasswordHide.value,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Password can't be empty";
                                    }else if(value != newPasswordController.text){
                                      return "Password does not match";
                                    }
                                    return null;
                                  },
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      isConfirmPasswordHide.toggle();
                                    },
                                    child: Icon(isConfirmPasswordHide.value? Icons.visibility : Icons.visibility_off,color: AppColor.textColor,size: 25,),
                                  ),
                                  labelText: "Current Password",
                                  hindText: "*******",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 20,),
                              DefaultButton(buttonText: "Submit", onTap: (){

                                FocusScope.of(context).unfocus();

                                if(_formKey.currentState!.validate()){

                                  Utility.showLoadingDialog();

                                  UserRepository.changePassword(oldPasswordController.text,newPasswordController.text).then((value){
                                    if(value.error==false && value.data != null){
                                      Get.back();
                                      Utility.showSnackBar(value.data??"An Error Occurred",durationInSeconds: 3);

                                      logout();
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
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  logout(){
    commonController.getStorage.erase();
    commonController.currentUser.value = AppUser();
    commonController.userProfile.value = UserProfile();
    commonController.countryTo.value = Country();
    commonController.countryFrom.value = Country();
    Get.offAll(()=>const LoginScreen());
  }
}
