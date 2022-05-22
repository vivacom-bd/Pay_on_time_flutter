import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/recipient_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/SendMoney/recepient_bank_info_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/custom_dropdown_form_field.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:phone_number/phone_number.dart' as phone;

class RecipientDetailsScreen extends StatefulWidget {
  static const String routeName = "/RecipientDetailsScreen";

  const RecipientDetailsScreen({Key? key}) : super(key: key);

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
  Recipient? selectedRecipient;
  DateTime? dateTime;

  bool isPhoneNumberValid = false;

  String? phoneNumber;


  @override
  void initState() {
    super.initState();
    commonController.senderCity = null;
  }


  @override
  Widget build(BuildContext context) {
    selectedPhoneCountry ??= commonController.countryTo.value;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
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
                              // if (value == null) {
                              //   return "Select Recipient";
                              // }
                              return null;
                            },

                            items: commonController.myRecipients.map((Recipient recipient) {
                              return DropdownMenuItem(
                                  value: recipient,
                                  child: Text(recipient.fullName!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                              );
                            }).toList(),
                            selectedValue: selectedRecipient,
                            labelAndHintText: "Select Recipient",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                            ),
                            filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                            onChanged: (value) {

                              selectedRecipient = value as Recipient;

                              emailTextEditingController.text = selectedRecipient!.email??"";
                              nameTextEditingController.text = selectedRecipient!.fullName??"";
                              //addressTextEditingController.text = selectedRecipient!.streetAddress??"";
                              //postalCodeTextEditingController.text = selectedRecipient!.postalCode.toString();
                              //dateOfBirthTextEditingController.text = selectedRecipient!.dateOfBirth.toString();

                              //dateTime = DateFormat("yyyy-MM-dd").parse(selectedRecipient!.dateOfBirth.toString());

                              phone.PhoneNumberUtil().parse(selectedRecipient!.phone!).then((number){
                                //phoneNumber = number.nationalNumber;
                                print(phoneNumber);
                                phoneTextEditingController.text = number.nationalNumber;

                              });

                              if(selectedRecipient!.city != null){
                                List<City> cities = commonController.receiveCities.where((city) => selectedRecipient!.city!.id == city.id).toList();
                                if(cities.isNotEmpty){
                                  selectedRecipientCity = cities.first;
                                }
                              }

                              if(selectedRecipient!.citizenCountry != null){
                                List<ServerCountry> countries = commonController.serverCountries.where((country) => selectedRecipient!.citizenCountry!.id == country.id).toList();
                                if (countries.isNotEmpty) {
                                  selectedCitizenCountry = CountryPickerUtils.getCountryByIsoCode(countries.first.countryCode!);
                                }
                              }

                              setState(() {});
                            }
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
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
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 7),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.dropdownBoxColor.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomTextFormField(
                          //   controller: emailTextEditingController,
                          //     validator: (value) {
                          //       if(value!.isEmpty){
                          //         return "Field can't be empty";
                          //       }else if(!value.isEmail){
                          //         return "Enter correct email";
                          //       }
                          //       return null;
                          //     },
                          //     //enabled: selectedRecipient == null,
                          //     labelText: "Email",
                          //     hindText: "",
                          //     keyboardType: TextInputType.emailAddress,
                          //     onChanged: (value) {
                          //
                          //     }
                          // ),
                          // const SizedBox(height: 10,),
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
                                  //_openCountryPickerDialog();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      CountryItem(country: selectedPhoneCountry,titleType: "flag",),
                                      //const Icon(Icons.arrow_drop_down)
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
                          // const SizedBox(height: 10,),
                          // CustomTextFormField(
                          //     controller: addressTextEditingController,
                          //     validator: (value) {
                          //       if(value!.isEmpty){
                          //         return "Field can't be empty";
                          //       }
                          //       return null;
                          //     },
                          //     labelText: "Address",
                          //     hindText: "",
                          //     keyboardType: TextInputType.text,
                          //     onChanged: (value) {
                          //
                          //     }
                          // ),
                          // const SizedBox(height: 10,),
                          // CustomTextFormField(
                          //     controller: postalCodeTextEditingController,
                          //     validator: (value) {
                          //       if(value!.isEmpty){
                          //         return "Field can't be empty";
                          //       }
                          //       return null;
                          //     },
                          //     labelText: "Postal Code",
                          //     hindText: "",
                          //     keyboardType: TextInputType.number,
                          //     onChanged: (value) {
                          //
                          //     }
                          // ),
                          // const SizedBox(height: 10,),
                          // InkWell(
                          //   onTap: ()async{
                          //     dateTime = await showDatePicker(
                          //       initialEntryMode: DatePickerEntryMode.calendar,
                          //       context: context,
                          //       initialDate: dateTime ?? DateTime.now(),
                          //       firstDate: DateFormat("dd-mm-yyyy").parse("01-01-1930"),
                          //       lastDate: DateTime.now(),
                          //       currentDate: DateTime.now(),
                          //       builder: (context,child) {
                          //         return Theme(
                          //           data: Get.theme.copyWith(
                          //             colorScheme: Get.theme.colorScheme.copyWith(primary: Theme.of(context).primaryColor),
                          //             buttonTheme: const ButtonThemeData(
                          //                 textTheme: ButtonTextTheme.primary
                          //             ),
                          //           ),
                          //           child: child!,
                          //         );
                          //       },
                          //     );
                          //
                          //     if(dateTime!=null) {
                          //
                          //       dateOfBirthTextEditingController.text = DateFormat("dd MMM, yyyy").format(dateTime!);
                          //       //FocusScope.of(context).requestFocus(FocusNode());
                          //     }
                          //   },
                          //   child: CustomTextFormField(
                          //       controller: dateOfBirthTextEditingController,
                          //       enabled: false,
                          //       validator: (value) {
                          //         if(value!.isEmpty){
                          //           return "Field can't be empty";
                          //         }
                          //         return null;
                          //       },
                          //       labelText: "Date Of Birth",
                          //       hindText: "",
                          //       keyboardType: TextInputType.text,
                          //       onChanged: (value) async{
                          //
                          //       }
                          //   ),
                          // ),
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

                              items: commonController.receiveCities.map((City city) {
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
                                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CountryItem(country: selectedCitizenCountry),
                                    Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 5,),
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
                         'Select Sender City',
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
                               return "Select Sender city";
                             }
                             return null;
                           },

                           items: commonController.sendingCities.map((City city) {
                             return DropdownMenuItem(
                                 value: city,
                                 child: Text(city.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                             );
                           }).toList(),
                           selectedValue: commonController.senderCity,
                           labelAndHintText: "Select Sender city",
                           suffixIcon: Padding(
                             padding: const EdgeInsets.only(bottom: 4.0),
                             child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                           ),
                           filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                           onChanged: (value) {
                             setState(() {
                               commonController.senderCity = value as City;
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

                          Utility.showLoadingDialog();

                          RecipientRequestBody recipientRequestBody =  RecipientRequestBody(
                            //email: emailTextEditingController.text,
                            fullName: nameTextEditingController.text,
                            phone: phoneNumber,
                            //streetAddress: addressTextEditingController.text,
                            //postalCode: int.tryParse(postalCodeTextEditingController.text),
                            //dateOfBirth: DateFormat("yyyy-MM-dd").format(dateTime!),
                            countryId: commonController.serverCountryTo.value.id,
                            citizenCountryId: commonController.getServerCountryFromCountryCode(selectedCitizenCountry!.isoCode!).id,
                            cityId: selectedRecipientCity!.id,
                            isCitizen: commonController.serverCountryTo.value.id == commonController.getServerCountryFromCountryCode(selectedCitizenCountry!.isoCode!).id
                          );

                          commonController.selectedRecipient = null;

                          if(selectedRecipient == null){
                            APIResponse<Recipient> value = await RecipientRepository.createRecipient(recipientRequestBody);
                            if(value.data != null){
                              commonController.selectedRecipient = value.data;
                            }else{
                              Utility.showSnackBar(value.message??"Recipient Not Created");
                            }
                          }else{
                            APIResponse<Recipient> value = await RecipientRepository.updateRecipient(selectedRecipient!.id!,recipientRequestBody);
                            if(value.data != null){
                              commonController.selectedRecipient = value.data;
                            }else{
                              Utility.showSnackBar(value.message??"Recipient Not Updated");
                            }
                          }

                          if(commonController.selectedRecipient != null){
                            bool isGetSendingPurposes = await commonController.getSendinPurposes();
                            bool isGetCountryWiseBanks = await commonController.getCountryWiseBanks();
                            Get.back();
                            if(isGetSendingPurposes && isGetCountryWiseBanks){
                              Get.to(const TransactionBankInfoScreen());
                            }
                          }else{
                            Get.back();
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



  void phoneNumberValidator(String value){

    Future.delayed(const Duration(seconds: 1),(){
      PhoneNumberUtil.normalizePhoneNumber(phoneNumber: value, isoCode: selectedPhoneCountry!.isoCode!).then((normalizedPhoneNumber){
        PhoneNumberUtil.isValidPhoneNumber(phoneNumber: normalizedPhoneNumber!, isoCode:selectedPhoneCountry!.isoCode!).then((isPhoneValid){

          if(isPhoneValid!){
            phoneNumber = normalizedPhoneNumber;
            print(phoneNumber);
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

  clear(){
    selectedRecipient = null;

    emailTextEditingController.text = "";
    nameTextEditingController.text = "";
    phoneTextEditingController.text = "";
    addressTextEditingController.text = "";
    postalCodeTextEditingController.text = "";
    dateOfBirthTextEditingController.text = "";
    selectedRecipientCity = null;
    selectedCitizenCountry =  null;

    setState(() {});
  }
}
