import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Controllers/theme_controller.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController(),permanent: true);
    Get.put(CommonController(),permanent: true);


    // Get.put(UserController(),permanent: true);
    //Get.lazyPut(() => AuthController());
  }
}