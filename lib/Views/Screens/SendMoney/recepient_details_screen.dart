import 'package:country_currency_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Models/recipient_bank.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/common_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/SendMoney/recepient_bank_info_screen.dart';
import 'package:hidmona/Views/Screens/SendMoney/recepient_details_new_screen.dart';
import 'package:hidmona/Views/Widgets/custom_dropdown_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:hidmona/Views/Widgets/recipient_item.dart';

class RecipientDetailsScreen extends StatefulWidget {
  static const String routeName = "/RecipientDetailsScreen";

  const RecipientDetailsScreen({Key? key}) : super(key: key);

  @override
  _RecipientDetailsScreenState createState() => _RecipientDetailsScreenState();
}

class _RecipientDetailsScreenState extends State<RecipientDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  CommonController commonController = Get.find<CommonController>();

  Country? selectedPhoneCountry;
  City? selectedRecipientCity;
  Country? selectedCitizenCountry;
  DateTime? dateTime;

  bool isPhoneNumberValid = false;

  String? phoneNumber;


  @override
  void initState() {
    super.initState();
    commonController.recipientCity = null;

  }


  @override
  Widget build(BuildContext context) {
    selectedPhoneCountry ??= commonController.countryTo.value;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("Choose Recipient"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppGradient.getColorGradient("default"),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formKey,
              child: Column(
                children: [

                  const SizedBox(height: 10,),
                  if(commonController.myRecipients.isNotEmpty)Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose Recipient',
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 7,),
                        CustomDropDownFromField(
                            validator: (value) {
                              if (value == null) {
                                return "Select Recipient";
                              }
                              return null;
                            },

                            items: commonController.myRecipients.map((Recipient recipient) {
                              return DropdownMenuItem(
                                  value: recipient,
                                  child: Text(recipient.fullName!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                              );
                            }).toList(),
                            selectedValue: commonController.selectedRecipient,
                            labelAndHintText: "Select Recipient",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                            ),
                            filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                            onChanged: (value) {
                              commonController.selectedRecipient = value as Recipient?;

                              // emailTextEditingController.text = selectedRecipient!.email??"";
                              // nameTextEditingController.text = selectedRecipient!.fullName??"";
                              // //addressTextEditingController.text = selectedRecipient!.streetAddress??"";
                              // //postalCodeTextEditingController.text = selectedRecipient!.postalCode.toString();
                              // //dateOfBirthTextEditingController.text = selectedRecipient!.dateOfBirth.toString();
                              //
                              // //dateTime = DateFormat("yyyy-MM-dd").parse(selectedRecipient!.dateOfBirth.toString());
                              //
                              // phone.PhoneNumberUtil().parse(selectedRecipient!.phone!).then((number){
                              //   //phoneNumber = number.nationalNumber;
                              //   phoneNumber = selectedRecipient!.phone!;
                              //   phoneTextEditingController.text = number.nationalNumber;
                              //
                              // });
                              //
                              // if(selectedRecipient!.city != null){
                              //   List<City> cities = commonController.receiveCities.where((city) => selectedRecipient!.city!.id == city.id).toList();
                              //   if(cities.isNotEmpty){
                              //     selectedRecipientCity = cities.first;
                              //   }
                              // }
                              //
                              // if(selectedRecipient!.citizenCountry != null){
                              //   List<ServerCountry> countries = commonController.serverCountries.where((country) => selectedRecipient!.citizenCountry!.id == country.id).toList();
                              //   if (countries.isNotEmpty) {
                              //     selectedCitizenCountry = CountryPickerUtils.getCountryByIsoCode(countries.first.countryCode!);
                              //   }
                              // }

                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                setState(() {});
                              });
                            }
                        ),
                      ],
                    ),
                  ),
                  if(commonController.myRecipients.isNotEmpty)const SizedBox(height: 15,),

                  if(commonController.selectedRecipient!=null)Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recipient Info',
                              style: TextStyle(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                clear();
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7,),
                        RecipientItem(recipient:commonController.selectedRecipient!,isHideButtons: true, onRefresh: (){
                            setState(() {});
                        },)
                      ]
                    )
                  ),

                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DefaultButton(buttonText: "Add New Recipient",onTap: (){
                          Get.to(()=>const RecipientDetailsNewScreen());
                        },),
                      ],
                    ),
                  ),

                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 15),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       const SizedBox(height: 10,),
                       Text(
                         'Select Recipient City',
                         style: TextStyle(
                           color: AppColor.textColor,
                           fontWeight: FontWeight.w600,
                           fontSize: 14,
                         ),
                       ),
                       const SizedBox(height: 7,),
                       CustomDropDownFromField(
                           validator: (value) {
                             if (value == null) {
                               return "Select Recipient city";
                             }
                             return null;
                           },

                           items: commonController.receiveCities.map((City city) {
                             return DropdownMenuItem(
                                 value: city,
                                 child: Text(city.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                             );
                           }).toList(),
                           selectedValue: commonController.recipientCity,
                           labelAndHintText: "Select Recipient city",
                           suffixIcon: Padding(
                             padding: const EdgeInsets.only(bottom: 4.0),
                             child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                           ),
                           filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                           onChanged: (value) {
                             setState(() {
                               commonController.recipientCity = value as City;
                             });
                           }
                       ),
                     ],
                   ),
                 ),

                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultButton(
                      buttonText: "Continue", onTap: () async{
                        FocusScope.of(context).unfocus();
                        if(_formKey.currentState!.validate()){

                           if(commonController.selectedRecipient != null){
                             Utility.showLoadingDialog();

                             APIResponse<List<RecipientBank>> apiResponse = await CommonRepository.getRecipientBanks(commonController.serverCountryTo.value.id!);

                             if(apiResponse.data != null){
                               commonController.recipientBanks = apiResponse.data!;

                               bool isGetSendingPurposes = await commonController.getSendinPurposes();
                               bool isGetCountryWiseBanks = await commonController.getCountryWiseBanks();
                               Get.back();
                               if(isGetSendingPurposes && isGetCountryWiseBanks){
                                 Get.to(const TransactionBankInfoScreen());
                               }
                             }else{
                               Get.back();
                               Utility.showSnackBar(apiResponse.message??"Failed to retrieve recipient banks.");
                             }
                           }else{
                             Utility.showSnackBar("Recipient is not selected!");
                           }
                        }
                    },),
                  ),
                  const SizedBox(height: 15,)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

   clear(){
    commonController.selectedRecipient = null;
    commonController.recipientCity = null;

    setState(() {});
  }
}
