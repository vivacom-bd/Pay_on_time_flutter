import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Views/Screens/Profile/profile_screen.dart';
import 'package:hidmona/Views/Widgets/dashboard_item.dart';

class AccountOptionScreen extends StatefulWidget {
  const AccountOptionScreen({Key? key}) : super(key: key);

  @override
  State<AccountOptionScreen> createState() => _AccountOptionScreenState();
}

class _AccountOptionScreenState extends State<AccountOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Center(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    DashboardExploreItem(title: "Create an Personal Account",subtitle: "See your profile here",iconName: "user",
                      onTap: (){
                        Get.to(const ProfileScreen());
                      },
                    ),
                    const SizedBox(height: 10,),
                    DashboardExploreItem(title: "Create an Company Account",subtitle: "See your Account here",iconName: "users",
                      onTap: (){
                        //Get.to(const ProfileScreen());
                      },
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
