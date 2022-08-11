import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidmona/Models/app_settings.dart';
import 'package:hidmona/Repositories/api_response.dart';

class FirebaseRepository{
  //get versionControl
  static Stream<APIResponse<VersionControl>> getVersionControl() {
    DocumentReference balanceRef = FirebaseFirestore.instance.doc("/AppSettings/versionControl");

    return balanceRef.snapshots().map((DocumentSnapshot snapshot){

      if (snapshot.exists) {

        VersionControl versionControl = VersionControl.fromJson(snapshot.data() as Map<String,dynamic>);
        return APIResponse<VersionControl>(data: versionControl);

      }else{
        return APIResponse<VersionControl>(error: true, message: "An Error Occurred");
      }
    }).handleError((Object onError){
      return APIResponse<VersionControl>(error: true, message: "An Error Occurred");
    });

  }
}