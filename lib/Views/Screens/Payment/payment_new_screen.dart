import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/card.dart';
import 'package:hidmona/Models/pyament_auth_response.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/payment_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/payment_dialog.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Screens/Payment/payment_3d_auth_screen.dart';
import 'package:hidmona/Views/Screens/Payment/payment_new_card_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/sending_confirmation_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/sending_successful_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class PaymentNewScreen extends StatefulWidget {

  static const String routeName = "PaymentNewScreen";

  const PaymentNewScreen({Key? key}) : super(key: key);

  @override
  _PaymentNewScreenState createState() => _PaymentNewScreenState();
}

class _PaymentNewScreenState extends State<PaymentNewScreen> {

  CommonController commonController = Get.find<CommonController>();

  int isCardSave = 0;
  PaymentCard? selectedCard;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      const Center(child: Text("Payment Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                      Divider(color: AppColor.defaultColor,thickness: 2,),
                      SendDetailsItem(title: "Amount to pay",value: "${commonController.currentTransaction!.data!.totalAmount!.toStringAsFixed(2)} ${commonController.currentTransaction!.data!.payoutCurrency!.code!}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      SendDetailsItem(title: "Transaction ID",value: commonController.currentTransaction!.data!.transactionNumber??"--"),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColor.defaultColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(child: Text("Pay the amount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)),
                      Divider(color: AppColor.defaultColor,thickness: 2,),
                      FutureBuilder(
                        future: PaymentRepository.getCards(),
                        builder: (context,AsyncSnapshot< APIResponse<List<PaymentCard>>> snapshot){

                          if(snapshot.data!=null){

                            APIResponse<List<PaymentCard>> response = snapshot.data!;

                            if(response.data != null){
                              List<PaymentCard> cards = response.data!;
                              //transactions = transactions.reversed.toList();
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:cards.map((card){
                                      return CardRadioWidget(card: card, isSelected: selectedCard==null? false : selectedCard!.id == card.id, onChanged: (){
                                        setState(() {
                                          if(selectedCard != card) {
                                            selectedCard = card;
                                          }else{
                                            selectedCard = null;
                                          }
                                        });
                                      });
                                    }).toList(),
                                  ),
                                  if(cards.isNotEmpty)const SizedBox(height: 5,),
                                  if(cards.isNotEmpty)DefaultButton(buttonText: "Pay Now",onTap: () async{
                                    if(selectedCard != null){
                                      Utility.showLoadingDialog();

                                      APIResponse<bool> apiResponse = await PaymentRepository.paymentByCardId(selectedCard!.id!, commonController.currentTransaction!.data!.transactionNumber!);

                                      Get.back();

                                      if(apiResponse.data != null && apiResponse.data!){
                                        //Get.offAll(const SendingSuccessFulScreen());

                                        PaymentDialog.showDialog();
                                      }else{
                                        Utility.showSnackBar(apiResponse.message?? "An Error Occurred",durationInSeconds: 5);
                                      }


                                    }else{
                                      Utility.showSnackBar("Please Choose One Card");
                                    }
                                  },),
                                  if(cards.isNotEmpty) Divider(height: 30,color: AppColor.defaultColor.withOpacity(.7),thickness: 1,),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Checkbox(activeColor: AppColor.defaultColor,value: isCardSave == 1, onChanged: (value){
                                          setState(() {
                                            isCardSave = value! == true? 1:0;
                                          });
                                        }),
                                      ),
                                      Expanded(
                                        child: Text("Save Card Details", style: TextStyle(color: AppColor.defaultColor,fontWeight: FontWeight.w700,fontSize: 15),),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Center(
                                    child: DefaultButton(
                                      buttonText: cards.isEmpty?"Pay Now":"Use Another Card",
                                      onTap: ()async{
                                        Utility.showLoadingDialog();

                                        APIResponse<PaymentAuthResponse> apiResponse = await PaymentRepository.payment3dAuth(commonController.currentTransaction!.data!.transactionNumber!,isCardSave);

                                        if(apiResponse.data != null){
                                          String? returnUrl = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Payment3DAuthScreen(paymentAuthResponse: apiResponse.data!,)));
                                          if(returnUrl != null && returnUrl.isNotEmpty){
                                            print(returnUrl);

                                            // var errorCode = Uri.parse(returnUrl).queryParameters['errorcode'];
                                            // var errorMessage = Uri.parse(returnUrl).queryParameters['errormessage'];
                                            // var orderReference = Uri.parse(returnUrl).queryParameters['transactionreference'];
                                            // var jwt = Uri.parse(returnUrl).queryParameters['jwt'];
                                            var data = Uri.parse(returnUrl).queryParameters['data'];
                                            var jsonData = json.decode(data!);
                                            //PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");
                                            var errorCode = jsonData['errorcode'];
                                            var errorMessage = jsonData['message'];
                                            var orderReference = jsonData['transactionreference'];


                                            if(errorCode == "0"){
                                              PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");

                                              // PaymentRepository.transactionConfirmation(jwt!).then((value){
                                              //   Get.back();
                                              //   if(value.data!=null && value.data!){
                                              //     PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");
                                              //   }else{
                                              //     Utility.showSnackBar(value.message??"Transaction Failed!");
                                              //   }
                                              // });
                                            }
                                            else{
                                              Get.back();
                                              Utility.showSnackBar(errorMessage??"Transaction Failed!");
                                            }
                                          }else{
                                            Get.back();
                                          }
                                        }else{
                                          Get.back();
                                          Utility.showSnackBar(apiResponse.message??"Transaction Failed!");
                                        }

                                      },
                                    ),
                                  ),
                                ],
                              );
                            }else{
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Checkbox(activeColor: AppColor.defaultColor,value: isCardSave == 1, onChanged: (value){
                                          setState(() {
                                            isCardSave = value! == true? 1:0;
                                          });
                                        }),
                                      ),
                                      Expanded(
                                        child: Text("Save Card Details", style: TextStyle(color: AppColor.defaultColor,fontWeight: FontWeight.w700,fontSize: 15),),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Center(
                                    child: DefaultButton(
                                      buttonText: "Pay Now",
                                      onTap: ()async{
                                        Utility.showLoadingDialog();
                                        APIResponse<PaymentAuthResponse> apiResponse = await PaymentRepository.payment3dAuth(commonController.currentTransaction!.data!.transactionNumber!,isCardSave);
                                        if(apiResponse.data != null){
                                          String? returnUrl = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Payment3DAuthScreen(paymentAuthResponse: apiResponse.data!,)));
                                          if(returnUrl != null && returnUrl.isNotEmpty){
                                            print(returnUrl);
                                            // var errorCode = Uri.parse(returnUrl).queryParameters['errorcode'];
                                            // var errorMessage = Uri.parse(returnUrl).queryParameters['errormessage'];
                                            // var orderReference = Uri.parse(returnUrl).queryParameters['transactionreference'];
                                            // var jwt = Uri.parse(returnUrl).queryParameters['jwt'];
                                            var data = Uri.parse(returnUrl).queryParameters['data'];
                                            var jsonData = json.decode(data!);
                                            //PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");
                                            var errorCode = jsonData['errorcode'];
                                            var errorMessage = jsonData['message'];
                                            var orderReference = jsonData['transactionreference'];

                                            if(errorCode == "0"){
                                              PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");

                                              // PaymentRepository.transactionConfirmation(jwt!).then((value){
                                              //   Get.back();
                                              //   if(value.data!=null && value.data!){
                                              //     PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");
                                              //   }else{
                                              //     Utility.showSnackBar(value.message??"Transaction Failed!");
                                              //   }
                                              // });
                                            }else{
                                              Get.back();
                                              Utility.showSnackBar(errorMessage??"Transaction Failed!");
                                            }
                                            //PaymentDialog.showDialog(text: "Your Transaction is Successful.\nYour Transaction Reference is: ${orderReference}");

                                          }else{
                                            Get.back();
                                          }
                                        }else{
                                          Get.back();
                                          Utility.showSnackBar(apiResponse.message??"Transaction Failed!");
                                        }

                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(child: SpinKitCircle(color: AppColor.defaultColor,)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35,),
                Center(
                  child: DefaultButton(
                    buttonText: "Go to Home",
                    textColor: Colors.black,
                    onTap: (){
                      Get.offAll(const HomeScreen());
                    },
                    linearGradient: AppGradient.getColorGradient('grey'),
                  ),
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}



class CardRadioWidget extends StatelessWidget {
  const CardRadioWidget({Key? key, required this.card, required this.isSelected, required this.onChanged}) : super(key: key);

  final PaymentCard card;
  final Function() onChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:5.0),
        child: Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Row(
                children: [
                  Icon(isSelected? Icons.check_circle : CupertinoIcons.circle, size: 30,color: AppColor.defaultColor,),
                  const SizedBox(width: 10,),
                  Text("${card.cardType??"Card"}  **** **** **** ${card.cardInfo!}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            )
        ),
      ),
    );
  }
}
