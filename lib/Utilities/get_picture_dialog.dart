import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidmona/Utilities/images.dart';

class GetPictureDialog extends StatelessWidget {

  final Function() onCamera;
  final Function() onGallery;

  const GetPictureDialog({required this.onCamera,required this.onGallery});

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: (){
                onCamera();
                //pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppSvg.getPath("camera"),height: 40,),
                  const Text("Camera")
                ],
              ),
            ),
            InkWell(
              onTap: (){
                onGallery();
                //pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppSvg.getPath("gallery"),height: 40,),
                  const Text("Gallery")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
