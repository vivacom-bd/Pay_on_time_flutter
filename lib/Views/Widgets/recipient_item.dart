import 'package:flutter/material.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Utilities/colors.dart';

class RecipientItem extends StatefulWidget {
  const RecipientItem({
    Key? key,
    required this.recipient,
    this.onRefresh,
  }) : super(key: key);

  final Recipient recipient;
  final Function()? onRefresh;

  @override
  State<RecipientItem> createState() => _RecipientItemState();
}

class _RecipientItemState extends State<RecipientItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("#${widget.recipient.id}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                Row(
                  children: [
                    InkWell(
                      onTap: ()async{
                        // await Navigator.of(context).pushNamed(EditRecipientScreen.routeName,arguments: widget.myRecipient);
                        // widget.onRefresh();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColor.defaultColor.withOpacity(.15),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Icon(Icons.edit,color: AppColor.defaultColor,size: 17,),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        // DefaultDialogs().showDialog(
                        //     title: "Delete Beneficiary",
                        //     text: "Do you want to delete ${widget.recipient.fullName}?",
                        //     onCancel: (){
                        //       Navigator.pop(context);
                        //     },
                        //     onSubmitText: "Yes",
                        //     onSubmit: () async{
                        //       Navigator.pop(context);
                        //       Utility.showLoadingDialog();
                        //
                        //       APIResponse apiResponse = await CommonServices.deleteRecipient(widget.myRecipient.recipientId);
                        //
                        //       if(apiResponse.data != null && apiResponse.data){
                        //         showInSnackBar(context, apiResponse.errorMessage??"Recipient Deleted", null);
                        //         widget.onRefresh();
                        //       }else{
                        //         showInSnackBar(context, apiResponse.errorMessage??"Error Occurred", null);
                        //       }
                        //
                        //       Navigator.pop(context);
                        //
                        //     }
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColor.defaultColor.withOpacity(.15),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Icon(Icons.delete,color: AppColor.defaultColor,size: 17,),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 7,),
            Row(
              children: [
                const Icon(Icons.person,size: 20,),
                const SizedBox(width: 5,),
                Text("${widget.recipient.fullName}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 7,),
            Row(
              children: [
                const Icon(Icons.phone,size: 20,),
                const SizedBox(width: 5,),
                Text("${widget.recipient.phone}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.email,size: 20,),
                const SizedBox(width: 5,),
                Text("${widget.recipient.email}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("City: ${widget.recipient.city!.name}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                Text("${widget.recipient.country!.name}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}