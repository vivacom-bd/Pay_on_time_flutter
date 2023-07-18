import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/Account%20Details/account_details.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = "AccountScreen";
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CommonController commonController = Get.find<CommonController>();
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
                    child: Text("Account",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                GestureDetector(
                                  onTap: () async {
                                    print('UserId: ${commonController.userProfile.value.id!}');
                                    Utility.showLoadingDialog();
                                    bool value = await commonController.getPersonalAccount(0,25,commonController.userProfile.value.id!);
                                    Get.back();
                                    if(value){
                                      print(commonController.getAccountDetails.value.total);
                                      Get.to(()=> const AccountDetails());
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: AppColor.dropdownBoxColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                            CountryPickerUtils.getFlagImageAssetPath(commonController.countryFrom.value.isoCode!),
                                            package: "country_currency_pickers",),
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text( (commonController.getAccountDetails.value.data![0].bankAccountDetails!.balance !=null) ? "${commonController.getAccountDetails.value.data![0].bankAccountDetails!.balance!} EUR": "0.0 EUR",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                            //Text(commonController.getAccountDetails.value.data![0].bankAccountDetails!.currency!,style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.w600),)
                                            //Text("EUR",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 15,fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),

                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("Transection",style: TextStyle(color: AppColor.defaultTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
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
