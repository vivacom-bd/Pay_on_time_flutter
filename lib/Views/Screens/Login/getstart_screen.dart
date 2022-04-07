import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

import '../../Widgets/country_item.dart';

class GetStartScreen extends StatefulWidget {
  static const String routeName = "/GetStartScreen";
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  _GetStartScreenState createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {

  CommonController controller = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(AppImage.getPath("splash_top"),width: SizeConfig.screenHeight,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(AppImage.getPath("splash_bottom"),width: SizeConfig.screenHeight,),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  Text(
                    'Hidmona',
                    style: TextStyle(
                      color: AppColor.defaultColorLight,
                      fontFamily: 'AkayaTelivigala',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'Money Transfer',
                    style: TextStyle(
                      color: AppColor.defaultColorLight,
                      fontFamily: 'AkayaTelivigala',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Obx((){
                        if(controller.serverCountries.isEmpty){
                          return SpinKitCircle(color: Get.theme.primaryColor,);
                        }else{
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Select country',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 7,),
                              InkWell(
                                onTap: (){
                                  _openCountryPickerDialog();
                                },
                                child: Container(
                                  height: 45,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.2),
                                    borderRadius  : BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Container(padding: const EdgeInsets.only(left: 10),child: CountryItem(country: controller.countryFrom.value)),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20) ,
                                          decoration: BoxDecoration(
                                            gradient: AppGradient.getColorGradient('default')
                                          ),
                                          child: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,size: 30,)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              DefaultButton(buttonText: "Start", onTap: (){
                                Get.to(()=> const LoginScreen());
                              },),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: AppColor.defaultColor),
      child: CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: AppColor.defaultColor,
        searchInputDecoration: const InputDecoration(hintText: 'Search By Country...'),
        isSearchable: true,
        title: const Text('Select country',textAlign: TextAlign.center,),
        onValuePicked: (Country country){
            controller.countryFrom.value = country;
        },
        itemBuilder: (Country country)=>CountryItem(country: country),
        itemFilter: (c) => controller.serverCountries.map((element) => element.countryCode).contains(c.isoCode),
        //itemFilter: (c) => ['AGO', 'AUS', 'AUT', 'BHR', 'BEL'].contains(c.iso3Code),
        //itemFilter: (c)=>commonSingleTon.getCountries().map((e) => e.countryCode).contains(c.iso3Code),
        // priorityList: [
        //   CountryPickerUtils.getCountryByIsoCode('TR'),
        //   CountryPickerUtils.getCountryByIsoCode('US'),
        // ],
      ),
    ),
  );

}
