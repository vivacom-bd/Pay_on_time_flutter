import 'package:flutter/material.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("#${transaction.transactionNumber}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                //   decoration: BoxDecoration(
                //       color: AppColor.defaultColor.withOpacity(.15),
                //       borderRadius: BorderRadius.circular(7)
                //   ),
                //   child: Text("Status: ${transaction.paymentStatus}",style: TextStyle(color: AppColor.defaultColor,fontSize: 11,fontWeight: FontWeight.w600),),
                // ),
                Text(DateFormat("dd MMM, yyyy hh:mm").format(DateFormat("yyyy-mm-ddThh:mm:ss").parse(transaction.transactionDate!)), style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 5,),
            Text("${transaction.receiveMethod!.name}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Payout Amount", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                      const SizedBox(height: 3,),
                      Text("${transaction.payoutAmount!.toStringAsFixed(2)} ${transaction.payoutCurrency}", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Receiving Amount", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                      const SizedBox(height: 3,),
                      Text("${transaction.receivingAmount!.toStringAsFixed(2)} ${transaction.receivingCurrency}", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}