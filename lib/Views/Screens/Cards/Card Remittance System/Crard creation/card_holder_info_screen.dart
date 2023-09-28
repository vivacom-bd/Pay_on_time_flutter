
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Models/Card%20Remittance%20System/get_title.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Crard%20creation/card_shipping_address_screen.dart';
import 'package:hidmona/Views/Widgets/country_item.dart';
import 'package:hidmona/Views/Widgets/custom_dropdown_form_field.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:intl/intl.dart';

enum CardGroup { forMe, forOthers }

class CardHolderInfoScreen extends StatefulWidget {
  static const String routeName = "CardHolderInfoScreen";

  const CardHolderInfoScreen({Key? key}) : super(key: key);

  @override
  State<CardHolderInfoScreen> createState() => _CardHolderInfoScreenState();
}

class _CardHolderInfoScreenState extends State<CardHolderInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  CommonController commonController = Get.find<CommonController>();
  TextEditingController selectCardHolder = TextEditingController();
  String ? fullName;
  List<String> nameParts = [];
  Data ?_selectedTitle;

  CardGroup _value = CardGroup.forMe;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      selectCardHolder.text = "1";
      fullName = commonController.userProfile.value.firstName!;
      nameParts = fullName!.split(" ");
      commonController.firstNameController.text = commonController.kycDataRetrieve.value.firstName!;
      commonController.middleNameController.text = commonController.kycDataRetrieve.value.middleName!;
      commonController.lastNameController.text = commonController.kycDataRetrieve.value.lastName!;
      commonController.dobController.text = commonController.kycDataRetrieve.value.dateOfBirth!;
      commonController.emailController.text = commonController.kycDataRetrieve.value.email!;
      commonController.phoneNumberController.text = (commonController.userProfile.value.phone!.substring(3)).substring(0,(commonController.userProfile.value.phone!.length-3));
      commonController.countryController.text = commonController.kycDataRetrieve.value.nationality!.name!;
      commonController.cityController.text = commonController.kycDataRetrieve.value.physicalAddress!.city!;
      commonController.stateController.text = commonController.kycDataRetrieve.value.physicalAddress!.province!;
      commonController.postalCodeController.text = commonController.kycDataRetrieve.value.physicalAddress!.postalcode!;
      commonController.addressLine1Controller.text = commonController.kycDataRetrieve.value.physicalAddress!.addressLine1!;
      commonController.addressLine2Controller.text = commonController.kycDataRetrieve.value.physicalAddress!.addressLine2!;
      commonController.othersFirstNameController.text = "";
      commonController.othersMiddleNameController.text = "";
      commonController.othersLastNameController.text = "";
      commonController.othersDobController.text = "";
      commonController.othersEmailController.text = "";
      commonController.othersPhoneNumberController.text = "";
      commonController.othersCityController.text = "";
      commonController.othersStateController.text = "";
      commonController.othersPostalCodeController.text = "";
      commonController.othersAddressLine1Controller.text = "";
      commonController.othersAddressLine2Controller.text = "";
    }));
  }
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Obx((){
                            return Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'The card is:',
                                        style: TextStyle(
                                          color: AppColor.defaultTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Radio(
                                        value: CardGroup.forMe,
                                        groupValue: _value,
                                        onChanged: (CardGroup ? value) {
                                          setState(() {
                                            _value = value!;
                                            selectCardHolder.text = "1";
                                          });
                                        },
                                      ),
                                      Text(
                                        'For Me',
                                        style: TextStyle(
                                          color: AppColor.defaultTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Radio(
                                        value: CardGroup.forOthers,
                                        groupValue: _value,
                                        onChanged: (CardGroup ? value) {
                                          setState(() {
                                            _value = value!;
                                            selectCardHolder.text = "2";
                                          });
                                        },
                                      ),
                                      Text(
                                        'For Others',
                                        style: TextStyle(
                                          color: AppColor.defaultTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Title',
                                    style: TextStyle(fontWeight: FontWeight.w600,color: AppColor.textColor),
                                  ),
                                  const SizedBox(height: 5),
                                  CustomDropDownFromField(
                                      validator: (value) {
                                        if (value == null) {
                                          return "Select Title";
                                        }
                                        return null;
                                      },

                                      items: commonController.getTitleDetails.value.data!.map((title) {
                                        return DropdownMenuItem(
                                            value: title,
                                            child: Text(title.name!, style: const TextStyle(color: Colors.black, fontSize: 16.0),)
                                        );
                                      }).toList(),
                                      selectedValue: _selectedTitle,
                                      labelAndHintText: "Select Title",
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Icon(Icons.keyboard_arrow_down_rounded,color:Get.theme.primaryColor,size: 25,),
                                      ),
                                      filledColor: AppColor.dropdownBoxColor.withOpacity(0.5),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedTitle = value as Data?;
                                          commonController.selectedTitleId = _selectedTitle?.id;

                                        });
                                        print(commonController.selectedTitleId);
                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.firstNameController : commonController.othersFirstNameController,
                                      validator: (value) {},
                                      labelText: "First Name",
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      hindText: "Enter your First name",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.middleNameController : commonController.othersMiddleNameController,
                                      validator: (value) {},
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      labelText: "Middle Name",
                                      hindText: "Enter your Middle name",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.lastNameController : commonController.othersLastNameController,
                                      validator: (value) {},
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      labelText: "Last Name",
                                      hindText: "Enter your Last name",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  (selectCardHolder.text=="1") ? CustomTextFormField(
                                      controller: commonController.dobController,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "Name can't be empty";
                                        }
                                        return null;
                                      },
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      labelText: "Date of Birth",
                                      hindText: "Date of Birth",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ) :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Date of Birth",style: TextStyle(fontWeight: FontWeight.w600,color: AppColor.textColor),),
                                      const SizedBox(height: 5,),
                                      TextFormField(
                                          controller: commonController.othersDobController,
                                          validator: (value) {
                                            if (value != null && !_isDateFormatValid(value)) {
                                              return 'Invalid date format, try dd/MM/yyyy';
                                            }
                                            return null;
                                          },
                                          decoration:InputDecoration(
                                            contentPadding: const EdgeInsets.only(top: 12,bottom: 12,left: 10,right: 0),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide.none
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide.none
                                            ),
                                            disabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide.none
                                            ),
                                            errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            isDense: true,
                                            filled: true,
                                            fillColor: Colors.grey.withOpacity(.2),
                                            //focusColor: Colors.black,
                                            //labelText: labelText,
                                            errorStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.red),
                                            hintText: "Enter Date of Birth",
                                            hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                            labelStyle: TextStyle(color: AppColor.defaultColorLight,fontWeight: FontWeight.w500,fontSize: 12),
                                          ),
                                          readOnly: true,  // when true user cannot edit text
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2100)
                                            );
                                            if (pickedDate != null) {
                                              print(
                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                              DateFormat('dd/MM/yyyy').format(pickedDate);
                                              print(
                                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                                              setState(() {
                                                commonController.othersDobController.text =
                                                    formattedDate; //set output date to TextField value.
                                              });
                                            } else {}

                                            //when click we have to show the datepicker
                                          }
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.emailController : commonController.othersEmailController,
                                      validator: (value) {
                                      },
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      labelText: "Email",
                                      hindText: "Enter your Email",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.phoneNumberController : commonController.othersPhoneNumberController,
                                      validator: (value) {
                                      },
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      labelText: "Phone Number",
                                      hindText: "Enter your Phone Number",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 20,),
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                      color: AppColor.defaultTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  (selectCardHolder.text=="1") ? CustomTextFormField(
                                      controller: commonController.countryController,
                                      validator: (value) {
                                      },
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      labelText: "Country",
                                      hindText: "Enter your Country",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ) :
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
                                      controller: (selectCardHolder.text=="1") ? commonController.cityController : commonController.othersCityController,
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      validator: (value) {

                                      },
                                      labelText: "City",
                                      hindText: "Enter your City",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.stateController : commonController.othersStateController,
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      validator: (value) {

                                      },
                                      labelText: "State",
                                      hindText: "Enter your State",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller:  (selectCardHolder.text=="1") ? commonController.postalCodeController : commonController.othersPostalCodeController,
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      validator: (value) {

                                      },
                                      labelText: "Postal Code",
                                      hindText: "Enter your postal code",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller:  (selectCardHolder.text=="1") ? commonController.addressLine1Controller : commonController.othersAddressLine1Controller,
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      validator: (value) {

                                      },
                                      labelText: "Address Line 1",
                                      hindText: "Enter Address Line 1",
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {

                                      }
                                  ),
                                  const SizedBox(height: 10,),
                                  CustomTextFormField(
                                      controller: (selectCardHolder.text=="1") ? commonController.addressLine2Controller : commonController.othersAddressLine2Controller,
                                      enabled: (selectCardHolder.text=="1") ? false : true,
                                      validator: (value) {

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
                  buttonText: "Next",
                  onTap: (){
                    setState(() {
                      commonController.checkForMeButton = (selectCardHolder.text=="1") ? true : false;
                    });
                    Get.to(const CardShippingAddress());
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
      ),
    ),
  );
  bool _isDateFormatValid(String dateString){
    try{
      DateFormat('dd/MM/yyyy').parseStrict(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }
}