import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/size_config.dart';

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
    // Future.delayed(const Duration(seconds: 1), (){
    //     Get.to( ()=>const GetStartScreen());
    //   }
    // );
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
          Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.8,),
              SpinKitCircle(color: AppColor.defaultColor,)
            ],
          ),),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AppImage.getPath("splash_bottom"),width: SizeConfig.screenWidth,),
          )
        ],
      ),
    );
  }
}
