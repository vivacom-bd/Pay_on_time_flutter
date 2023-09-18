class UserProfile {
  int? id;
  int? status;
  String? name;
  String? phone;
  String? email;
  String? streetAddress;
  String? postalCode;
  int? countryId;
  int? cityId;
  Null? organizationId;
  int? isBeneficiary;
  String? referenceNo;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? createdByUserId;
  String? firstName;
  String? middleName;
  String? lastName;
  Null? emailVerifiedAt;
  Null? dateOfBirth;
  Null? profilePicture;
  Null? otp;
  Null? otpCreatedAt;
  UserCountry? country;
  UserCity? city;

  UserProfile(
      {this.id,
        this.status,
        this.name,
        this.phone,
        this.email,
        this.streetAddress,
        this.postalCode,
        this.countryId,
        this.cityId,
        this.organizationId,
        this.isBeneficiary,
        this.referenceNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.createdByUserId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.emailVerifiedAt,
        this.dateOfBirth,
        this.profilePicture,
        this.otp,
        this.otpCreatedAt,
        this.country,
        this.city});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    streetAddress = json['street_address'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    organizationId = json['organization_id'];
    isBeneficiary = json['is_beneficiary'];
    referenceNo = json['reference_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdByUserId = json['created_by_user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailVerifiedAt = json['email_verified_at'];
    dateOfBirth = json['date_of_birth'];
    profilePicture = json['profile_picture'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    country = json['country'] != null ? new UserCountry.fromJson(json['country']) : null;
    city = json['city'] != null ? new UserCity.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['street_address'] = this.streetAddress;
    data['postal_code'] = this.postalCode;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['organization_id'] = this.organizationId;
    data['is_beneficiary'] = this.isBeneficiary;
    data['reference_no'] = this.referenceNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_by_user_id'] = this.createdByUserId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['date_of_birth'] = this.dateOfBirth;
    data['profile_picture'] = this.profilePicture;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class UserCountry {
  int? id;
  String? name;
  String? isoCodeAlpha3;
  String? isoCodeAlpha2;

  UserCountry({this.id, this.name, this.isoCodeAlpha3, this.isoCodeAlpha2});

  UserCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCodeAlpha3 = json['iso_code_alpha_3'];
    isoCodeAlpha2 = json['iso_code_alpha_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso_code_alpha_3'] = this.isoCodeAlpha3;
    data['iso_code_alpha_2'] = this.isoCodeAlpha2;
    return data;
  }
}

class UserCity {
  int? id;
  String? name;
  int? countryId;

  UserCity({this.id, this.name, this.countryId});

  UserCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}




// import 'package:hidmona/Models/city.dart';
// import 'package:hidmona/Models/server_country.dart';
//
// class UserProfile {
//   String? username;
//   String? phone;
//   String? fullName;
//   String? email;
//   String? version;
//   int? id;
//   int? cityId;
//   // List<Null>? groups;
//   ServerCountry? country;
//   City? city;
//
//   UserProfile(
//       {this.username,
//         this.phone,
//         this.fullName,
//         this.email,
//         this.version,
//         this.id,
//         this.cityId,
//         // this.groups,
//         this.country,
//         this.city});
//
//   UserProfile.fromJson(Map<String, dynamic> json) {
//     username = json['username'];
//     phone = json['phone'];
//     fullName = json['full_name'];
//     email = json['email'];
//     version = json['version'];
//     id = json['id'];
//     cityId = json['city_id'];
//     // if (json['groups'] != null) {
//     //   groups = <Null>[];
//     //   json['groups'].forEach((v) {
//     //     groups!.add(new Null.fromJson(v));
//     //   });
//     // }
//     country =
//     json['country'] != null ? ServerCountry.fromJson(json['country']) : null;
//     city = json['city'] != null ? City.fromJson(json['city']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['username'] = username;
//     data['phone'] = phone;
//     data['full_name'] = fullName;
//     data['email'] = email;
//     data['version'] = version;
//     data['id'] = id;
//     data['city_id'] = cityId;
//     // if (this.groups != null) {
//     //   data['groups'] = this.groups!.map((v) => v.toJson()).toList();
//     // }
//     if (country != null) {
//       data['country'] = country!.toJson();
//     }
//     if (city != null) {
//       data['city'] = city!.toJson();
//     }
//     return data;
//   }
// }