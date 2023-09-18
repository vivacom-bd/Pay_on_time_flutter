import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';

class BankAccountDetails extends StatefulWidget {
  const BankAccountDetails({Key? key}) : super(key: key);

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CommonController commonController = Get.find<CommonController>();
  final String heading1 = 'Account Holder';
  final String heading2 = 'SWIFT/BIC';
  final String heading3 = 'IBAN';
  final String heading4 = 'Hidmona\'s address';
  String accountName = '';
  String swift = '';
  String iBan = '';
  final String address = 'Avenue Loise 54, Room S52 \nVilnius, Lithuania';


  void _copyTextToClipboard( String name,
      String iban, String swiftcode
      ) {
    Clipboard.setData(ClipboardData(text: "$heading1 : $name \n$heading2 : $swiftcode \n$heading3 : $iban \n$heading4 : $address"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          _globalKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: AppColor.defaultColorLight,
                        ),
                      ),
                      const SizedBox(width: 35,),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bank account Details",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 3,),
                        Text("use your EUR account details to receive money from people and businesses",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 10,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.only(left: 8.0, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const SizedBox(height: 5,),
                        Container(
                          padding: const EdgeInsets.only(left: 30,right: 40,top: 20,bottom: 20),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.dropdownBoxColor.withOpacity(0.39),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 15),
                              Text(heading1,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 2),
                              Text(commonController.userProfile.value.firstName!,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 20),
                              Text(heading2,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 16,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 2),
                              Text((commonController.getAccountDetails.value.data![0].bankAccountDetails!.swiftBic !=null) ? commonController.getAccountDetails.value.data![0].bankAccountDetails!.swiftBic! : "SWIFT",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 16,fontWeight: FontWeight.w500),),
                              const SizedBox(height: 20),
                              Text(heading3,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 16,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 2),
                              Text((commonController.getAccountDetails.value.data![0].bankAccountDetails!.iban !=null) ? commonController.getAccountDetails.value.data![0].bankAccountDetails!.iban! : "Iban Number",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 16,fontWeight: FontWeight.w500),),
                              const SizedBox(height: 20),
                              Text(heading4,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 16,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 2),
                              Text(address,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 16,fontWeight: FontWeight.w500),),
                              //const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              accountName = commonController.getAccountDetails.value.data![0].givenName!;
                              iBan = commonController.getAccountDetails.value.data![0].bankAccountDetails!.iban!;
                              swift = commonController.getAccountDetails.value.data![0].bankAccountDetails!.swiftBic!;
                            });
                            _copyTextToClipboard(accountName,iBan,swift);
                            Utility.showSnackBar("Text Copied to your Clipboard");
                          },
                          child: const Text('Copy details'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
