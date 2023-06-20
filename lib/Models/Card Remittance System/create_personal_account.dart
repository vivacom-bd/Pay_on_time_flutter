class PersonalAccount {
  bool? success;
  Data? data;

  PersonalAccount({this.success, this.data});

  PersonalAccount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? familyName;
  String? givenName;
  int? nationalityCountryCode;
  String? programmeUid;
  String? dateOfBirth;
  String? emailAddress;
  String? phoneNumber;
  String? status;
  String? uid;
  int? id;

  Data(
      {this.familyName,
        this.givenName,
        this.nationalityCountryCode,
        this.programmeUid,
        this.dateOfBirth,
        this.emailAddress,
        this.phoneNumber,
        this.status,
        this.uid,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    familyName = json['familyName'];
    givenName = json['givenName'];
    nationalityCountryCode = json['nationalityCountryCode'];
    programmeUid = json['programmeUid'];
    dateOfBirth = json['dateOfBirth'];
    emailAddress = json['emailAddress'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    uid = json['uid'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyName'] = this.familyName;
    data['givenName'] = this.givenName;
    data['nationalityCountryCode'] = this.nationalityCountryCode;
    data['programmeUid'] = this.programmeUid;
    data['dateOfBirth'] = this.dateOfBirth;
    data['emailAddress'] = this.emailAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['id'] = this.id;
    return data;
  }
}
