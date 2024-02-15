import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/transaction_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Screens/Payment/payment_new_screen.dart';
import 'package:hidmona/Views/Screens/Payment/payment_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/sending_confirmation_screen.dart';
import 'package:hidmona/Views/Screens/Transaction/upload_bank_receipt_screen.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatefulWidget {

  static const String routeName = "TransactionDetailsScreen";

  final String transactionNumber;

  const TransactionDetailsScreen({Key? key, required this.transactionNumber}) : super(key: key);

  @override
  _TransactionDetailsScreenState createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {

  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const Text("Transaction Details"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: TransactionRepository.getTransactionDetails(widget.transactionNumber),
          builder: (context, AsyncSnapshot<APIResponse<Transaction>> snapshot){

            if(snapshot.data != null){

              APIResponse<Transaction> apiResponse = snapshot.data!;

              if(apiResponse.data != null){

                Transaction transaction = apiResponse.data!;

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
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
                              const Center(child: Text("Your Money Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                              Divider(color: AppColor.defaultColor,thickness: 2,),
                              SendDetailsItem(title: "From",value: transaction.data!.sender!.country!.name!),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "To",value: transaction.data!.receiver!.country!.name!),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Payout amount",value: "${transaction.data!.payoutAmount!.toStringAsFixed(2)} ${transaction.data!.payoutCurrency!.code}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Receiving amount",value: "${transaction.data!.receivedAmount!.toStringAsFixed(2)} ${transaction.data!.receivedCurrency!.code}",),
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
                              const Center(child: Text("Your Recipient Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                              Divider(color: AppColor.defaultColor,thickness: 2,),
                              SendDetailsItem(title: "Full name",value: transaction.data!.receiver!.name !=null ? transaction.data!.receiver!.name! : "",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              // SendDetailsItem(title: "Mobile Number",value: "${transaction.recipient!.phone}",),
                              // Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "City",value: transaction.data!.receiver!.city!.name!),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Country",value: transaction.data!.receiver!.country!.name!),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Mode of Receive",value: transaction.data!.receiverMethod!.name!,),
                            ],
                          ),
                        ),
                        if(transaction.data!.bankName !=null && transaction.data!.bankName!.isNotEmpty && transaction.data!.receiverMethod!.name!.toLowerCase() != "cash") const SizedBox(height: 20,),
                        if(transaction.data!.bankName !=null && transaction.data!.bankName!.isNotEmpty && transaction.data!.receiverMethod!.name!.toLowerCase() != "cash") Container(
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
                              SendDetailsItem(title: "Bank Name",value: "${transaction.data!.bankName}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Bank Account No",value: "${transaction.data!.bankAccountNo}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Account Holder Name",value: "${transaction.data!.bankAccountTitle}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Branch Name",value: "${transaction.data!.branchName}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Bank Address",value: "",),//${transaction.data!.bankAddress}
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
                              SendDetailsItem(title: "Mode of Payment",value: transaction.data!.senderMethod !=null ? "${transaction.data!.senderMethod!.name}" : "",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Remitter Status",value: "",),//${transaction.remitterStatus}
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Mode of Receive",value: "${transaction.data!.receiverMethod!.name}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Purpose",value: transaction.data!.sendingPurpose !=null ? "${transaction.data!.sendingPurpose!.name}" :  "",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              SendDetailsItem(title: "Transaction Number",value: "${transaction.data!.transactionNumber}",),
                              Divider(color: AppColor.defaultColor,thickness: .5,),
                              // SendDetailsItem(title: "Transaction Date",value: DateFormat("dd MMM, YYYY hh:mm").format(DateFormat("yyyy-MM-ddThh:mm:ss").parse(transaction.data!.createdAt!.substring(0,0)),),),
                              // Divider(color: AppColor.defaultColor,thickness: .5,),
                              // SendDetailsItem(title: "Benificiary Status",value: transaction.data!.beneficiaryStatus!.toString() ??"",),
                              SendDetailsItem(title: "Benificiary Status",value: transaction.data!.beneficiaryStatus==0 ? "Pending" : "Confirm" ??"",),

                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                         if(transaction.data!.senderMethod !=null && transaction.data!.senderMethod!.id == 3) InkWell(
                        //if(transaction.data!.senderMethodId! == 2) InkWell(
                          onTap: (){
                            Get.to(UploadBankReceiptScreen(transactionId: transaction.data!.id!));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColor.defaultColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Upload Bank Receipt",style: TextStyle(fontWeight: FontWeight.w600),),
                                Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColor.defaultColor.withOpacity(.15),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Icon(Icons.cloud_upload,size: 17,color: AppColor.defaultColor,)
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        // if(transaction.remitterStatus!.toUpperCase() == "INPROCESS") InkWell(
                        //   onTap: (){
                        //     commonController.currentTransaction = transaction;
                        //     Get.to(const PaymentNewScreen());
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        //     decoration: BoxDecoration(
                        //         color: AppColor.defaultColor.withOpacity(.1),
                        //         borderRadius: BorderRadius.circular(10)
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         const Text("Pay Through Card",style: TextStyle(fontWeight: FontWeight.w600),),
                        //         Container(
                        //             height: 30,
                        //             width: 30,
                        //             alignment: Alignment.center,
                        //             decoration: BoxDecoration(
                        //                 color: AppColor.defaultColor.withOpacity(.15),
                        //                 borderRadius: BorderRadius.circular(20)
                        //             ),
                        //             child: Icon(Icons.credit_card_rounded,size: 17,color: AppColor.defaultColor,)
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                );
              }else{
                return Center(child: Text(apiResponse.message??"An Error Occurred"),);
              }

            }else{
              return Center(child: SpinKitCircle(color: AppColor.defaultColor,),);
            }

          },
        )
      )
    );
  }
}