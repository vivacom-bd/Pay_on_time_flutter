import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/user_signup.dart';
import 'package:hidmona/Repositories/user_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:libphonenumber/libphonenumber.dart';

import '../../Widgets/country_item.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/SignUpScreen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  CommonController commonController = Get.find<CommonController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  // TextEditingController usernameController = TextEditingController();
  // TextEditingController dateOfBirthController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController postCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<bool> isPasswordHide = true.obs;
  Rx<bool> isConfirmPasswordHide = true.obs;

  final _formKey = GlobalKey<FormState>();


  Country? selectedCountry;
  Country? selectedCitizenCountry;
  //City? selectedCity;
  //DateTime? dateOfBirth;


  bool isPhoneNumberValid = false;

  // RxList<City> countryCities = <City>[].obs;

  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Obx((){
                        if(commonController.serverCountries.isEmpty){
                          return SpinKitCircle(color: Get.theme.primaryColor,);
                        }else{
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CustomTextFormField(
                                    controller: fullNameController,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Name can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Full Name",
                                    hindText: "Enter your full name",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                                const SizedBox(height: 10,),
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
                                const SizedBox(height: 10,),
                                // InkWell(
                                //   onTap: ()async{
                                //     dateOfBirth = await showDatePicker(
                                //       initialEntryMode: DatePickerEntryMode.calendar,
                                //       context: context,
                                //       initialDate: dateOfBirth ?? DateTime.now(),
                                //       firstDate: DateFormat("dd-mm-yyyy").parse("01-01-1930"),
                                //       lastDate: DateTime.now(),
                                //       currentDate: DateTime.now(),
                                //       builder: (context,child) {
                                //         return Theme(
                                //           data: Get.theme.copyWith(
                                //             colorScheme: Get.theme.colorScheme.copyWith(primary: Theme.of(context).primaryColor),
                                //             buttonTheme: const ButtonThemeData(
                                //                 textTheme: ButtonTextTheme.primary
                                //             ),
                                //           ),
                                //           child: child!,
                                //         );
                                //       },
                                //     );
                                //
                                //     if(dateOfBirth!=null) {
                                //
                                //       dateOfBirthController.text = DateFormat("dd MMM, yyyy").format(dateOfBirth!);
                                //       //FocusScope.of(context).requestFocus(FocusNode());
                                //     }
                                //   },
                                //   child: CustomTextFormField(
                                //       controller: dateOfBirthController,
                                //       enabled: false,
                                //       validator: (value) {
                                //         if(value!.isEmpty){
                                //           return "Field can't be empty";
                                //         }
                                //         return null;
                                //       },
                                //       labelText: "Date Of Birth",
                                //       hindText: "Enter your date of birth",
                                //       keyboardType: TextInputType.text,
                                //       onChanged: (value) async{
                                //
                                //       }
                                //   ),
                                // ),
                                // const SizedBox(height: 10,),
                                Text(
                                  'Select Country',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                InkWell(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    _openCountryPickerDialog();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CountryItem(country: selectedCountry,titleType: "name",),
                                          Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                        ],
                                      )
                                  ),
                                ),
                                // const SizedBox(height: 10,),
                                // Text(
                                //   'Select City',
                                //   style: TextStyle(
                                //     color: AppColor.textColor,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14,
                                //   ),
                                // ),
                                // const SizedBox(height: 7,),
                                // CustomDropDownFromField(
                                //     validator: (value) {
                                //       if (value == null) {
                                //         return "Select city";
                                //       }
                                //       return null;
                                //     },
                                //
                                //     items: countryCities.map((City city) {
                                //       return DropdownMenuItem(
                                //           value: city,
                                //           child: Text(city.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                                //       );
                                //     }).toList(),
                                //     selectedValue: selectedCity,
                                //     labelAndHintText: "Select city",
                                //     suffixIcon: Padding(
                                //       padding: const EdgeInsets.only(bottom: 4.0),
                                //       child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                //     ),
                                //     filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                                //     onChanged: (value) {
                                //       setState(() {
                                //         selectedCity = value as City;
                                //       });
                                //     }
                                // ),
                                // const SizedBox(height: 10,),
                                // CustomTextFormField(
                                //     controller: addressController,
                                //     validator: (value) {
                                //       if(value!.isEmpty){
                                //         return "Address can't be empty";
                                //       }
                                //       return null;
                                //     },
                                //     labelText: "Address",
                                //     hindText: "Enter Address",
                                //     keyboardType: TextInputType.text,
                                //     onChanged: (value) {
                                //
                                //     }
                                // ),
                                // const SizedBox(height: 10,),
                                // CustomTextFormField(
                                //     controller: postCodeController,
                                //     validator: (value) {
                                //       if(value!.isEmpty){
                                //         return "Postal Code can't be empty";
                                //       }else if(int.tryParse(value)==null){
                                //         return "Enter correct postal code";
                                //       }
                                //       return null;
                                //     },
                                //     labelText: "Postal Code",
                                //     hindText: "Enter Postal Code",
                                //     keyboardType: TextInputType.number,
                                //     onChanged: (value) {
                                //
                                //     }
                                // ),
                                const SizedBox(height: 10,),
                                Text(
                                  'Phone No.',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        FocusScope.of(context).unfocus();
                                        if(selectedCountry==null) _openCountryPickerDialog();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.2),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              CountryItem(country: selectedCountry,titleType: "flag",),
                                              //const Icon(Icons.arrow_drop_down)
                                            ],
                                          )
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Expanded(
                                      child: CustomTextFormField(
                                          controller: phoneController,
                                          validator: (value) {
                                            if(value!.isEmpty){
                                              return "Field can't be empty";
                                            }else{
                                              if(value.length<7) return "Phone number is not valid formatted";

                                              phoneNumberValidator(value);

                                              if(!isPhoneNumberValid){
                                                return "Phone number is not valid formatted";
                                              }
                                            }
                                          },
                                          labelText: "",
                                          hindText: "Enter phone number",
                                          keyboardType: TextInputType.phone,
                                          onChanged: (value) {

                                          }
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 10,),
                                // Text(
                                //   'Select Citizen Country',
                                //   style: TextStyle(
                                //     color: AppColor.textColor,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14,
                                //   ),
                                // ),
                                // const SizedBox(height: 7,),
                                // InkWell(
                                //   onTap: (){
                                //     FocusScope.of(context).unfocus();
                                //     _openCountryPickerDialog(type: "Citizen");
                                //   },
                                //   child: Container(
                                //       padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                                //       decoration: BoxDecoration(
                                //         color: Colors.grey.withOpacity(.2),
                                //         borderRadius: BorderRadius.circular(4),
                                //       ),
                                //       child: Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           CountryItem(country: selectedCitizenCountry),
                                //           Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                //         ],
                                //       )
                                //   ),
                                // ),
                                // const SizedBox(height: 10,),
                                // CustomTextFormField(
                                //     controller: usernameController,
                                //     validator: (value) {
                                //       if(value!.isEmpty){
                                //         return "Username can't be empty";
                                //       }
                                //       return null;
                                //     },
                                //     labelText: "Username",
                                //     hindText: "Username",
                                //     keyboardType: TextInputType.text,
                                //     onChanged: (value) {
                                //
                                //     }
                                // ),
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
                                const SizedBox(height: 10,),
                                Obx((){
                                  return CustomTextFormField(
                                      controller: confirmPasswordController,
                                      obscureText: isConfirmPasswordHide.value,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "Field can't be empty";
                                        }else if(value != passwordController.text){
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
                                      labelText: "Confirm Password",
                                      hindText: "*******",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  );
                                }),
                                const SizedBox(height: 20,),
                                DefaultButton(buttonText: "Sign up", onTap: (){

                                  FocusScope.of(context).unfocus();

                                  if(_formKey.currentState!.validate()){

                                    if(selectedCountry==null){
                                      Utility.showSnackBar("Please select country");
                                      return;
                                    }

                                    Utility.showLoadingDialog();

                                    UserSignupRequest userSignupRequest = UserSignupRequest(
                                      email: emailController.text,
                                      fullName: fullNameController.text,
                                      //dateOfBirth: DateFormat("yyyy-MM-dd").format(dateOfBirth!),
                                      countryId: commonController.getServerCountryFromCountryCode(selectedCountry!.isoCode!).id,
                                      // citizenCountryId: commonController.getServerCountryFromCountryCode(selectedCitizenCountry!.isoCode!).id,
                                      // isCitizen: commonController.getServerCountryFromCountryCode(selectedCountry!.isoCode!).id == commonController.getServerCountryFromCountryCode(selectedCitizenCountry!.isoCode!).id,
                                      // cityId: selectedCity!.id!,
                                      // streetAddress: addressController.text,
                                      // postalCode: int.parse(postCodeController.text),
                                      phone: phoneNumber,
                                      // username: usernameController.text,
                                      password: passwordController.text
                                    );

                                    UserRepository.signUp(userSignupRequest).then((value){
                                      if(value.data != null){

                                        Get.back();
                                        Get.back();
                                        Utility.showSnackBar(value.message??"Signed up successfully");

                                      }else{
                                        Get.back();
                                        Utility.showSnackBar(value.message??"An Error Occurred");
                                      }

                                    });
                                  }
                                },),
                                const SizedBox(height: 20,),
                                DefaultButton(linearGradient: AppGradient.getColorGradient("grey"),buttonText: "Login", textColor: AppColor.defaultColorLight, onTap: (){

                                  FocusScope.of(context).unfocus();
                                  Get.back();

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
          ],
        ),
      ),
    );
  }


  void _openCountryPickerDialog({String type = "Country"}) => showDialog(
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
          if(type == "Country"){
            setState(() {
              selectedCountry = country;
              phoneController.text = "+${selectedCountry!.phoneCode??""}";
              //getCities();
            });
          }else if(type == "Citizen"){
            setState(() {
              selectedCitizenCountry = country;
            });
          }
        },
        itemBuilder: (Country country)=>CountryItem(country: country),
        itemFilter: (c) => commonController.serverCountries.map((element) => element.countryCode).contains(c.isoCode),
        //itemFilter: (c) => ['AGO', 'AUS', 'AUT', 'BHR', 'BEL'].contains(c.iso3Code),
        //itemFilter: (c)=>commonSingleTon.getCountries().map((e) => e.countryCode).contains(c.iso3Code),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('TR'),
        //   CountryPickerUtils.getCountryByIsoCode('US'),
        // ],
      ),
    ),
  );


  void phoneNumberValidator(String value){

    Future.delayed(const Duration(seconds: 1),(){
      PhoneNumberUtil.normalizePhoneNumber(phoneNumber: value, isoCode: selectedCountry!.isoCode!).then((normalizedPhoneNumber){
        PhoneNumberUtil.isValidPhoneNumber(phoneNumber: normalizedPhoneNumber!, isoCode:selectedCountry!.isoCode!).then((isPhoneValid){

          if(isPhoneValid!){
            phoneNumber = normalizedPhoneNumber;
            print(phoneNumber);
          }

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if(mounted){
              setState(() {
                isPhoneNumberValid = isPhoneValid;
              });
            }
          });
        });
      });
    });
  }


  // void getCities() async{
  //   APIResponse<List<City>> apiResponse1 = await CommonRepository.getCities(commonController.getServerCountryFromCountryCode(selectedCountry!.isoCode!).id!);
  //   if(apiResponse1.data != null){
  //     selectedCity=null;
  //     countryCities.clear();
  //     countryCities.addAll(apiResponse1.data!);
  //   }else{
  //     Utility.showSnackBar(apiResponse1.message??"An error Occurred");
  //   }
  // }

}
