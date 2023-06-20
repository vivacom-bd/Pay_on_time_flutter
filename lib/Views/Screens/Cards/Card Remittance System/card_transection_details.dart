import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:intl/intl.dart';


class CardTransactionListScreen extends StatefulWidget {
  static const String routeName = "CardTransactionListScreen";
  const CardTransactionListScreen({Key? key}) : super(key: key);

  @override
  State<CardTransactionListScreen> createState() => _CardTransectionListScreenState();
}

class _CardTransectionListScreenState extends State<CardTransactionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Transaction'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 8.0),
                                Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Bank Name',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImage.getPath("card_chip"), height: 35, width: 35,),
                              ],
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              '1234 5678 9012 3456',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Valid',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              '09/23',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 8.0),
                                Text(
                                  'MD JEHAN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(int i = 1; i< 10;i++) CardTransection(index: i),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CardTransection extends StatelessWidget {
  CardTransection({
    Key? key,
    required this.index,
  }) ;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Get.to(()=>TransactionDetailsScreen(transactionNumber: transaction.id!));
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
                    child: Text("$index",style: TextStyle(color: AppColor.defaultColor,fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              const SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("#11222", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  Text("12/12/12", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Send To", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                        SizedBox(height: 3,),
                        Text("111231133", style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("Amount", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                        SizedBox(height: 3,),
                        Text("3343", style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),

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
