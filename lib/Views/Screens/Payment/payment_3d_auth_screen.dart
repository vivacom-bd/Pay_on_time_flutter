import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hidmona/Models/pyament_auth_response.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Utilities/colors.dart';

class Payment3DAuthScreen extends StatefulWidget {

  static const String routeName = "Payment3DAuthScreen";

  const Payment3DAuthScreen({Key? key, required this.paymentAuthResponse}) : super(key: key);

  final PaymentAuthResponse paymentAuthResponse;

  @override
  _Payment3DAuthScreenState createState() => _Payment3DAuthScreenState();
}

class _Payment3DAuthScreenState extends State<Payment3DAuthScreen> {


  double _progress = 0;
  InAppWebViewController? inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Payment"),
      ),
      body: Stack(
        children: [
          InAppWebView(

            // initialUrlRequest: URLRequest(
            //     url: Uri.parse("https://payments.securetrading.net/process/payments/choice"),
            //     method: 'POST',
            //     body: Uint8List.fromList(utf8.encode("sitereference=${getSiteReference()}&stprofile=default&currencyiso3a=${CommonSingleTon().countryFrom.currencyCode}&mainamount=${(double.tryParse(CommonSingleTon().recipient.totalToPay1)??0).toStringAsFixed(2)}&version=2&transaction_id=${CommonSingleTon().summary.transcationId}&stextraurlredirectfields=transaction_id&payment_from=app&stextraurlredirectfields=payment_from&ruleidentifier=STR-6&successfulurlredirect=${baseUrl()}trustpayRedirect")),
            //     headers: {
            //       'Content-Type': 'application/x-www-form-urlencoded'
            //     }
            // ),

            initialUrlRequest: URLRequest(
                url: Uri.parse("${baseUrl()}mobile-transaction?amount=${widget.paymentAuthResponse.baseamount}&currency=${widget.paymentAuthResponse.currencyiso3a}&JWT=${widget.paymentAuthResponse.jwtToken}")
            ),
            onWebViewCreated: (controller){
              inAppWebViewController = controller;
            },
            onProgressChanged: (controller, progress){
              setState(() {
                _progress = progress/100;
              });
            },
            onLoadStart: (controller, uri) {
              String url = Uri.decodeFull(uri.toString());
              print(url);
              if(uri.toString().contains("trustpayAppCallback")){ //front-end er end point
                Navigator.of(context).pop(url);
              }
            },
            onLoadStop: (controller, uri) async {
              String url = Uri.decodeFull(uri.toString());
              // print(url);
              // if(uri.toString().contains("trustpayAppCallback")){
              //   Navigator.of(context).pop(url);
              // }
            },
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              print(challenge);
              return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            },
          ),
          _progress < 1? SizedBox(
            height: 5,
            child: LinearProgressIndicator(
              value: _progress,
              color: AppColor.defaultColorLight,
              backgroundColor: AppColor.defaultColorLight.withOpacity(.1),
            ),
          ):const SizedBox()
        ],
      ),
    );
  }

}

