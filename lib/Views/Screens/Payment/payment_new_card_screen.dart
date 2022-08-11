import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/card_info.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/payment_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/payment_dialog.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:intl/intl.dart';

class PaymentWithNewCardScreen extends StatefulWidget {
  static const String routeName = "/PaymentWithNewCard";

  const PaymentWithNewCardScreen({Key? key, required this.transactionNumber}) : super(key: key);

  final String transactionNumber;

  @override
  _PaymentWithNewCardScreenState createState() => _PaymentWithNewCardScreenState();
}

class _PaymentWithNewCardScreenState extends State<PaymentWithNewCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberTextEditingController = TextEditingController();
  final TextEditingController securityCodeTextEditingController = TextEditingController();
  final TextEditingController expiryDateTextEditingController = TextEditingController();
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController billingAddressTextEditingController = TextEditingController();
  final TextEditingController billingPostCodeTextEditingController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();

  DateTime? dateTime;

  bool isCardSave = false;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("Add Card Details"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppGradient.getColorGradient("default"),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 7),
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.dropdownBoxColor.withOpacity(0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                        controller: cardNumberTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "Card Number",
                        hindText: "",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {

                        }
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                        dateTime = await DatePicker.showPicker(context,

                            pickerModel: CustomMonthPicker(
                            minTime: DateTime.now(),
                              maxTime: DateTime(DateTime.now().year+20),
                              currentTime: DateTime.now()
                            )

                        );

                        if(dateTime!=null) {
                          expiryDateTextEditingController.text = DateFormat("MM/yyyy").format(dateTime!);
                          //FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                      child: CustomTextFormField(
                          controller: expiryDateTextEditingController,
                          enabled: false,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Field can't be empty";
                            }
                            return null;
                          },
                          labelText: "Expiry Date",
                          hindText: "",
                          keyboardType: TextInputType.text,
                          onChanged: (value) async{

                          }
                      ),
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                        controller: securityCodeTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "CVV Number",
                        hindText: "",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {

                        }
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                        controller: firstNameTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "First Name",
                        hindText: "",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {

                        }
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                        controller: lastNameTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "Last Name",
                        hindText: "",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {

                        }
                    ),
                    if(isCardSave)const SizedBox(height: 10,),
                    if(isCardSave)CustomTextFormField(
                        controller: billingAddressTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "Billing Address",
                        hindText: "",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {

                        }
                    ),
                    if(isCardSave)const SizedBox(height: 10,),
                    if(isCardSave) CustomTextFormField(
                        controller: billingPostCodeTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "Billing PostCode",
                        hindText: "",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {

                        }
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Checkbox(activeColor: AppColor.defaultColor,value: isCardSave, onChanged: (value){
                          setState(() {
                            isCardSave = value!;
                          });
                        }),
                        Expanded(
                          child: Text("Save Card Details", style: TextStyle(color: AppColor.defaultColor,fontWeight: FontWeight.w700,fontSize: 15),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),

              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: DefaultButton(
                  buttonText: "Submit", onTap: () async{
                  FocusScope.of(context).unfocus();
                  if(_formKey.currentState!.validate()){

                    Utility.showLoadingDialog();

                    CardInfo cardInfo = CardInfo(
                        pan: cardNumberTextEditingController.text,
                        expiryDate: DateFormat("MM/yyyy").format(dateTime!),
                        securityCode: securityCodeTextEditingController.text,
                        firstName: firstNameTextEditingController.text,
                        lastName: lastNameTextEditingController.text,
                        billingPremise: billingAddressTextEditingController.text,
                        billingPostcode: billingPostCodeTextEditingController.text
                    );

                    APIResponse<bool> apiResponse;
                    if(isCardSave){
                      apiResponse = await PaymentRepository.paymentAndSaveCard(cardInfo, commonController.currentTransaction!.transactionNumber!);
                    }else{
                      apiResponse = await PaymentRepository.paymentWithoutSaveCard(cardInfo, commonController.currentTransaction!.transactionNumber!);
                    }


                    Get.back();

                    if(apiResponse.data != null && apiResponse.data!){
                      PaymentDialog.showDialog();
                    }else{
                      Utility.showSnackBar(apiResponse.message?? "An Error Occurred",durationInSeconds: 5);
                    }

                  }
                },),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }

}



class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({required DateTime currentTime,required DateTime minTime,required DateTime maxTime,
    LocaleType? locale}) : super(locale: locale, minTime: minTime, maxTime:
  maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}
