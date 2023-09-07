
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';

bool isDev = true;

String baseUrl(){
  return isDev ? 'http://45.77.224.119:8001/api/' : 'http://45.77.224.119:8001/api/';
}

String baseAPIUrl(){
  return isDev ? 'http://45.77.224.119:8001/api/' : 'http://45.77.224.119:8001/api/';
}

String kycBaseUrl(){
  return isDev ? "https://kyc.hidmona.ch/api/v2/" : "https://kyc.hidmona.ch/api/v2/";
}

final headers = {
  "Content-Type": "application/json",
  "x-org-domain": "hidmona"
};

// final headersWithAuth = {
//   'Content-Type': 'application/json',
//   "x-org-domain": "hidmona",
//   'Authorization': '${Get.find<CommonController>().currentUser.value.tokenType??'bearer'} '+ (Get.find<CommonController>().currentUser.value.accessToken??""),
// };


get headersWithAuth{
  return {
    'Content-Type': 'application/json',
    "x-org-domain": "hidmona",
    'Authorization': '${Get.find<CommonController>().currentUser.value.tokenType??'bearer'} '+ (Get.find<CommonController>().currentUser.value.accessToken??""),
  };
}