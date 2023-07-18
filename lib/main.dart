import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hidmona/Controllers/app_bindings.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Controllers/theme_controller.dart';
import 'package:hidmona/Views/Screens/Login/splash_screen.dart';
import 'package:hidmona/firebase_options.dart';

import 'Views/Screens/Home/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.init();

    return LayoutBuilder(
        builder: (context,constraints) {
          return OrientationBuilder(
              builder: (context,orientation) {

                //SizeConfig
                SizeConfig.init(constraints, orientation);

                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Hidmona Money Transfer',
                  initialBinding: AppBinding(),
                  theme: ThemeController.lightTheme,
                  //darkTheme: ThemeController.darkTheme,
                  initialRoute: SplashScreen.routeName,
                  getPages: [
                    GetPage(name: SplashScreen.routeName, page: ()=>const SplashScreen()),
                    GetPage(name: HomeScreen.routeName, page: ()=>const HomeScreen()),
                  ],
                  localizationsDelegates: const [
                    DefaultWidgetsLocalizations.delegate,
                    DefaultMaterialLocalizations.delegate,
                  ],
                );
              }
          );
        }
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


