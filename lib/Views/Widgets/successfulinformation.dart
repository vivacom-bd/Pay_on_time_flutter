import 'package:flutter/cupertino.dart';
import 'package:hidmona/Utilities/colors.dart';

class SuccessfulInformation extends StatelessWidget {
  const SuccessfulInformation({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(padding: EdgeInsets.only(left: 23.0,right: 23.0),),
        Row(
          children: [
            Text(title,style:  TextStyle(fontSize: 13,color: AppColor.defaultTextColor,fontWeight: FontWeight.bold),)
          ],
        ),
        Expanded(child: Text(value,textAlign: TextAlign.end,style: TextStyle(fontSize: 13, color: AppColor.defaultTextColor,fontWeight: FontWeight.bold),))
      ],
    );
  }

}

