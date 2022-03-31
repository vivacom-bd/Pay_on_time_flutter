import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/colors.dart';


// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {

  CustomTextFormField({required this.controller ,this.enabled = true, this.obscureText=false,required this.labelText,required this.hindText ,this.keyboardType = TextInputType.text,this.prefixIcon,this.suffixIcon,required this.onChanged,required this.validator});

  TextEditingController controller;
  bool enabled;
  String labelText;
  String hindText;
  TextInputType keyboardType;
  var prefixIcon;
  var suffixIcon;
  Function(Object) onChanged;
  String? Function(String?) validator;
  bool obscureText;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,style: TextStyle(fontWeight: FontWeight.w600,color: AppColor.textColor),),
        const SizedBox(height: 5,),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          enabled: enabled,
          autofocus: false,
          obscureText: obscureText,
          textAlign: TextAlign.start,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: 1,
          onChanged: onChanged,
          validator: validator,
          //suffixIcon: suffixIcon,
          style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
          decoration: InputDecoration(
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
                width: 1.5,
              ),
            ),
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey.withOpacity(.2),
            //focusColor: Colors.black,
            //labelText: labelText,
            errorStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.red),
            hintText: hindText,
            hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            labelStyle: TextStyle(color: AppColor.defaultColorLight,fontWeight: FontWeight.w500,fontSize: 12),
          ),
          cursorColor: AppColor.defaultColor.withOpacity(0.1),
          textInputAction: TextInputAction.next,
          //onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
      ],
    );
  }
}