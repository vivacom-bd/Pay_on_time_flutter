import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/account_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:intl/intl.dart';

class AccountHolderScreen extends StatefulWidget {
  static const String routeName = "AccountHolderScreen";
  const AccountHolderScreen({Key? key}) : super(key: key);

  @override
  State<AccountHolderScreen> createState() => _AccountHolderScreenState();
}

class _AccountHolderScreenState extends State<AccountHolderScreen> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  TextEditingController accountCurrencyController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController givenNameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();
  String ? fullName;
  List<String> nameParts = [];

  void initState() {
    super.initState();
    setState(() {
      dobController.text = "";
      fullName = commonController.userProfile.value.fullName!;
      nameParts = fullName!.split(" ");
      givenNameController.text = nameParts.first;
      emailController.text = commonController.userProfile.value.email!;
      phoneNumberController.text = commonController.userProfile.value.phone!;
      nationalityController.text = commonController.countryFrom.value.iso3Code!;
      countryController.text = commonController.countryFrom.value.name!;
      //nationalityController.text = commonController.countryFrom.value.iso3Code!;
    });
  }

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
                    const SizedBox(width: 35,),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create a personal account",
                        style: TextStyle(
                          color: AppColor.defaultTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.stretch,
                              //   children: [
                              //     Text("Account Currency", style: TextStyle(
                              //         color: AppColor.textColor,
                              //         fontSize: 13,
                              //         fontWeight: FontWeight.bold),),
                              //     const SizedBox(height: 5,),
                              //     Container(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 20, vertical: 10),
                              //       clipBehavior: Clip.antiAlias,
                              //       decoration: BoxDecoration(
                              //         color: AppColor.boxColor,
                              //         borderRadius: BorderRadius.circular(5),
                              //       ),
                              //       child: CountryItem(
                              //         country: commonController.countryFrom.value, titleType: "currencyCode",color: AppColor.defaultTextColor,),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller:  familyNameController,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Family Name can't be empty";
                                    }
                                    return null;
                                  },
                                  labelText: "Family Name",
                                  enabled: true,
                                  hindText: "Enter your Family Name",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller:  givenNameController,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Given Name can't be empty";
                                    }
                                    return null;
                                  },
                                  labelText: "Given Name",
                                  enabled: true,
                                  hindText: "Enter your Given Name",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller:  countryController,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Nationality can't be empty";
                                    }
                                    return null;
                                  },
                                  labelText: "Nationality",
                                  enabled: true,
                                  hindText: "Enter your Nationality",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date of Birth",style: TextStyle(fontWeight: FontWeight.w600,color: AppColor.textColor),),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                      controller: dobController,
                                      validator: (value) {
                                        if (value != null && !_isDateFormatValid(value)) {
                                          return 'Invalid date format, try dd/MM/yyyy';
                                        }
                                        return null;
                                      },
                                      decoration:InputDecoration(
                                        contentPadding: const EdgeInsets.only(top: 12,bottom: 12,left: 10,right: 0),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        disabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                          ),
                                        ),
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.grey.withOpacity(.2),
                                        //focusColor: Colors.black,
                                        //labelText: labelText,
                                        errorStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.red),
                                        hintText: "Enter Date of Birth",
                                        hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                        labelStyle: TextStyle(color: AppColor.defaultColorLight,fontWeight: FontWeight.w500,fontSize: 12),
                                      ),
                                      readOnly: true,  // when true user cannot edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2100)
                                        );
                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                          DateFormat('dd/MM/yyyy').format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            dobController.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {}

                                        //when click we have to show the datepicker
                                      }
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller:  emailController,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "email can't be empty";
                                    }
                                    return null;
                                  },
                                  labelText: "Email",
                                  enabled: true,
                                  hindText: "Enter your Email",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {

                                  }
                              ),
                              const SizedBox(height: 10,),
                              CustomTextFormField(
                                  controller:  phoneNumberController,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Phone number can't be empty";
                                    }
                                    return null;
                                  },
                                  labelText: "Phone nUmber",
                                  enabled: true,
                                  hindText: "Enter your Phone Number",
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                  }
                              ),
                              const SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultButton(
                  buttonText: "Confirm",
                  onTap: () async {
                    //Get.to(const AccountScreen());
                    if(_formKey.currentState!.validate()){
                      print("${familyNameController.text},\n${givenNameController.text},\n${nationalityController.text},\n${dobController.text},\n${phoneNumberController.text},\n${emailController.text},");
                      Utility.showLoadingDialog();
                      bool value = await commonController.createAccount(
                        commonController.userProfile.value.id!,
                        familyNameController.text,
                        givenNameController.text,
                        nationalityController.text,
                        dobController.text,
                        phoneNumberController.text,
                        emailController.text,
                      );
                      if(value){
                        bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                        Get.back();
                        if(value){
                          //print(commonController.currentPersonalAccount.value.success);
                          Get.to(()=> const AccountScreen());
                        }
                      }else{Get.back();}
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

  bool _isDateFormatValid(String dateString){
    try{
      DateFormat('dd/MM/yyyy').parseStrict(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
