import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';

class CountryItem extends StatelessWidget {

  final Country? country;
  final String titleType;

  const CountryItem({this.country,this.titleType="name"});

  @override
  Widget build(BuildContext context) {
    return (country==null || country!.isoCode==null)? const Align(alignment: Alignment.centerLeft,child: Text("Select Country",style:  TextStyle(fontSize: 13,fontWeight: FontWeight.w600),)) : Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country!),
        if(titleType != "flag")const SizedBox(width: 6.0),
        //Text("+${country.phoneCode}"),
        //SizedBox(width: 8.0),
        if(titleType == "name") Flexible(child: Text(country!.name!,style:  const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
        if(titleType == "currencyCode") Flexible(child: Text(country!.currencyCode!,style: TextStyle(color: AppColor.boxColor,fontSize: 15,fontWeight: FontWeight.w600),)),
        if(titleType == "iso3Code") Flexible(child: Text(country!.iso3Code!,style:  TextStyle(color: AppColor.boxColor,fontSize: 15,fontWeight: FontWeight.w600),)),
        if(titleType == "phoneCode") Flexible(child: Text(country!.phoneCode!,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
        if(titleType == "countryWithPhoneCode") Flexible(child: Text("${country!.phoneCode} (${country!.name})",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
      ],
    );
  }
}
