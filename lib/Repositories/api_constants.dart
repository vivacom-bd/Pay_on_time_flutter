
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';

bool isDev = false;

String baseUrl(){
  //return isDev ? 'http://45.77.224.119:8080/' : 'http://45.77.224.119:8001/';
//return isDev ? 'http://45.77.224.119:8001/' : 'http://45.77.224.119:8001/';
//return isDev ? 'http://139.180.145.36:8001/' : 'http://139.180.145.36:8001/';
return isDev ? 'https://dev.hidmona.ch/' : 'https://hidmona.ch/';
}

String baseAPIUrl(){
  // return isDev ? 'http://45.77.224.119:8001/api/' : 'http://45.77.224.119:8001/api/';
 // return isDev ? 'https://dev.hidmona.ch/api/' : 'http://139.180.145.36:8002/api/';
  return isDev ? 'https://dev.hidmona.ch/api/' : 'https://hidmona.ch/api/';
}

String kycBaseUrl(){
  return isDev ? "https://kyc.hidmona.ch/api/v2/" : "https://kyc.hidmona.ch/api/v2/";
}

final headers = {
  "Content-Type": "application/json",
  'Accept' : 'application/json',
  // "x-org-domain": "hidmona"
};

// final headersWithAuth = {
//   'Content-Type': 'application/json',
//   "x-org-domain": "hidmona",
//   'Authorization': '${Get.find<CommonController>().currentUser.value.tokenType??'bearer'} '+ (Get.find<CommonController>().currentUser.value.accessToken??""),
// };


get headersWithAuth{
  return {
    // "x-org-domain": "hidmona",
    'Accept' : 'application/json',
    'Authorization': 'Bearer '+ (Get.find<CommonController>().currentUser.value.data!.token??"bearer"),
    //'Authorization': Get.find<CommonController>().currentUser.value.data!.token ??'bearer',
  };
}

get headersWithAuthAndContentType{
  return {
    "Content-Type": "application/json",
    // "x-org-domain": "hidmona",
    'Authorization': 'Bearer '+ (Get.find<CommonController>().currentUser.value.data!.token??"bearer"),

    //'Authorization': Get.find<CommonController>().currentUser.value.data!.token ??'bearer',
  };
}

get headersWithAuthAndContentTypeAndAccept{
  return {
    "Content-Type": "application/json",
    // "x-org-domain": "hidmona",
    'Accept' : 'application/json',
    'Authorization': 'Bearer '+ (Get.find<CommonController>().currentUser.value.data!.token??"bearer"),

    //'Authorization': Get.find<CommonController>().currentUser.value.data!.token ??'bearer',
  };
}
