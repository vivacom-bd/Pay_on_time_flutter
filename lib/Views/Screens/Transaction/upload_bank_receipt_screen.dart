import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidmona/Controllers/common_controller.dart';
import 'package:hidmona/Repositories/api_constants.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Utilities/get_picture_dialog.dart';
import 'package:hidmona/Utilities/utility.dart';
import 'package:hidmona/Views/Widgets/custom_text_form_field.dart';
import 'package:hidmona/Views/Widgets/default_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class UploadBankReceiptScreen extends StatefulWidget {
  static const String routeName = "/UploadBankReceiptScreen";

  const UploadBankReceiptScreen({Key? key, required this.transactionId}) : super(key: key);

  final int transactionId;

  @override
  _UploadBankReceiptScreenState createState() => _UploadBankReceiptScreenState();
}

class _UploadBankReceiptScreenState extends State<UploadBankReceiptScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionTextEditingController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();

  File? imageFile;

  bool isCardSave = false;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("Upload Bank Receipt"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppGradient.getColorGradient("default"),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.dropdownBoxColor.withOpacity(0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Choose Image',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 7,),

                    Row(
                      children: [
                        if(imageFile!=null) Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Image.file(imageFile!,height: 40,width: 50,fit: BoxFit.cover,),
                        ),
                        if(imageFile!=null) const SizedBox(width: 7,),
                          Expanded(
                          child: InkWell(
                            onTap: (){
                              showModal(
                                  context: context,
                                  builder: (context){
                                    return GetPictureDialog(
                                      onCamera: (){
                                        pickImage(ImageSource.camera);
                                      },
                                      onGallery: (){
                                        pickImage(ImageSource.gallery);
                                      },
                                    );
                                  }
                              );
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text("Choose image"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    CustomTextFormField(
                        controller: descriptionTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        labelText: "Description",
                        hindText: "",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {

                        }
                    ),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),

              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: DefaultButton(
                  buttonText: "Upload", onTap: () async{
                  FocusScope.of(context).unfocus();

                  if(imageFile==null){
                    Utility.showSnackBar("Choose an image");
                    return;
                  }

                  if(_formKey.currentState!.validate()){
                    Utility.showLoadingDialog();
                    //
                    // APIResponse<bool> apiResponse = await PaymentRepository.paymentAndSaveCard(cardInfo, commonController.currentTransaction!.transactionNumber!);
                    //
                    // Get.back();
                    //
                    // if(apiResponse.data != null && apiResponse.data!){
                    //   PaymentDialog.showDialog();
                    // }else{
                    //   Utility.showSnackBar(apiResponse.errorMessage?? "An Error Occurred",durationInSeconds: 5);
                    // }
                    var request = http.MultipartRequest("POST",Uri.parse(baseAPIUrl()+"bank_payment/uploads/${widget.transactionId}"));
                    request.headers.addAll(headersWithAuthAndContentTypeAndAccept);
                    request.fields["description"] = descriptionTextEditingController.text;
                    final stream = http.ByteStream(Stream.castFrom(imageFile!.openRead()));
                    final length = await imageFile!.length();
                    var file = http.MultipartFile('file', stream, length, filename: path.basename(imageFile!.path));
                    request.files.add(file);
                    var response = await request.send();
                    print(response);
                    Get.back();
                    if(response.statusCode == 201){
                      Utility.showSnackBar("File Uploaded Successfully");
                      Get.back();
                    } else {
                      Utility.showSnackBar("File is not uploaded");
                    }
                  }
                },),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }


  pickImage(ImageSource source) async{

    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 50,
    );

    if(pickedFile != null){

      setState(() {
        imageFile =  File(pickedFile.path);
      });

    }

  }

}