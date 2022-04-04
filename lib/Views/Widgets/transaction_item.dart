import 'package:flutter/material.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Utilities/colors.dart';

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColor.defaultColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Text("Status: ${transaction.paymentStatus}",style: TextStyle(color: AppColor.defaultColor,fontSize: 11,fontWeight: FontWeight.w600),),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Text("${transaction.paymentReceiveMode!.name}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${transaction.totalAmount!.toStringAsFixed(2)} ${transaction.payoutCurrency}", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                Text("${transaction.transactionDate}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}