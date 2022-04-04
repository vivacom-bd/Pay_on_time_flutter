import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Repositories/transaction_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class SendingSuccessFulScreen extends StatefulWidget {

  static const String routeName = "SendingSuccessFulScreen";

  const SendingSuccessFulScreen({Key? key}) : super(key: key);

  @override
  _SendingSuccessFulScreenState createState() => _SendingSuccessFulScreenState();
}

class _SendingSuccessFulScreenState extends State<SendingSuccessFulScreen> {

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
        title: const Text("Sending Successful"),
        automaticallyImplyLeading: false,
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              children: [


                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppSvg.getPath('successful'),height: 70,width: 70,),
                      const Text("Successful",style: TextStyle(color: Color(0xFF97D700),fontSize: 35,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),

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
                      const Text("Payment Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
                      Divider(color: AppColor.defaultColor,thickness: 2,),
                      SendDetailsItem(title: "Transfer Amount",value: "${commonController.currentTransaction!.totalAmount!.toStringAsFixed(2)} ${commonController.currencyConversionDetails.value.sendingCurrency}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      const SendDetailsItem(title: "To our Bankgiro",value: "5058-0307",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      const SendDetailsItem(title: "Write your reference No.",value: "6844",),
                    ],
                  ),
                ),

                const SizedBox(height: 45,),
                DefaultButton(buttonText: "Goto Home",onTap: (){
                  Get.offAll(HomeScreen());
                },),
                const SizedBox(height: 15,),
              ],
            ),
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
