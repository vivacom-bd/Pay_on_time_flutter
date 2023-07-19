import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/account_screen.dart';
import 'package:hidmona/Views/Screens/Cards/Accounts/create_account_option_screen.dart';
import 'package:hidmona/Views/Screens/Home/home_screen.dart';
import 'package:hidmona/Views/Screens/Recipient/my_recipients_screen.dart';
import 'package:hidmona/Views/Screens/Transaction/transaction_history_screen.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Container(
            //   height: SizeConfig.screenHeight*0.2,
            //   child: DrawerHeader(
            //     decoration: BoxDecoration(
            //       borderRadius:  BorderRadius.circular(10.0),
            //     ),
            //     child: Column(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(20.0),
            //           child: Row(
            //             children: [
            //               CircleAvatar(
            //                 radius: 35,
            //                 backgroundImage: AssetImage(AppImage.getPath("user"),),
            //                 //backgroundImage: NetworkImage(commonProvider.getDriverDetails()!.data!.profileImage!),
            //               ),
            //               const SizedBox(width: 15.0),
            //               Column(
            //                 children:  [
            //                   Text(
            //                     CommonController().userProfile.value.fullName! ?? CommonController().userProfile.value.username!,
            //                     style: TextStyle(
            //                         fontSize: 16.0,
            //                         fontWeight: FontWeight.bold,
            //                         fontFamily: "Jost"
            //                     ),
            //                   ),
            //                   Text(
            //                     "ewu.jehan@gmail.com",
            //                     style: TextStyle(
            //                         fontSize: 12.0,
            //                         fontFamily: "Jost"
            //                     ),
            //                     //getCommonProvider.getDriverDetails()!.data!.phoneCode! + getCommonProvider.getDriverDetails()!.data!.phoneNumber!
            //                   ),
            //                   Text(
            //                     "+880 1762350424",
            //                     style: TextStyle(
            //                         fontSize: 12.0,
            //                         fontFamily: "Jost"
            //                     ),
            //                     //getCommonProvider.getDriverDetails()!.data!.phoneCode! + getCommonProvider.getDriverDetails()!.data!.phoneNumber!
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    shape: BoxShape.circle
                ),
                child: Image.asset(AppImage.getPath("user")),
              ),
              title: Text('Home'),
              onTap: () => {
                Get.to(const HomeScreen()),
              },
            ),
            ListTile(
              leading:Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    shape: BoxShape.circle
                ),
                child: Image.asset(AppImage.getPath("personal_account")),
              ),
              title: Text('Account'),
              onTap: () async {
                Utility.showLoadingDialog();
                bool value = await CommonController().getPersonalAccount(0,25,commonController.userProfile.value.id!);
                Get.back();
                if(value){
                  Get.to(()=> const AccountScreen());
                } else{print("jehan");}
              },
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    shape: BoxShape.circle
                ),
                child: Image.asset(AppImage.getPath("history")),
              ),
              title: Text('Transaction History'),
              onTap: (){
                Get.to(const TransactionHistoryScreen());
              },
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    shape: BoxShape.circle
                ),
                child: Image.asset(AppImage.getPath("users")),
              ),
              title: Text('My Recipient'),
              onTap: (){
                Get.to(const MyRecipientScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
