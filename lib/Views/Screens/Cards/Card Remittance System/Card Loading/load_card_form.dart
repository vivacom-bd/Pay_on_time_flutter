import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/load_card_successful.dart';
import 'package:hidmona/Views/Widgets/custom_dropdown_form_field.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

import 'package:hidmona/Models/Card%20Remittance%20System/personal_account_card.dart';

class LoadCardForm extends StatefulWidget {
  const LoadCardForm({Key? key}) : super(key: key);

  @override
  State<LoadCardForm> createState() => _LoadCardFormState();
}

class _LoadCardFormState extends State<LoadCardForm> {
  Data ? destinationCard;
  int ? destinationCardId;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController currentBalanceController = TextEditingController();
  TextEditingController topUpAmountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController destinationBalanceController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();
  @override
  void initState() {
    setState(() {
      accountHolderController.text = (commonController.personalAccountCard.value.data![0].cardHolder != null) ? commonController.personalAccountCard.value.data![0].cardHolder! : "";
      currentBalanceController.text = (commonController.getAccountDetails.value.data![0].bankAccountDetails!.balance != null) ? commonController.getAccountDetails.value.data![0].bankAccountDetails!.balance! : "0.0";
      destinationBalanceController.text = (commonController.personalAccountCard.value.data![commonController.cardIndexNo].balance != null) ? (commonController.personalAccountCard.value.data![commonController.cardIndexNo].balance!.toString()) : "0";
      currencyController.text = "EUR";
    });
    // TODO: implement initState
    super.initState();
  }

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
                          child:  Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Load Card',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Load your card with funds from your account.',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  'Source Account :',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                CustomTextFormField(
                                    controller: accountHolderController,
                                    enabled: false,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Account Holder can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Account Holder",
                                    hindText: "Enter Account Holder",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                                const SizedBox(height: 10,),
                                CustomTextFormField(
                                    controller: currencyController,
                                    enabled: false,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Currency can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Currency",
                                    hindText: "Enter your Currency",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                                const SizedBox(height: 10,),
                                CustomTextFormField(
                                    controller: currentBalanceController,
                                    enabled: false,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Current Balance can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Current Balance",
                                    hindText: "Enter your Current Balance",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                                const SizedBox(height: 10,),
                                CustomTextFormField(
                                    controller: topUpAmountController,
                                    enabled: true,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Top Up Amount can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Top Up Amount",
                                    hindText: "Top Up Amount",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                                const SizedBox(height: 10,),
                                CustomTextFormField(
                                    controller: noteController,
                                    enabled: true,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return null;
                                      }
                                      return null;
                                    },
                                    labelText: "Note or Comment",
                                    hindText: "Note or Comment",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),

                                const SizedBox(height: 20,),
                                Text(
                                  'Destination Card:',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Select Card', style: TextStyle(fontWeight: FontWeight.w600,color: AppColor.textColor),),
                                      const SizedBox(height: 7,),
                                      CustomDropDownFromField(
                                          validator: (value) {
                                            if (value == null) {
                                              return "Select mode of receive";
                                            }
                                            return null;
                                          },

                                          items: commonController.personalAccountCard.value.data?.map((personalCard){
                                            return DropdownMenuItem(
                                                value: personalCard,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 15.0),
                                                  child: Text("${personalCard.cardHolder}", style: TextStyle(fontSize: 16.0,color: AppColor.defaultTextColor),),
                                                )
                                            );
                                          }).toList(),
                                          selectedValue: destinationCard,
                                          labelAndHintText: "Select Card",
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(bottom: 4.0),
                                            child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                          ),
                                          filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                                          onChanged: (value) {
                                            setState(() {
                                              destinationCard = value as Data?;
                                              destinationCardId = value!.id;
                                              print('${destinationCardId}');
                                            });
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                CustomTextFormField(
                                    controller: destinationBalanceController,
                                    enabled: false,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Current Balance can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "Current Balance",
                                    hindText: "Current Balance",
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
                  buttonText: "Submit",
                  onTap: () async {
                    print("${destinationCardId} ${commonController.getAccountDetails.value.data![0].id!}");
                    Utility.showLoadingDialog();
                    bool value = await commonController.loadingCard(destinationCardId!,commonController.getAccountDetails.value.data![0].id!,int.parse(topUpAmountController.text));
                    Get.back();
                    if(value){
                      Utility.showSnackBar(commonController.cardLoading.value.reason!);
                      Get.to(()=> const LoadCardSuccessful());
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
