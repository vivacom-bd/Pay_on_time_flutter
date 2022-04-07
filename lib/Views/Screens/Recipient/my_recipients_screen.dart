import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Repositories/api_response.dart';
import 'package:hidmona/Repositories/recipient_repository.dart';
import 'package:hidmona/Utilities/colors.dart';
import 'package:hidmona/Views/Screens/Recipient/create_recepient_screen.dart';
import 'package:hidmona/Views/Widgets/recipient_item.dart';

class MyRecipientScreen extends StatefulWidget {

  static const String routeName = "MyRecipientScreen";

  const MyRecipientScreen({Key? key}) : super(key: key);

  @override
  _MyRecipientScreenState createState() => _MyRecipientScreenState();
}

class _MyRecipientScreenState extends State<MyRecipientScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title:  const Text("My Recipient"),
          actions: [
            InkWell(
              onTap: (){
                Get.to(const CreateRecipientScreen());
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.add,color: Colors.white,),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: RecipientRepository.getRecipients(),
            builder: (context, AsyncSnapshot<APIResponse<List<Recipient>>> snapshot){

              if(snapshot.data!=null){

                APIResponse<List<Recipient>> response = snapshot.data!;

                if(response.data != null){
                  List<Recipient> recipients = response.data!;

                  recipients = recipients.reversed.toList();

                  return CustomRefreshIndicator(
                    onRefresh: () => Future.delayed(const Duration(seconds: 1),(){
                      setState(() {});
                    }),
                    builder: (context,child,controller){
                      return AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, _) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              !controller.isIdle?
                              Positioned(
                                top: 5.0 * controller.value,
                                child: Column(
                                  children: [
                                    SpinKitCircle(
                                      color: AppColor.defaultColor,
                                      size: 25.0,
                                    ),
                                  ],
                                ),
                              ):const SizedBox(),
                              Transform.translate(
                                offset: Offset(0, 40.0 * controller.value),
                                child: child,
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                      itemCount: recipients.length,
                      itemBuilder: (context,index){
                        //return Text(myRecipients[index].firstName);
                        return RecipientItem(recipient:recipients[index], onRefresh: (){
                          setState(() {});
                        },);
                      },
                    ),
                  );

                }else{
                  return Center(child: Text(response.errorMessage??"An Error Occurred"),);
                }

              }

              return Center(child: SpinKitCircle(color: AppColor.defaultColor,));


            },
          ),
        )
    );
  }
}

