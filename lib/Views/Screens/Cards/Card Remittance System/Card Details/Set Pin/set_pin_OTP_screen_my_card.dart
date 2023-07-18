import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/images.dart';
import 'package:hidmona/Utilities/side_bar.dart';
import 'package:hidmona/Utilities/size_config.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Details/Set%20Pin/set_card_pin_popup.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Set%20Pin/set_card_pin_popup.dart';
import 'package:hidmona/Views/Screens/Cards/Card%20Remittance%20System/Card%20Loading/load_card_screen.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';


class SetPinOTPScreenMyScreen extends StatefulWidget {
  const SetPinOTPScreenMyScreen({Key? key}) : super(key: key);

  @override
  State<SetPinOTPScreenMyScreen> createState() => _SetPinOTPScreenMyScreenState();
}

class _SetPinOTPScreenMyScreenState extends State<SetPinOTPScreenMyScreen> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  CommonController commonController = Get.find<CommonController>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        _globalKey.currentState?.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: AppColor.defaultColorLight,
                      ),
                    ),
                    const SizedBox(width: 40,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(AppImage.getPath("logo"),width: SizeConfig.screenWidth*.4,),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Set Card PIN',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  'In order to be able to set a new card PIN kindly enter the One Time Password (OTP) we just sent to your email.',
                                  style: TextStyle(
                                    color: AppColor.defaultTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                CustomTextFormField(
                                    controller: otpController,
                                    enabled: true,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "OTP can't be empty";
                                      }
                                      return null;
                                    },
                                    labelText: "OTP Code",
                                    hindText: "OTP Code",
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {

                                    }
                                ),
                              ],
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                DefaultButton(
                  buttonText: "Confirm",
                  onTap: () async {
                    Utility.showLoadingDialog();
                    bool value = await commonController.verifyOTP(int.parse(otpController.text));
                    if(value){
                      showDialog(
                          context: context,
                          builder: (context){
                            return const DialogForSetPinMyCard();
                          }
                      );
                    }else{Get.back();}
                  },
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
