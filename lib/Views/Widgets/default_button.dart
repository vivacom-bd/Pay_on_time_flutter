import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.buttonText,
    this.iconData,
    this.onTap,
    this.textColor = Colors.white,
    this.linearGradient,
    this.buttonColor  = "default",
  }) : super(key: key);


  final String buttonText;
  final Color textColor;
  final IconData? iconData;
  final LinearGradient? linearGradient;
  final Function()? onTap;
  final String buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical:12,horizontal:20),
        decoration: BoxDecoration(
          gradient : linearGradient?? AppGradient.getColorGradient(buttonColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText,style: TextStyle(color: textColor,fontSize: 16,fontWeight: FontWeight.bold),),
            if(iconData!=null) Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(iconData,color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }
}