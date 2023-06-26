// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:hidmona/Controllers/common_controller.dart';
// import 'package:hidmona/Models/card.dart';
// import 'package:hidmona/Repositories/api_response.dart';
// import 'package:hidmona/Repositories/payment_repository.dart';
// import 'package:hidmona/Utilities/colors.dart';
// import 'package:hidmona/Utilities/payment_dialog.dart';
// import 'package:hidmona/Utilities/utility.dart';
// import 'package:hidmona/Views/Screens/Home/home_screen.dart';
// import 'package:hidmona/Views/Screens/Payment/payment_new_card_screen.dart';
// import 'package:hidmona/Views/Screens/SendMoney/sending_confirmation_screen.dart';
// import 'package:hidmona/Views/Screens/SendMoney/sending_successful_screen.dart';
// import 'package:hidmona/Views/Widgets/default_button.dart';
//
// class PaymentScreen extends StatefulWidget {
//
//   static const String routeName = "PaymentScreen";
//
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//
//   CommonController commonController = Get.find<CommonController>();
//
//   bool isInformationCorrect = false;
//   PaymentCard? selectedCard;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment"),
//       ),
//       body:SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: AppColor.defaultColor.withOpacity(.1),
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Center(child: Text("Payment Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
//                       Divider(color: AppColor.defaultColor,thickness: 2,),
//                       SendDetailsItem(title: "Amount to pay",value: "${commonController.currentTransaction!.totalAmount!.toStringAsFixed(2)} ${commonController.currentTransaction!.payoutCurrency}",),
//                       Divider(color: AppColor.defaultColor,thickness: .5,),
//                       SendDetailsItem(title: "Transaction ID",value: commonController.currentTransaction!.transactionNumber??"--"),
//                     ],
//                   ),
//                 ),
//
//                 Container(
//                   margin: const EdgeInsets.only(top: 20),
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                       color: AppColor.defaultColor.withOpacity(.1),
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child:  Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Center(child: Text("Pay the amount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)),
//                       Divider(color: AppColor.defaultColor,thickness: 2,),
//                       FutureBuilder(
//                         future: PaymentRepository.getCards(),
//                         builder: (context,AsyncSnapshot< APIResponse<List<PaymentCard>>> snapshot){
//
//                           if(snapshot.data!=null){
//
//                             APIResponse<List<PaymentCard>> response = snapshot.data!;
//
//                             if(response.data != null){
//                               List<PaymentCard> cards = response.data!;
//
//                               //transactions = transactions.reversed.toList();
//
//
//                               return Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children:cards.map((card){
//                                       return CardRadioWidget(card: card, isSelected: selectedCard==null? false : selectedCard!.id == card.id, onChanged: (){
//                                         setState(() {
//                                           selectedCard = card;
//                                         });
//                                       });
//                                     }).toList(),
//                                   ),
//                                   if(cards.isNotEmpty)const SizedBox(height: 5,),
//                                   if(cards.isNotEmpty)DefaultButton(buttonText: "Submit",onTap: () async{
//                                     if(selectedCard != null){
//                                       Utility.showLoadingDialog();
//
//                                       APIResponse<bool> apiResponse = await PaymentRepository.paymentByCardId(selectedCard!.id!, commonController.currentTransaction!.transactionNumber!);
//
//                                       Get.back();
//
//                                       if(apiResponse.data != null && apiResponse.data!){
//                                         //Get.offAll(const SendingSuccessFulScreen());
//
//                                         PaymentDialog.showDialog();
//                                       }else{
//                                         Utility.showSnackBar(apiResponse.message?? "An Error Occurred",durationInSeconds: 5);
//                                       }
//
//
//                                     }else{
//                                       Utility.showSnackBar("Please Choose One Card");
//                                     }
//                                   },),
//                                   const SizedBox(height: 15,),
//                                   DefaultButton(buttonText: cards.isEmpty?"Add Card":"Use Another Card",onTap: () async{
//                                     Get.to(PaymentWithNewCardScreen(transactionNumber: commonController.currentTransaction!.transactionNumber!,));
//                                   },),
//                                 ],
//                               );
//
//                             }else{
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 15.0),
//                                 child: Center(child: Text(response.message??"An Error Occurred"),),
//                               );
//                             }
//
//                           }
//
//                           return Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Center(child: SpinKitCircle(color: AppColor.defaultColor,)),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 35,),
//                 Center(
//                   child: DefaultButton(
//                     buttonText: "Go to Home",
//                     textColor: Colors.black,
//                     onTap: (){
//                       Get.offAll(const HomeScreen());
//                     },
//                     linearGradient: AppGradient.getColorGradient('grey'),
//                   ),
//                 ),
//                 const SizedBox(height: 15,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
//
//
// class CardRadioWidget extends StatelessWidget {
//   const CardRadioWidget({Key? key, required this.card, required this.isSelected, required this.onChanged}) : super(key: key);
//
//   final PaymentCard card;
//   final Function() onChanged;
//   final bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onChanged,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical:5.0),
//         child: Card(
//             elevation: 2,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//               child: Row(
//                 children: [
//                   Icon(isSelected? Icons.check_circle : CupertinoIcons.circle, size: 30,color: AppColor.defaultColor,),
//                   const SizedBox(width: 10,),
//                   Text("${card.cardType??"Card"}  **** **** **** ${card.cardInfo!}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
//                 ],
//               ),
//             )
//         ),
//       ),
//     );
//   }
// }
