import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/transaction_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Payment/payment_new_screen.dart';
import 'package:hidmona/Views/Screens/Payment/payment_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/sending_successful_screen.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class SendingMoneyConfirmationScreen extends StatefulWidget {

  static const String routeName = "SendingMoneyConfirmationScreen";

  const SendingMoneyConfirmationScreen({Key? key}) : super(key: key);

  @override
  _SendingMoneyConfirmationScreenState createState() => _SendingMoneyConfirmationScreenState();
}

class _SendingMoneyConfirmationScreenState extends State<SendingMoneyConfirmationScreen> {

  CommonController commonController = Get.find<CommonController>();

  bool isInformationCorrect = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Sending Information", style: TextStyle(color: AppColor.dialogBackgroundColor),)
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColor.defaultColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: Text("Your Money Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                          Divider(color: AppColor.defaultColor,thickness: 2,),
                          SendDetailsItem(title: "Amount to send",value: "${commonController.currencyConversionDetails.value?.data!.amountToSend!.toStringAsFixed(2)} ${commonController.serverCountryFrom.value.selectedCurrency!.code}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Amount to receive",value: "${commonController.currencyConversionDetails.value?.data!.amountToReceive!.toStringAsFixed(2)} ${commonController.serverCountryTo.value.selectedCurrency!.code}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Amount to receive in USD",value: "${commonController.currencyConversionDetails.value?.data!.receivingAmountInUsd!.toStringAsFixed(2)} USD",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Fees",value: "${commonController.currencyConversionDetails.value?.data!.ourFees!.toStringAsFixed(2)} ${commonController.serverCountryFrom.value.selectedCurrency!.code}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Total to pay",value: "${commonController.currencyConversionDetails.value?.data!.amountToPay!.toStringAsFixed(2)} ${commonController.serverCountryFrom.value.selectedCurrency!.code}",),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    // Container(
                    //   padding: const EdgeInsets.all(15),
                    //   decoration: BoxDecoration(
                    //       color: AppColor.defaultColor.withOpacity(.1),
                    //       borderRadius: BorderRadius.circular(10)
                    //   ),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       const Text("Your Agent Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
                    //       Divider(color: AppColor.defaultColor,thickness: 2,),
                    //       SendDetailsItem(title: "Sender Agent Code",value: "${CommonSingleTon().recipient.senderAgent}",),
                    //       Divider(color: AppColor.defaultColor,thickness: .5,),
                    //       SendDetailsItem(title: "Sender Agent",value: "${CommonSingleTon().recipient.sendAgent??""}",),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColor.defaultColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: Text("Your Recipient Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                          Divider(color: AppColor.defaultColor,thickness: 2,),
                          SendDetailsItem(title: "Full name",value: "${commonController.selectedRecipient?.fullName}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Mobile Number",value: "${commonController.selectedRecipient?.phone}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "City",value: commonController.selectedRecipient?.city?.name ?? "",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Country",value: "${commonController.selectedRecipient?.country?.name}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Mode of Receive",value: "${commonController.selectedModeOfReceive?.name}",),
                        ],
                      ),
                    ),
                    if(commonController.selectedModeOfReceive!.id == 3) const SizedBox(height: 20,),
                    if(commonController.selectedModeOfReceive!.id == 3) Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColor.defaultColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: Text("Your Recipient Bank Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                          Divider(color: AppColor.defaultColor,thickness: 2,),
                          SendDetailsItem(title: "Bank Name",value: "${commonController.transactionRequestBodyForBank!.bankName}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Bank Account No",value: "${commonController.transactionRequestBodyForBank!.bankAccountNo}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Account Holder Name",value: "${commonController.transactionRequestBodyForBank!.bankAccountTitle}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Branch Name",value: "${commonController.transactionRequestBodyForBank!.branchName}",),
                          // Divider(color: AppColor.defaultColor,thickness: .5,),
                          // SendDetailsItem(title: "Bank Address",value: "${commonController.transactionRequestBodyForBank!.bankAddress}",),
                        ],
                      ),
                    ),
                    if(commonController.selectedCountryWiseBank != null) const SizedBox(height: 20,),
                    if(commonController.selectedCountryWiseBank != null) Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColor.defaultColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: Text("Payment Bank Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                          Divider(color: AppColor.defaultColor,thickness: 2,),
                          SendDetailsItem(title: "Bank Name",value: "${commonController.selectedCountryWiseBank!.bankName}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Bank Account No",value: "${commonController.selectedCountryWiseBank!.bankAccountNumber}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Bank Account Title",value: "${commonController.selectedCountryWiseBank!.bankAccountTitle}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Branch Name",value: "${commonController.selectedCountryWiseBank!.branchName}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          // SendDetailsItem(title: "Bank Address",value: "${commonController.selectedCountryWiseBank!.status}",),
                          // Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Country",value: "${commonController.selectedCountryWiseBank!.country!.name}",),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColor.defaultColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: Text("Transaction Details",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                          Divider(color: AppColor.defaultColor,thickness: 2,),
                          SendDetailsItem(title: "Mode of Payment",value: "${commonController.selectedModeOfPayment!.name}",),
                          Divider(color: AppColor.defaultColor,thickness: .5,),
                          SendDetailsItem(title: "Purpose",value: "${commonController.selectedSendingPurpose!.name}",),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Checkbox(activeColor: AppColor.defaultColor,value: isInformationCorrect, onChanged: (value){
                          setState(() {
                            isInformationCorrect = value!;
                          });
                        }),
                        Expanded(
                          child: Text("Please check this box to ensure that this information is correct", style: TextStyle(color: AppColor.defaultColor),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () async {
                  if(isInformationCorrect) {
                    ///Utility.showLoadingDialog();

                    Utility.showLoadingDialog();
                    ///
                    if(commonController.currencyConversionDetails.value!.data!.receivingAmountInUsd! >= 2000 && commonController.selectedModeOfReceive!.id == 3) {
                      var request = http.MultipartRequest("POST",Uri.parse(baseAPIUrl()+'transactions'));
                      request.headers.addAll(headersWithAuthAndContentTypeAndAccept);
                      request.fields['bank_id'] = commonController.bankId.toString();
                      request.fields['bank_account_no'] = commonController.bankAccountNoTextEditingController.text;
                      request.fields['bank_account_title'] = commonController.bankAccountTitleTextEditingController.text;
                      request.fields['bank_swift_code'] = commonController.bankSwiftCodeTextEditingController.text;
                      request.fields['payout_currency'] = commonController.serverCountryFrom.value.selectedCurrency!.code!;
                      request.fields['receiving_currency'] = commonController.serverCountryTo.value.selectedCurrency!.code!;
                      request.fields['payout_amount'] = commonController.currencyConversionDetails.value!.data!.amountToSend!.toString();
                      request.fields['receiver_method_id'] = commonController.selectedModeOfReceive!.id.toString();
                      request.fields['sender_method_id'] = commonController.selectedModeOfPayment!.id.toString();
                      request.fields['recipient_id'] = commonController.selectedRecipient!.id!.toString();
                      request.fields['sender_country_id'] = commonController.serverCountryFrom.value.id.toString();
                      request.fields['receiver_city_id'] = commonController.recipientCity!.id.toString();
                      request.fields['receiver_country_id'] = commonController.selectedRecipient!.countryId.toString();
                      request.fields['purpose_id'] = commonController.selectedSendingPurpose!.id.toString();
                      request.fields['bank_name'] = commonController.bankNameTextEditingController.text;
                      request.fields['branch_name'] = commonController.recipientBankBranch ?? "";
                      request.fields['fund_source_id'] =  commonController.foundSourceId!.toString();
                      final stream = http.ByteStream(Stream.castFrom(commonController.imageFile!.openRead()));
                      final length = await commonController.imageFile!.length();
                      var file = http.MultipartFile('fund_source_file', stream, length, filename: path.basename(commonController.imageFile!.path));
                      request.files.add(file);
                      var response = await request.send();
                      print(response);
                      Get.back();
                      if(response.statusCode == 201){
                        final decodedResponse = await utf8.decodeStream(response.stream);
                        final parsed = jsonDecode(decodedResponse);
                        setState(() {
                          commonController.currentTransaction = Transaction.fromJson(parsed);
                        });
                        //commonController.currentTransaction = value.data;
                        if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debit or credit" || commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit"){
                          Get.offAll(const PaymentNewScreen());
                          commonController.selectedRecipient = null;
                        } else {
                          Get.offAll(const SendingSuccessFulScreen());
                          commonController.selectedRecipient = null;
                        }
                      } else {
                        Utility.showSnackBar("File is not uploaded");
                      }
                    }
                    if(commonController.currencyConversionDetails.value!.data!.receivingAmountInUsd! >= 2000) {
                      var request = http.MultipartRequest("POST",Uri.parse(baseAPIUrl()+'transactions'));
                      request.headers.addAll(headersWithAuthAndContentTypeAndAccept);
                      // request.fields['bank_id'] = commonController.bankId.toString();
                      request.fields['bank_account_no'] = commonController.bankAccountNoTextEditingController.text;
                      request.fields['bank_account_title'] = commonController.bankAccountTitleTextEditingController.text;
                      request.fields['bank_swift_code'] = commonController.bankSwiftCodeTextEditingController.text;
                      request.fields['payout_currency'] = commonController.serverCountryFrom.value.selectedCurrency!.code!;
                      request.fields['receiving_currency'] = commonController.serverCountryTo.value.selectedCurrency!.code!;
                      request.fields['payout_amount'] = commonController.currencyConversionDetails.value!.data!.amountToSend!.toString();
                      request.fields['receiver_method_id'] = commonController.selectedModeOfReceive!.id.toString();
                      request.fields['sender_method_id'] = commonController.selectedModeOfPayment!.id.toString();
                      request.fields['recipient_id'] = commonController.selectedRecipient!.id.toString();
                      request.fields['sender_country_id'] = commonController.serverCountryFrom.value.id.toString();
                      request.fields['receiver_city_id'] = commonController.recipientCity!.id.toString();
                      request.fields['receiver_country_id'] = commonController.selectedRecipient!.countryId.toString();
                      request.fields['purpose_id'] = commonController.selectedSendingPurpose!.id.toString();
                      request.fields['bank_name'] = commonController.bankNameTextEditingController.text;
                      request.fields['branch_name'] = commonController.recipientBankBranch ?? "";
                      request.fields['fund_source_id'] =  commonController.foundSourceId!.toString();
                      final stream = http.ByteStream(Stream.castFrom(commonController.imageFile!.openRead()));
                      final length = await commonController.imageFile!.length();
                      var file = http.MultipartFile('fund_source_file', stream, length, filename: path.basename(commonController.imageFile!.path));
                      request.files.add(file);
                      var response = await request.send();
                      print(response);
                      Get.back();
                      if(response.statusCode == 201){
                        final decodedResponse = await utf8.decodeStream(response.stream);
                        final parsed = jsonDecode(decodedResponse);
                        setState(() {
                          commonController.currentTransaction = Transaction.fromJson(parsed);
                        });
                        //commonController.currentTransaction = value.data;
                        if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debit or credit" || commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit"){
                          Get.offAll(const PaymentNewScreen());
                          commonController.selectedRecipient = null;
                        } else {
                          Get.offAll(const SendingSuccessFulScreen());
                          commonController.selectedRecipient = null;
                        }
                      } else {
                        Utility.showSnackBar("File is not uploaded");
                      }
                    }
                    // else if(commonController.currencyConversionDetails.value?.data!.receivingAmountInUsd! >= 2000 && commonController.selectedModeOfReceive!.id == 1) {
                    //   var request = http.MultipartRequest("POST",Uri.parse(baseAPIUrl()+'transactions'));
                    //   request.headers.addAll(headersWithAuthAndContentType);
                    //   request.fields['bank_id'] = commonController.bankId.toString();
                    //   request.fields['bank_account_no'] = commonController.bankAccountNoTextEditingController.text;
                    //   request.fields['bank_account_title'] = commonController.bankAccountTitleTextEditingController.text;
                    //   request.fields['bank_swift_code'] = commonController.bankSwiftCodeTextEditingController.text;
                    //   request.fields['payout_currency'] = commonController.serverCountryFrom.value.selectedCurrency!.code!;
                    //   request.fields['receiving_currency'] =  commonController.serverCountryTo.value.selectedCurrency!.code!;
                    //   request.fields['payout_amount'] = commonController.currencyConversionDetails.value?.data!.amountToSend.toString();
                    //   request.fields['receiver_method_id'] =  commonController.selectedModeOfReceive!.id.toString();
                    //   request.fields['sender_method_id'] = commonController.selectedModeOfPayment!.id.toString();
                    //   request.fields['recipient_id'] = commonController.selectedRecipient!.id.toString();
                    //   request.fields['sender_country_id'] = commonController.serverCountryFrom.value.id.toString();
                    //   request.fields['receiver_city_id'] =  commonController.recipientCity!.id.toString();
                    //   request.fields['receiver_country_id'] = commonController.selectedRecipient!.countryId!.toString();
                    //   request.fields['purpose_id'] = commonController.selectedSendingPurpose!.id!.toString();
                    //   request.fields['bank_name'] = commonController.bankNameTextEditingController.text;
                    //   request.fields['branch_name'] = commonController.recipientBankBranch ?? "";
                    //   request.fields['fund_source_id'] =  commonController.foundSourceId!.toString();
                    //
                    //   final stream = http.ByteStream(Stream.castFrom(commonController.imageFile!.openRead()));
                    //   final length = await commonController.imageFile!.length();
                    //   var file = http.MultipartFile('fund_source_file', stream, length, filename: path.basename(commonController.imageFile!.path));
                    //   request.files.add(file);
                    //   var response = await request.send();
                    //   print(response);
                    //   Get.back();
                    //   if(response.statusCode == 201){
                    //     final decodedResponse = await utf8.decodeStream(response.stream);
                    //     final parsed = jsonDecode(decodedResponse);
                    //     setState(() {
                    //       commonController.currentTransaction = Transaction.fromJson(parsed);
                    //     });
                    //     //commonController.currentTransaction = value.data;
                    //     if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debit or credit" || commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit"){
                    //       Get.offAll(const PaymentNewScreen());
                    //       commonController.selectedRecipient = null;
                    //     } else {
                    //       Get.offAll(const SendingSuccessFulScreen());
                    //       commonController.selectedRecipient = null;
                    //     }
                    //   } else {
                    //     Utility.showSnackBar("File is not uploaded");
                    //   }
                    //
                    // }
                    // else if(commonController.currencyConversionDetails.value?.data!.receivingAmountInUsd! >= 2000) {
                    //   var request = http.MultipartRequest("POST",Uri.parse(baseAPIUrl()+'transactions'));
                    //   request.headers.addAll(headersWithAuthAndContentType);
                    //   request.fields['bank_id'] = commonController.bankId.toString();
                    //   request.fields['bank_account_no'] = commonController.bankAccountNoTextEditingController.text;
                    //   request.fields['bank_account_title'] = commonController.bankAccountTitleTextEditingController.text;
                    //   request.fields['bank_swift_code'] = commonController.bankSwiftCodeTextEditingController.text;
                    //   request.fields['payout_currency'] = commonController.serverCountryFrom.value.selectedCurrency!.code!;
                    //   request.fields['receiving_currency'] =  commonController.serverCountryTo.value.selectedCurrency!.code!;
                    //   request.fields['payout_amount'] = commonController.currencyConversionDetails.value?.data!.amountToSend.toString();
                    //   request.fields['receiver_method_id'] =  commonController.selectedModeOfReceive!.id.toString();
                    //   request.fields['sender_method_id'] = commonController.selectedModeOfPayment!.id.toString();
                    //   request.fields['recipient_id'] = commonController.selectedRecipient!.id.toString();
                    //   request.fields['sender_country_id'] = commonController.serverCountryFrom.value.id.toString();
                    //   request.fields['receiver_city_id'] =  commonController.recipientCity!.id.toString();
                    //   request.fields['receiver_country_id'] = commonController.selectedRecipient!.countryId!.toString();
                    //   request.fields['purpose_id'] = commonController.selectedSendingPurpose!.id!.toString();
                    //   request.fields['bank_name'] = commonController.bankNameTextEditingController.text;
                    //   request.fields['branch_name'] = commonController.recipientBankBranch ?? "";
                    //   request.fields['fund_source_id'] =  commonController.foundSourceId!.toString();
                    //
                    //   final stream = http.ByteStream(Stream.castFrom(commonController.imageFile!.openRead()));
                    //   final length = await commonController.imageFile!.length();
                    //   var file = http.MultipartFile('fund_source_file', stream, length, filename: path.basename(commonController.imageFile!.path));
                    //   request.files.add(file);
                    //   var response = await request.send();
                    //   print(response);
                    //   Get.back();
                    //   if(response.statusCode == 201){
                    //     final decodedResponse = await utf8.decodeStream(response.stream);
                    //     final parsed = jsonDecode(decodedResponse);
                    //     setState(() {
                    //       commonController.currentTransaction = Transaction.fromJson(parsed);
                    //     });
                    //     //commonController.currentTransaction = value.data;
                    //     if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debit or credit" || commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit"){
                    //       Get.offAll(const PaymentNewScreen());
                    //       commonController.selectedRecipient = null;
                    //     } else {
                    //       Get.offAll(const SendingSuccessFulScreen());
                    //       commonController.selectedRecipient = null;
                    //     }
                    //   } else {
                    //     Utility.showSnackBar("File is not uploaded");
                    //   }
                    //
                    // }
                    else if(commonController.selectedModeOfReceive!.id == 3) {
                        TransactionRepository.createTransactionForBank(
                        commonController.transactionRequestBodyForBank!,
                      ).then((value){
                        Get.back();
                        if(value.data != null){
                          commonController.currentTransaction = value.data;
                          if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debit or credit" || commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit"){
                            Get.offAll(const PaymentNewScreen());
                            commonController.selectedRecipient = null;
                          } else {
                            Get.offAll(const SendingSuccessFulScreen());
                            commonController.selectedRecipient = null;
                          }

                        } else {
                          Utility.showSnackBar(value.message??"An Error Occurred");
                        }
                      });
                    }
                    else {
                      TransactionRepository.createTransaction(
                        commonController.transactionRequestBody!,
                      ).then((value){
                        Get.back();
                        if(value.data != null){
                          commonController.currentTransaction = value.data;
                          if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debit or credit" || commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit"){
                            Get.offAll(const PaymentNewScreen());
                            commonController.selectedRecipient = null;
                          }else{
                            Get.offAll(const SendingSuccessFulScreen());
                            commonController.selectedRecipient = null;
                          }

                        }else{
                          Utility.showSnackBar(value.message??"An Error Occurred");
                        }
                      });

                    }

                  } else{
                    Utility.showSnackBar("Please ensure this information is correct");
                  }
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenWidth/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(SizeConfig.screenWidth),topRight: Radius.circular(SizeConfig.screenWidth)),
                    gradient: AppGradient.getColorGradient("default"),
                  ),
                  alignment: Alignment.center,
                  child: const Text("Send Money",style: TextStyle(color: Colors.white,fontSize: 27,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class SendDetailsItem extends StatelessWidget {
  const SendDetailsItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(title,style: const TextStyle(fontSize: 14),)),
          Text(value,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),)
        ],
      ),
    );
  }
}
