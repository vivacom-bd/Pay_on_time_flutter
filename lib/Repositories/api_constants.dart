
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';

bool isDev = false;

String baseAPIUrl(){
  return isDev ? 'https://api.hidmona.ch/api/v1/' : 'https://api.hidmona.ch/api/v1/';
}

String kycBaseUrl(){
  return isDev ? "https://kyc.hidmona.ch/api/v2/" : "https://kyc.hidmona.ch/api/v2/";
}

final headers = {
  "Content-Type": "application/json",
  "x-org-domain": "hidmona"
};

final headersWithAuth = {
  'Content-Type': 'application/json',
  'Authorization': '${Get.find<CommonController>().currentUser.value.tokenType??'bearer'} '+ (Get.find<CommonController>().currentUser.value.accessToken??""),
};