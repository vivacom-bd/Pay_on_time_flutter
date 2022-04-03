import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/custom_dropdown_form_field.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:libphonenumber/libphonenumber.dart';

class RecipientDetailsScreen extends StatefulWidget {
  static const String routeName = "/RecipientDetailsScreen";

  @override
  _RecipientDetailsScreenState createState() => _RecipientDetailsScreenState();
}

class _RecipientDetailsScreenState extends State<RecipientDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController addressTextEditingController = TextEditingController();
  final TextEditingController postalCodeTextEditingController = TextEditingController();
  final TextEditingController dateOfBirthTextEditingController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();

  Country? selectedPhoneCountry;
  City? selectedRecipientCity;
  Country? selectedCitizenCountry;

  bool isPhoneNumberValid = false;

  String? phoneNumber;


  @override
  void initState() {
    super.initState();

    commonController.selectedRecipient = null;
  }


  @override
  Widget build(BuildContext context) {

    selectedPhoneCountry ??= commonController.countryTo.value;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: const Text("Recipient Details"),
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Recipient',
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
                            labelAndHintText: "Select mode of payment",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                            ),
                            filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                            onChanged: (value) {
                              setState(() {
                                commonController.selectedRecipient = value as Recipient;
                              });
                            }
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.dropdownBoxColor.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: emailTextEditingController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Field can't be empty";
                                }else if(!value.isEmail){
                                  return "Enter correct email";
                                }
                                return null;
                              },
                              labelText: "Email",
                              hindText: "",
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {

                              }
                          ),
                          const SizedBox(height: 10,),
                          CustomTextFormField(
                              controller: nameTextEditingController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Field can't be empty";
                                }
                                return null;
                              },
                              labelText: "Full Name",
                              hindText: "",
                              keyboardType: TextInputType.text,
                              onChanged: (value) {

                              }
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            'Phone No.',
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 7,),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  FocusScope.of(context).unfocus();
                                  _openCountryPickerDialog();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      CountryItem(country: selectedPhoneCountry,titleType: "flag",),
                                      const Icon(Icons.arrow_drop_down)
                                    ],
                                  )
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Expanded(
                                child: CustomTextFormField(
                                    controller: phoneTextEditingController,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Field can't be empty";
                                      }else{
                                        if(value.length<3) return "Phone number is not valid formatted";

                                        phoneNumberValidator(value);

                                        if(!isPhoneNumberValid){
                                          return "Phone number is not valid formatted";
                                        }
                                      }
                                    },
                                    labelText: "",
                                    hindText: "",
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {

                                    }
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          CustomTextFormField(
                              controller: addressTextEditingController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Field can't be empty";
                                }
                                return null;
                              },
                              labelText: "Address",
                              hindText: "",
                              keyboardType: TextInputType.text,
                              onChanged: (value) {

                              }
                          ),
                          const SizedBox(height: 10,),
                          CustomTextFormField(
                              controller: postalCodeTextEditingController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Field can't be empty";
                                }
                                return null;
                              },
                              labelText: "Postal Code",
                              hindText: "",
                              keyboardType: TextInputType.text,
                              onChanged: (value) {

                              }
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            'Select City',
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
                                  return "Select city";
                                }
                                return null;
                              },

                              items: commonController.cities.map((City city) {
                                return DropdownMenuItem(
                                    value: city,
                                    child: Text(city.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                                );
                              }).toList(),
                              selectedValue: selectedRecipientCity,
                              labelAndHintText: "Select city",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                              ),
                              filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                              onChanged: (value) {
                                setState(() {
                                  selectedRecipientCity = value as City;
                                });
                              }
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            'Select Citizen Country',
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 7,),
                          InkWell(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                              _openCountryPickerDialog(type: "Citizen");
                            },
                            child: Container(
                                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CountryItem(country: selectedCitizenCountry),
                                    const Icon(Icons.arrow_drop_down)
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 5,),
                        ],
                      ),
                  ),

                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultButton(
                      buttonText: "Continue", onTap: () {
                        FocusScope.of(context).unfocus();
                        if(_formKey.currentState!.validate()){

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


  void _openCountryPickerDialog({String type = "Phone"}) => showDialog(
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
          if(type == "Phone"){
            setState(() {
              selectedPhoneCountry = country;
            });
          }else if(type == "Citizen"){
            setState(() {
              selectedCitizenCountry = country;
            });
          }
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



  void phoneNumberValidator(String value) async {

    Future.delayed(const Duration(seconds: 1),(){
      PhoneNumberUtil.normalizePhoneNumber(phoneNumber: value, isoCode: selectedPhoneCountry!.isoCode!).then((normalizedPhoneNumber){
        PhoneNumberUtil.isValidPhoneNumber(phoneNumber: normalizedPhoneNumber!, isoCode:selectedPhoneCountry!.isoCode!).then((isPhoneValid){

          if(isPhoneValid!){
            // phone.PhoneNumberUtil().parse(normalizedPhoneNumber).then((number){
            //   phoneNumber = number.nationalNumber;
            //   print(phoneNumber);
            //
            // });

            phoneNumber = normalizedPhoneNumber;
          }

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            if(mounted){
              setState(() {
                isPhoneNumberValid = isPhoneValid;
              });
            }
          });
        });
      });
    });
  }
}
