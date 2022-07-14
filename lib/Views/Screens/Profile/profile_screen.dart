import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Screens/Login/login_screen.dart';
import 'package:hidmona/Views/Screens/Payment/card_list_screen.dart';
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
                // const SizedBox(height: 10,),
                // ContactItem(
                //   iconData: Icons.person,text: "Username: ${userProfile.username}",
                // ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.account_circle_outlined,text: "${commonController.userProfile.value.fullName?? commonController.userProfile.value.username}",
                ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.phone,text: "${commonController.userProfile.value.phone}",
                  onTap: () async{
                    String url = 'tel:${commonController.userProfile.value.phone}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.email_rounded,text: "${commonController.userProfile.value.email}",
                  onTap: () async{
                    String url = 'mailto:${commonController.userProfile.value.email}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                ),
                // const SizedBox(height: 10,),
                // ContactItem(
                //   iconData: Icons.location_city,text: "City: ${userProfile.city==null? "--": userProfile.city!.name??"--"}",
                //   onTap: () async{
                //
                //   },
                // ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: Icons.location_on_rounded,text: "Country: ${commonController.userProfile.value.country==null? "--": commonController.userProfile.value.country!.name??"--"}",
                  onTap: () async{

                  },
                ),
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
                Divider(color: AppColor.defaultColor),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: CupertinoIcons.creditcard,text: "Card List",
                  onTap: () {
                    Get.to(const CardListScreen());
                  },
                ),
                const SizedBox(height: 10,),
                ContactItem(
                  iconData: CupertinoIcons.arrowshape_turn_up_left_fill,text: "Logout",
                  onTap: () {

                    commonController.getStorage.erase();
                    Get.offAll(()=>const LoginScreen());
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
        ) /*FutureBuilder(
          future: UserRepository.getUserProfile(),
          builder: (context, AsyncSnapshot<APIResponse<UserProfile>> snapshot){

            if(snapshot.data != null){

              APIResponse<UserProfile> apiResponse = snapshot.data!;

              if(apiResponse.data != null){

                UserProfile userProfile = apiResponse.data!;

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 10,),
                        // ContactItem(
                        //   iconData: Icons.person,text: "Username: ${userProfile.username}",
                        // ),
                        const SizedBox(height: 10,),
                        ContactItem(
                          iconData: Icons.account_circle_outlined,text: "${userProfile.fullName?? userProfile.username}",
                        ),
                        const SizedBox(height: 10,),
                        ContactItem(
                          iconData: Icons.phone,text: "${userProfile.phone}",
                          onTap: () async{
                            String url = 'tel:${userProfile.phone}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        ContactItem(
                          iconData: Icons.email_rounded,text: "${userProfile.email}",
                          onTap: () async{
                            String url = 'mailto:${userProfile.email}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                        ),
                        // const SizedBox(height: 10,),
                        // ContactItem(
                        //   iconData: Icons.location_city,text: "City: ${userProfile.city==null? "--": userProfile.city!.name??"--"}",
                        //   onTap: () async{
                        //
                        //   },
                        // ),
                        const SizedBox(height: 10,),
                        ContactItem(
                          iconData: Icons.location_on_rounded,text: "Country: ${userProfile.country==null? "--": userProfile.country!.name??"--"}",
                          onTap: () async{

                          },
                        ),
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
                        Divider(color: AppColor.defaultColor),
                        const SizedBox(height: 10,),
                        ContactItem(
                          iconData: CupertinoIcons.creditcard,text: "Card List",
                          onTap: () {
                            Get.to(const CardListScreen());
                          },
                        ),
                        const SizedBox(height: 10,),
                        ContactItem(
                          iconData: CupertinoIcons.arrowshape_turn_up_left_fill,text: "Logout",
                          onTap: () {

                            commonController.getStorage.erase();

                            Get.offAll(()=>const LoginScreen());
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
                );
              }else{
                return Center(child: Text(apiResponse.message??"An Error Occurred"),);
              }

            }else{
              return Center(child: SpinKitCircle(color: AppColor.defaultColor,),);
            }

          },
        )*/
      )
    );
  }
}