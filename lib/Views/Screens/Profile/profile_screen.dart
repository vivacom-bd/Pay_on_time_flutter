import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';
import 'package:hidmona/Views/Widgets/contact_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {

  static const String routeName = "ProfileScreen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  CommonController commonController = Get.find<CommonController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const Text("Profile"),
        // actions: [
        //   InkWell(
        //     onTap: (){
        //
        //     },
        //     child: Container(
        //       padding: EdgeInsets.all(17),
        //       child: Text("Edit",style: TextStyle(color: AppColor.defaultColor,fontSize: 16,fontWeight: FontWeight.w700),)
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.person,text: "Username: ${commonController.currentUser.value.username}",
                ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.account_circle_outlined,text: "${commonController.currentUser.value.fullName}",
                ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.phone,text: "${commonController.currentUser.value.phone}",
                  onTap: () async{
                    String url = 'tel:${commonController.currentUser.value.phone}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.email_rounded,text: "${commonController.currentUser.value.email}",
                  onTap: () async{
                    String url = 'mailto:${commonController.currentUser.value.email}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                ),
                // const SizedBox(height: 10,),
                // ContactItem(
                //   iconData: Icons.location_city,text: "City: ${currentUser.appUser.city==null? "--": currentUser.appUser.city}",
                //   onTap: () async{
                //
                //   },
                // ),
                // const SizedBox(height: 10,),
                // ContactItem(
                //   iconData: CupertinoIcons.location,text: "Country: ${currentUser.appUser.country==null? "--": currentUser.appUser.country}",
                //   onTap: () async{
                //
                //   },
                // ),
                // const SizedBox(height: 10,),
                // ContactItem(
                //   iconData: Icons.date_range_rounded,text: "Birth Date: ${currentUser.appUser.dob}",
                //   onTap: () async{
                //
                //   },
                // ),
                const SizedBox(height: 10,),
                Divider(color: AppColor.defaultColor,),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: CupertinoIcons.arrowshape_turn_up_left_fill,text: "Logout",
                  onTap: () {
                    Get.offAll(const LoginScreen());
                  },
                ),
                // SizedBox(height: 10,),
                // ContactItem(
                //   themeProvider: themeProvider,iconData: Icons.help,text: "Help",
                //   onTap: () async{
                //     String url = 'https://www.getbetal.com/help';
                //     if (await canLaunch(url)) {
                //       await launch(url);
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      )
    );
  }
}