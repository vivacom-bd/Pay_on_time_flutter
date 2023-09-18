import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Screens/Payment/payment_new_screen.dart';
import 'package:hidmona/Views/Screens/Payment/payment_screen.dart';
import 'package:hidmona/Views/Screens/Transaction/transaction_details_screen.dart';
import 'package:hidmona/Views/Screens/Transaction/upload_bank_receipt_screen.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.index
  }) : super(key: key);

  final Transaction transaction;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>TransactionDetailsScreen(transactionNumber: transaction.data!.id!));
      },
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.defaultColor.withOpacity(.15),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text("${index+1}",style: TextStyle(color: AppColor.defaultColor,fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                  Row(
                    children: [
                      //Text("${index+1}.", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.defaultColor.withOpacity(.15),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Icon(Icons.visibility,size: 17,color: AppColor.defaultColor,)
                      ),
                      if(transaction.data!.senderMethod!.name!.toLowerCase() == "bank") const SizedBox(width: 7,),
                      if(transaction.data!.senderMethod!.name!.toLowerCase() == "bank") InkWell(
                        onTap: (){
                          Get.to(UploadBankReceiptScreen(transactionId: transaction.data!.id!));
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.defaultColor.withOpacity(.15),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Icon(Icons.cloud_upload,size: 17,color: AppColor.defaultColor,)
                        ),
                      ),
                      // if(transaction.remitterStatus != null && transaction.remitterStatus!.toUpperCase() == "INPROCESS") const SizedBox(width: 7,),
                      // if(transaction.remitterStatus != null && transaction.remitterStatus!.toUpperCase() == "INPROCESS") InkWell(
                      //   onTap: (){
                      //     Get.find<CommonController>().currentTransaction = transaction;
                      //     Get.to(const PaymentNewScreen());
                      //   },
                      //   child: Container(
                      //       height: 30,
                      //       width: 30,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           color: AppColor.defaultColor.withOpacity(.15),
                      //           borderRadius: BorderRadius.circular(20)
                      //       ),
                      //       child: Icon(Icons.credit_card_rounded,size: 17,color: AppColor.defaultColor,)
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("#${transaction.data!.transactionNumber}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  Text(DateFormat("dd MMM, yyyy hh:mm").format(DateFormat("yyyy-MM-ddThh:mm:ss").parse(transaction.data!.createdAt!)), style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Icon(Icons.person,size: 21),
                  const SizedBox(width: 7,),
                  Text(transaction.data!.receiver!.name!, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Payout Amount", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                        const SizedBox(height: 3,),
                        Text("${transaction.data!.payoutAmount!.toStringAsFixed(2)} ${transaction.data!.payoutCurrency}", style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 3,),
                        Text("${transaction.data!.senderMethod!.name}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Receiving Amount", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                        const SizedBox(height: 3,),
                        Text("${transaction.data!.receivedAmount!.toStringAsFixed(2)} ${transaction.data!.receivedCurrency}", style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 3,),
                        Text("${transaction.data!.receiverMethod!.name}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}