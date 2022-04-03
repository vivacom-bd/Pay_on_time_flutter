
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';

bool isDev = false;

String baseAPIUrl(){
  return isDev ? 'http://45.77.224.119:8888/api/v1/' : 'http://45.77.224.119:8888/api/v1/';
}

final headers = {
  "Content-Type": "application/json",
  "x-org-domain": "hidmona"
};

final headersWithAuth = {
  'Content-Type': 'application/json',
  'Authorization': '${Get.find<CommonController>().currentUser.value.tokenType??'bearer'} '+ (Get.find<CommonController>().currentUser.value.accessToken??""),
};