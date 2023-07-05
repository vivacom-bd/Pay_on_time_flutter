import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/card_holder_list_screen.dart';
import 'package:hidmona/Views/Screens/Cards/my_card_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';

class CardShippingAddress extends StatefulWidget {
  static const String routeName = "CardShippingAddress";
  const CardShippingAddress({Key? key}) : super(key: key);

  @override
  State<CardShippingAddress> createState() => _CardShippingAddressState();
}

class _CardShippingAddressState extends State<CardShippingAddress> {
  final _formKey = GlobalKey<FormState>();
  Country? selectedCountry;
  Country? selectedCitizenCountry;
  CommonController commonController = Get.find<CommonController>();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController selectCardHolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Obx((){
                            return  Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Card Shipping Address',
                                    style: TextStyle(
                                      color: AppColor.defaultTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
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
                                            child: Container(padding: const EdgeInsets.only(left: 10),child: CountryItem(country: commonController.shippingCountry.value)),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20) ,
                                              decoration: BoxDecoration(
                                                //color: AppColor.defaultColorLight,
                                                  gradient: AppGradient.getColorGradient('default')
                                              ),
                                              child: const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,size: 30,)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: cityController,
                                      enabled: true,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "City can't be empty";
                                        }
                                        return null;
                                      },
                                      labelText: "City",
                                      hindText: "Enter your City",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: stateController,
                                      enabled: true,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "State can't be empty";
                                        }
                                        return null;
                                      },
                                      labelText: "State",
                                      hindText: "Enter your State",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: postalCodeController,
                                      enabled: true,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "State can't be empty";
                                        }
                                        return null;
                                      },
                                      labelText: "Postal Code",
                                      hindText: "Enter your postal code",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: addressLine1Controller,
                                      enabled: true,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "Address Line 1 can't be empty";
                                        }
                                        return null;
                                      },
                                      labelText: "Address Line 1",
                                      hindText: "Enter Address Line 1",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: addressLine2Controller,
                                      enabled: true,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return null;
                                        }
                                        return null;
                                      },
                                      labelText: "Address Line 2",
                                      hindText: "Enter Address Line 2",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                ],
                              ),
                            );
                          }),

                        ),
                      ],
                    ),
                  ),
                ),
                DefaultButton(
                  buttonText: "Submit",
                  onTap: () async {
                    print(
                      "${commonController.countryFrom.value.iso3Code!},${commonController.phoneNumberController.text},${commonController.selectedTitleId},${commonController.firstNameController.text},${commonController.middleNameController.text},${commonController.lastNameController.text},${commonController.dobController.text},${commonController.emailController.text},${commonController.cityController.text},${commonController.stateController.text},${commonController.addressLine1Controller.text},${commonController.addressLine2Controller.text},",
                    );
                    print("${commonController.shippingCountry.value.iso3Code}.${cityController.text},${cityController.text},${stateController.text},${addressLine1Controller.text},${addressLine2Controller.text}");
                    Utility.showLoadingDialog();
                    bool value = await commonController.cardHolder(
                      commonController.testID,
                      58,
                      commonController.selectedTitleId!,
                      "SuffixName",
                      commonController.firstNameController.text,
                      commonController.middleNameController.text,
                      commonController.lastNameController.text,
                      "embossedNmmm",
                      commonController.dobController.text,
                      commonController.emailController.text,
                      "username",
                      "clientRef",
                      commonController.countryFrom.value.iso3Code!,
                      commonController.phoneNumberController.text,
                      commonController.countryFrom.value.iso3Code!,
                      commonController.cityController.text,
                      commonController.stateController.text,
                      commonController.postalCodeController.text,
                      commonController.addressLine1Controller.text,
                      commonController.addressLine2Controller.text,
                      commonController.shippingCountry.value.iso3Code!,
                      cityController.text,
                      stateController.text,
                      postalCodeController.text,
                      addressLine1Controller.text,
                      addressLine2Controller.text,
                      false
                    );
                    Get.back();
                    if(value){
                        Utility.showLoadingDialog();
                        bool value = await commonController.cardOrder(commonController.testID, commonController.createCardHolder.value.data!.id!);

                        if(value){
                          bool value = await commonController.getPersonalAccountCard(0,25,commonController.testID);
                          if(value){
                            bool value = await commonController.getCardStatus(commonController.testID, commonController.personalAccountCard.value.data![0].id!);
                            Get.back();
                            if(value){
                              print("Success");
                            }
                          }
                          //Get.to(()=> const MyCardScreen());
                        }
                      //print(commonController.currentPersonalAccount.value.success);
                      Get.to(const CardHolderListScreen());
                    }
                  },
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
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
          commonController.shippingCountry.value = country;
        },
        itemBuilder: (Country country)=>CountryItem(country: country),
        itemFilter: (c) => commonController.serverCountries.map((element) => element.countryCode).contains(c.isoCode),
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
