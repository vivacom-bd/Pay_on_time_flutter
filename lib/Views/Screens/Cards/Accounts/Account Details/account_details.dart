import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/Account%20Details/bank_info.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Center(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Account Details",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: AppColor.dropdownBoxColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: AssetImage(
                                              CountryPickerUtils.getFlagImageAssetPath(commonController.countryFrom.value.isoCode!),
                                              package: "country_currency_pickers",),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${commonController.getAccountDetails.value.data![0].bankAccountDetails!.currency!} account" ,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                              const SizedBox(height: 2),
                                              GestureDetector(
                                                onTap: (){
                                                  Get.to(()=> const BankAccountDetails());
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: commonController.getAccountDetails.value.data![0].bankAccountDetails!.iban!,
                                                    style: TextStyle(
                                                      color: AppColor.hyperlinkColor,
                                                      decoration: TextDecoration.underline,
                                                      decorationStyle: TextDecorationStyle.solid,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text("10,000.00 EUR",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("Card transactions",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10.0),
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
                  Text("Selam Negasi Tewelde", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  Text("300 EURO", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,),),
                ],
              ),
              const SizedBox(height: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("sent 30 May", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
