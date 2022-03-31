import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';


// ignore: must_be_immutable
class CustomDropDownFromField extends StatelessWidget {

  CustomDropDownFromField({Key? key, @required this.items,this.prefixIcon,this.suffixIcon,required this.labelAndHintText,@required this.selectedValue,required this.onChanged,required this.validator,required this.filledColor}) : super(key: key);

  var items;
  var prefixIcon;
  var suffixIcon;
  Function validator;
  String labelAndHintText;
  void Function(Object?)? onChanged;
  var selectedValue;
  Color filledColor;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        isExpanded: true,
        // validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        iconSize: 0.0,
        style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),
        items: items,
        //onChanged: onChanged,
        alignment: Alignment.center,
        value: selectedValue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15,right: 7,top: 10,bottom: 0),
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: AppColor.defaultColor.withOpacity(0),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: AppColor.defaultColor.withOpacity(0),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: AppColor.defaultColor.withOpacity(0),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          filled: true,
          fillColor: filledColor,
          errorStyle: const TextStyle(fontSize: 10,color: Colors.red),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          //labelText: labelAndHintText,
          //labelStyle: TextStyle(color:AppColor.defaultColor.withOpacity(0.7),fontWeight: FontWeight.w400,fontSize: 10),
          hintText: labelAndHintText,
          hintStyle: const TextStyle( fontSize: 14, fontWeight: FontWeight.bold),
        ),
        onChanged: onChanged,
    );
  }
}
