import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Models/card.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/payment_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/default_dialogs.dart';
import 'package:hidmona/Utilities/utility.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({Key? key}) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  const Text("Card List",),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: PaymentRepository.getCards(),
            builder: (context,AsyncSnapshot< APIResponse<List<PaymentCard>>> snapshot){

              if(snapshot.data!=null){

                APIResponse<List<PaymentCard>> response = snapshot.data!;

                if(response.data != null){
                  List<PaymentCard> cards = response.data!;

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
                      itemCount: cards.length,
                      itemBuilder: (context,index){
                        return Card(
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${cards[index].cardType!}  **** **** **** ${cards[index].cardInfo!}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    InkWell(
                                      onTap: (){
                                        DefaultDialogs.showDialog(
                                            title: "Delete ${cards[index].cardType!} Card",
                                            text: "${cards[index].cardType} **** **** **** ${cards[index].cardInfo!}\n\nDo you want to delete the card?",
                                            onCancel: (){
                                              Navigator.pop(context);
                                            },
                                            onSubmitText: "Yes",
                                            onSubmit: () async{
                                              Navigator.pop(context);
                                              Utility.showLoadingDialog();

                                              APIResponse apiResponse = await PaymentRepository.deleteCard(cards[index].id!);

                                              if(apiResponse.data != null && apiResponse.data){
                                                Utility.showSnackBar(apiResponse.message??"Card Deleted");
                                                setState(() {});
                                              }else{
                                                Utility.showSnackBar(apiResponse.message??"An Error Occurred");
                                              }

                                              Get.back();

                                            }
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        decoration: BoxDecoration(
                                            color: AppColor.defaultColor.withOpacity(.15),
                                            borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Icon(Icons.delete,color: AppColor.defaultColor,size: 17,),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7,),
                                Text("Ref: ${cards[index].referenceNumber!}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          )
                        );
                      },
                    ),
                  );

                }else{
                  return Center(child: Text(response.message??"An Error Occurred"),);
                }

              }

              return Center(child: SpinKitCircle(color: AppColor.defaultColor,));


            },
          ),
        )
    );
  }
}
