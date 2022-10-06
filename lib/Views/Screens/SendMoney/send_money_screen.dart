import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/currency_conversion_details.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/server_currency.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/SendMoney/recepient_details_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/custom_dropdown_form_field.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:hidmona/Views/Widgets/sendmoneycalculationitem.dart';

class SendMoneyScreen extends StatefulWidget {
  static const String routeName = "/SendMoneyScreen";

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountTextEditingController = TextEditingController();
  Rx<double> inputAmount = 0.0.obs;
  CommonController commonController = Get.find<CommonController>();


  @override
  void initState() {
    super.initState();
    commonController.selectedModeOfPayment = null;
    commonController.selectedModeOfReceive = null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("Send Money"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppGradient.getColorGradient("default"),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColor.dropdownBoxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("I'm sending from", style: TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 5,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 7),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: AppColor.defaultColorLight,
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: AppGradient.getColorGradient("default-horizontal")
                                    ),
                                    child: CountryItem(
                                        country: commonController.countryFrom.value, titleType: "iso3Code",),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("I'm sending to", style: TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 5,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: AppColor.defaultColorLight,
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: AppGradient.getColorGradient("default-horizontal")
                                    ),
                                    child: CountryItem(
                                        country: commonController.countryTo.value,  titleType: "iso3Code",),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Center(
                                child: Text('Mode of Receive', style: TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w600, fontSize: 17,),),
                              ),
                              const SizedBox(height: 7,),
                              CustomDropDownFromField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Select mode of receive";
                                    }
                                    return null;
                                  },

                                  items: commonController.modeOfReceives.map((ModeOfPayment modeOfReceive) {
                                    return DropdownMenuItem(
                                        value: modeOfReceive,
                                        child: Text(modeOfReceive.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                                    );
                                  }).toList(),
                                  selectedValue: commonController.selectedModeOfReceive,
                                  labelAndHintText: "Select mode of receive",
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                  ),
                                  filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                                  onChanged: (value) {
                                    setState(() {
                                      commonController.selectedModeOfReceive = value as ModeOfPayment;
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.dropdownBoxColor.withOpacity(0.3),
                    ),
                    child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('From Currency', style: TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w600, fontSize: 14,),),
                                    const SizedBox(height: 7,),
                                    CustomDropDownFromField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Select Currency";
                                          }
                                          return null;
                                        },

                                        items: commonController.serverCountryFrom.value.currencies!.map((ServerCurrency currency) {
                                          return DropdownMenuItem(
                                              value: currency,
                                              child: Text(currency.code!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                                          );
                                        }).toList(),
                                        selectedValue: commonController.serverCountryFrom.value.selectedCurrency,
                                        labelAndHintText: "From currency",
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                        ),
                                        filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                                        onChanged: (value) {
                                          setState(() {
                                            commonController.serverCountryFrom.value.selectedCurrency = value as ServerCurrency;
                                          });
                                        }
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('To Currency', style: TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w600, fontSize: 14,),),
                                    const SizedBox(height: 7,),
                                    CustomDropDownFromField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Select Currency";
                                          }
                                          return null;
                                        },

                                        items: commonController.serverCountryTo.value.currencies!.map((ServerCurrency currency) {
                                          return DropdownMenuItem(
                                              value: currency,
                                              child: Text(currency.code!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                                          );
                                        }).toList(),
                                        selectedValue: commonController.serverCountryTo.value.selectedCurrency,
                                        labelAndHintText: "To currency",
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                        ),
                                        filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                                        onChanged: (value) {
                                          setState(() {
                                            commonController.serverCountryTo.value.selectedCurrency = value as ServerCurrency;
                                          });
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          CustomTextFormField(
                            controller: amountTextEditingController,
                              validator: (value) {
                                double? input = double.tryParse(value??"");
                                if(input==null){
                                  return "Please enter correct format";
                                }
                                else if(input > 50000)
                                  {
                                    return "You can not send money more than 50000 ${commonController.serverCountryFrom.value.selectedCurrency!.code}";
                                  }
                                return null;
                              },
                              labelText: "Enter amount in ${commonController.serverCountryFrom.value.selectedCurrency!.code}",
                              hindText: "",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {

                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  inputAmount.value = double.tryParse(value as String)??0;
                                });

                              }
                          ),
                          const SizedBox(height: 20,),
                          Obx((){
                            if(inputAmount.value!=0){
                              return FutureBuilder(
                                future: commonController.getConversionDetails(inputAmount.value, commonController.serverCountryFrom.value.selectedCurrency!, commonController.serverCountryTo.value.selectedCurrency!),
                                builder: (context, AsyncSnapshot<APIResponse<CurrencyConversionDetails>> snapshot){

                                  if(snapshot.data!=null){
                                    APIResponse<CurrencyConversionDetails>? apiResponse = snapshot.data;

                                    if(apiResponse!.data != null){

                                      CurrencyConversionDetails currencyConversionDetails = apiResponse.data!;

                                      commonController.currencyConversionDetails.value = currencyConversionDetails;

                                      return Column(
                                        children: [
                                          SendMoneyCalculationItem(
                                            iconPath: AppSvg.getPath("rate"),
                                            title: "Our Rate",
                                            value: "1 ${commonController.serverCountryFrom.value.selectedCurrency!.code} = ${currencyConversionDetails.ourRate!.toStringAsFixed(2)} ${commonController.serverCountryTo.value.selectedCurrency!.code}",
                                          ),
                                          const SizedBox(height: 10,),
                                          SendMoneyCalculationItem(
                                            iconPath: AppSvg.getPath("transfer"),
                                            title: "Transfer Fee",
                                            value: "${(currencyConversionDetails.amountToPay!-currencyConversionDetails.amountToSend!).toStringAsFixed(2)} ${commonController.serverCountryFrom.value.selectedCurrency!.code}",
                                            // value: "${currencyConversionDetails.fees!.toStringAsFixed(2)} ${currencyConversionDetails.sendingCurrency}",
                                          ),
                                          const SizedBox(height: 10,),
                                          SendMoneyCalculationItem(
                                            iconPath: AppSvg.getPath("amount_to_send"),
                                            title: "Amount to send",
                                            value: "${currencyConversionDetails.amountToSend!.toStringAsFixed(2)} ${commonController.serverCountryFrom.value.selectedCurrency!.code}",
                                          ),
                                          const SizedBox(height: 10,),
                                          SendMoneyCalculationItem(
                                            iconPath: AppSvg.getPath("Amount_to_receive"),
                                            title: "Amount to receive",
                                            value: '${currencyConversionDetails.amountToReceive!.toStringAsFixed(2)} ${commonController.serverCountryTo.value.selectedCurrency!.code}',
                                          ),
                                          const SizedBox(height: 10,),
                                          SendMoneyCalculationItem(
                                            iconPath: AppSvg.getPath("Amount_to_receive"),
                                            title: "Total to pay",
                                            value: "${currencyConversionDetails.amountToPay!.toStringAsFixed(2)} ${commonController.serverCountryFrom.value.selectedCurrency!.code}",
                                          ),
                                        ],
                                      );
                                    }else{
                                      return Center(child: Text(apiResponse.message?? "An Error Occurred"));
                                    }

                                  }else{
                                    return SpinKitCircle(color: Get.theme.primaryColor,);
                                  }

                                },
                              );
                            }else{
                              return const Center(child: Text("Please enter correct format"));
                            }
                          }),
                          const SizedBox(height: 10,),
                        ],
                      ),
                  ),
                  //const SizedBox(height: 10.0,),

                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Mode of Payment',
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7,),
                        CustomDropDownFromField(
                            validator: (value) {
                              if (value == null) {
                                return "Select mode of payment";
                              }
                              return null;
                            },

                            items: commonController.modeOfPayments.map((ModeOfPayment modeOfPayment) {
                              return DropdownMenuItem(
                                  value: modeOfPayment,
                                  child: Text(modeOfPayment.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                              );
                            }).toList(),
                            selectedValue: commonController.selectedModeOfPayment,
                            labelAndHintText: "Select mode of payment",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                            ),
                            filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                            onChanged: (value) {
                              setState(() {
                                commonController.selectedModeOfPayment = value as ModeOfPayment;
                              });
                            }
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //const SizedBox(height: 80.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultButton(
                      buttonText: "Send Money", onTap: () async{
                        if(_formKey.currentState!.validate()){

                          Utility.showLoadingDialog();

                          bool isSuccessGetMyRecipients = await commonController.getMyRecipients();
                          if(!isSuccessGetMyRecipients){
                            Get.back();
                            return;
                          }

                          bool isSuccessGetCities = await commonController.getCities();
                          if(!isSuccessGetCities){
                            Get.back();
                            return;
                          }

                          Get.back();

                          Get.to(const RecipientDetailsScreen());
                        }
                    },),
                  ),
                  const SizedBox(height: 15,)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
