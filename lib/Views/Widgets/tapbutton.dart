import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';

class TapButton extends StatelessWidget {
  final String buttonText;
  final IconData? iconData;
  final LinearGradient? linearGradient;
  final Function() onTap;

  const TapButton({
    Key? key,
    required this.buttonText,
    this.iconData,
    required this.onTap,
    this.linearGradient,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical:15,horizontal:20),
        decoration: BoxDecoration(
          gradient : linearGradient?? AppGradient.getColorGradient('default'),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(250), topRight: Radius.circular(250)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText,style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700),),
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
