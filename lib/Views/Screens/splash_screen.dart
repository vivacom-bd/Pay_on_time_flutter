import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Views/Screens/getstart_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {


    super.initState();
    Future.delayed(const Duration(seconds: 1), (){
        Get.to( ()=>const GetStartScreen());
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   Get.find<ThemeController>().changeThemeMode();
    // });

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(AppImage.getPath("splash_top"),width: SizeConfig.screenWidth,),
          ),
          Center(child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.8,),),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AppImage.getPath("splash_bottom"),width: SizeConfig.screenWidth,),
          )
        ],
      ),
    );
  }
}
