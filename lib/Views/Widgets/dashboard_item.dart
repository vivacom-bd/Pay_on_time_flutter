import 'package:flutter/material.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';


class DashboardExploreItem extends StatelessWidget {
  const DashboardExploreItem({
    Key? key,
    required this.iconName,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final String iconName;
  final String title;
  final String subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: AppColor.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: AppColor.defaultColor.withOpacity(.1),offset: const Offset(2,5),blurRadius: 7)]
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  shape: BoxShape.circle
              ),
              child: Image.asset(AppImage.getPath(iconName)),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Color(0xFF000000),fontSize: 17,fontWeight: FontWeight.w600),),
                  //Text(subtitle, style: TextStyle(color: Color(0xFF474747),fontSize: 10,fontWeight: FontWeight.w400),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}