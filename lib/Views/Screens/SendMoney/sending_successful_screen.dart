import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      const Center(child: Text("Payment Information",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
                      Divider(color: AppColor.defaultColor,thickness: 2,),
                      SendDetailsItem(title: "Amount to pay",value: "${commonController.currentTransaction!.totalAmount!.toStringAsFixed(3)} ${commonController.currencyConversionDetails.value.sendingCurrency}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      SendDetailsItem(title: "Transaction ID",value: commonController.currentTransaction!.transactionNumber??"--"),
                    ],
                  ),
                ),


                if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "cash")Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColor.defaultColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text("Pay the amount through cash",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600))),
                ),


                if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "bank")Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColor.defaultColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(child: Text("Pay the amount through bank",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)),
                      Divider(color: AppColor.defaultColor,thickness: 2,),
                      SendDetailsItem(title: "Bank Name",value: "${commonController.selectedCountryWiseBank!.bankName}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      SendDetailsItem(title: "Bank Account No",value: "${commonController.selectedCountryWiseBank!.bankAccountNumber}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      SendDetailsItem(title: "Bank Account Title",value: "${commonController.selectedCountryWiseBank!.bankAccountTitle}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      SendDetailsItem(title: "Branch Name",value: "${commonController.selectedCountryWiseBank!.branchName}",),
                      Divider(color: AppColor.defaultColor,thickness: .5,),
                      SendDetailsItem(title: "Bank Address",value: "${commonController.selectedCountryWiseBank!.status}",),
                    ],
                  ),
                ),


                if(commonController.selectedModeOfPayment!.name!.toLowerCase() == "debitorcredit")Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColor.defaultColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text("Pay the amount through TrustPay",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600))),
                ),

                const SizedBox(height: 45,),
                DefaultButton(buttonText: "Goto Home",onTap: (){
                  Get.offAll(const HomeScreen());
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
