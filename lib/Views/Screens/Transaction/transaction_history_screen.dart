import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hidmona/Models/transaction.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/transaction_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Widgets/transaction_item.dart';


class TransactionHistoryScreen extends StatefulWidget {

  static const String routeName = "TransactionHistoryScreen";

  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title:  const Text("Transactions",),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: TransactionRepository.getTransactions(),
          builder: (context,AsyncSnapshot< APIResponse<List<Transaction>>> snapshot){

            if(snapshot.data!=null){

              APIResponse<List<Transaction>> response = snapshot.data!;

              if(response.data != null){
                List<Transaction> transactions = response.data!;

                //transactions = transactions.reversed.toList();

                return CustomRefreshIndicator(
                  onRefresh: () => Future.delayed(const Duration(seconds: 1),(){
                    setState(() {});
                  }),
                  builder: (context,child,controller){
                    return AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, _) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            !controller.isIdle?
                            Positioned(
                              top: 5.0 * controller.value,
                              child: Column(
                                children: [
                                  SpinKitCircle(
                                    color: AppColor.defaultColor,
                                    size: 25.0,
                                  ),
                                ],
                              ),
                            ):const SizedBox(),
                            Transform.translate(
                              offset: Offset(0, 40.0 * controller.value),
                              child: child,
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                    itemCount: transactions.length,
                    itemBuilder: (context,index){
                      return TransactionItem(transaction:transactions[index]);
                    },
                  ),
                );

              }else{
                return Center(child: Text(response.errorMessage??"An Error Occurred"),);
              }

            }

            return Center(child: SpinKitCircle(color: AppColor.defaultColor,));


          },
        ),
      )
    );
  }
}

