import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidmona/Utilities/colors.dart';

class SendMoneyCalculationItem extends StatelessWidget {
  const SendMoneyCalculationItem({required this.iconPath, required this.title, required this.value});

  final String iconPath;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(7),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.defaultColorLight,
                  shape: BoxShape.circle
                ),
                child: SvgPicture.asset(iconPath, height: 20,width: 20, fit: BoxFit.fill,)
            ),
            const SizedBox(width: 10,),
            Text(title,style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
          ],
        ),
        Expanded(child: Text(value,textAlign: TextAlign.end,style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),))
      ],
    );
  }

}

