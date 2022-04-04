
import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
    required this.iconData,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: AppColor.defaultColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(iconData,color: AppColor.defaultColor,),
              ),
              const SizedBox(width: 15,),
              Expanded(child: Text(text,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),))
            ],
          ),
        ),
      ),
    );
  }
}