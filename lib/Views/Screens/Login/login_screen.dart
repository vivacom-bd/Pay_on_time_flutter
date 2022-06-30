import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Repositories/user_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Screens/Login/reset_password_screen.dart';
import 'package:hidmona/Views/Screens/Login/signup_screen.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

import '../../Widgets/country_item.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  CommonController controller = Get.find<CommonController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<bool> isPasswordHide = true.obs;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Obx((){
                          if(controller.serverCountries.isEmpty){
                            return SpinKitCircle(color: Get.theme.primaryColor,);
                          }else{
                            return Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Text(
                                  //   'Select country',
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //     color: AppColor.textColor,
                                  //     fontSize: 14.0,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 7,),
                                  // InkWell(
                                  //   onTap: (){
                                  //     _openCountryPickerDialog();
                                  //   },
                                  //   child: Container(
                                  //     height: 45,
                                  //     clipBehavior: Clip.antiAlias,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey.withOpacity(.2),
                                  //       borderRadius  : BorderRadius.circular(10),
                                  //     ),
                                  //     child: Row(
                                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                                  //       children: [
                                  //         Expanded(
                                  //           child: Container(padding: const EdgeInsets.only(left: 10),child: CountryItem(country: controller.countryFrom.value)),
                                  //         ),
                                  //         Container(
                                  //             padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20) ,
                                  //             decoration: BoxDecoration(
                                  //               gradient: AppGradient.getColorGradient('default')
                                  //             ),
                                  //             child: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,size: 30,)
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 7,),
                                  CustomTextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "Email can't be empty";
                                        }
                                        return null;
                                      },
                                      labelText: "Email",
                                      hindText: "example@domain.com",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  Obx((){
                                    return CustomTextFormField(
                                        controller: passwordController,
                                        obscureText: isPasswordHide.value,
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
                                            isPasswordHide.toggle();
                                          },
                                          child: Icon(isPasswordHide.value? Icons.visibility : Icons.visibility_off,color: AppColor.textColor,size: 25,),
                                        ),
                                        labelText: "Password",
                                        hindText: "*******",
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {

                                        }
                                    );
                                  }),
                                  const SizedBox(height: 20,),
                                  DefaultButton(buttonText: "Login", onTap: (){

                                    FocusScope.of(context).unfocus();

                                    if(_formKey.currentState!.validate()){

                                      Utility.showLoadingDialog();

                                      UserRepository.customerLogin(emailController.text, passwordController.text).then((value)async{
                                        if(value.data != null){
                                          controller.currentUser.value = value.data!;

                                          controller.getStorage.write("email", emailController.text);
                                          controller.getStorage.write("password", passwordController.text);

                                          //get User Profile
                                          var userProfileResponse =  await UserRepository.getUserProfile();
                                          if(userProfileResponse.data != null){
                                            controller.userProfile.value = userProfileResponse.data!;
                                            if(controller.userProfile.value.country != null){
                                              List<ServerCountry> countries = controller.serverCountries.where((country) => controller.userProfile.value.country!.id == country.id).toList();
                                              if (countries.isNotEmpty) {
                                                //serverCountryFrom.value = userProfile.value.country!;
                                                controller.countryFrom.value = CountryPickerUtils.getCountryByIsoCode(countries.first.countryCode!);
                                              }
                                            }
                                          }

                                          Get.back();
                                          Get.offAll(()=> const HomeScreen());

                                        }else{
                                          Get.back();
                                          Utility.showSnackBar(value.message??"An Error Occurred");
                                        }

                                      });
                                    }
                                  },),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.to(()=>const ResetPasswordScreen());
                                        },
                                        child: Text("Forgot password?",style: TextStyle(color: AppColor.defaultColor,fontWeight: FontWeight.bold,fontSize: 17),)
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  DefaultButton(linearGradient: AppGradient.getColorGradient("grey"),buttonText: "Signup", textColor: AppColor.defaultColorLight, onTap: (){

                                    FocusScope.of(context).unfocus();

                                    Get.to(()=>const SignUpScreen());

                                  },),
                                ],
                              ),
                            );
                          }
                        }),
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


  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: AppColor.defaultColor),
      child: CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: AppColor.defaultColor,
        searchInputDecoration: const InputDecoration(hintText: 'Search By Country...'),
        isSearchable: true,
        title: const Text('Select country',textAlign: TextAlign.center,),
        onValuePicked: (Country country){
            controller.countryFrom.value = country;
        },
        itemBuilder: (Country country)=>CountryItem(country: country),
        itemFilter: (c) => controller.serverCountries.map((element) => element.countryCode).contains(c.isoCode),
        //itemFilter: (c) => ['AGO', 'AUS', 'AUT', 'BHR', 'BEL'].contains(c.iso3Code),
        //itemFilter: (c)=>commonSingleTon.getCountries().map((e) => e.countryCode).contains(c.iso3Code),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('TR'),
        //   CountryPickerUtils.getCountryByIsoCode('US'),
        // ],
      ),
    ),
  );

}
