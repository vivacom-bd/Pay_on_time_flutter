
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/server_country.dart';


//Recipient
// class Recipient {
//   int? id;
//   int? customerId;
//   int? recipientId;
//   Null? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   Recipients? recipient;
//
//   Recipient(
//       {this.id,
//         this.customerId,
//         this.recipientId,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.recipient});
//
//   Recipient.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     customerId = json['customer_id'];
//     recipientId = json['recipient_id'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     recipient = json['recipient'] != null
//         ? new Recipients.fromJson(json['recipient'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['customer_id'] = this.customerId;
//     data['recipient_id'] = this.recipientId;
//     data['deleted_at'] = this.deletedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.recipient != null) {
//       data['recipient'] = this.recipient!.toJson();
//     }
//     return data;
//   }
// }
//
// class Recipients {
//   int? id;
//   int? status;
//   String? name;
//   String? phone;
//   String? email;
//   String? streetAddress;
//   String? postalCode;
//   int? countryId;
//   int? cityId;
//   int? organizationId;
//   int? isBeneficiary;
//   String? referenceNo;
//   String? createdAt;
//   String? updatedAt;
//   Null? deletedAt;
//   Null? createdByUserId;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   Null? emailVerifiedAt;
//   Null? dateOfBirth;
//   Null? profilePicture;
//   Null? otp;
//   Null? otpCreatedAt;
//
//   Recipients(
//       {this.id,
//         this.status,
//         this.name,
//         this.phone,
//         this.email,
//         this.streetAddress,
//         this.postalCode,
//         this.countryId,
//         this.cityId,
//         this.organizationId,
//         this.isBeneficiary,
//         this.referenceNo,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.createdByUserId,
//         this.firstName,
//         this.middleName,
//         this.lastName,
//         this.emailVerifiedAt,
//         this.dateOfBirth,
//         this.profilePicture,
//         this.otp,
//         this.otpCreatedAt});
//
//   Recipients.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     status = json['status'];
//     name = json['name'];
//     phone = json['phone'];
//     email = json['email'];
//     streetAddress = json['street_address'];
//     postalCode = json['postal_code'];
//     countryId = json['country_id'];
//     cityId = json['city_id'];
//     organizationId = json['organization_id'];
//     isBeneficiary = json['is_beneficiary'];
//     referenceNo = json['reference_no'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     createdByUserId = json['created_by_user_id'];
//     firstName = json['first_name'];
//     middleName = json['middle_name'];
//     lastName = json['last_name'];
//     emailVerifiedAt = json['email_verified_at'];
//     dateOfBirth = json['date_of_birth'];
//     profilePicture = json['profile_picture'];
//     otp = json['otp'];
//     otpCreatedAt = json['otp_created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['status'] = this.status;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['street_address'] = this.streetAddress;
//     data['postal_code'] = this.postalCode;
//     data['country_id'] = this.countryId;
//     data['city_id'] = this.cityId;
//     data['organization_id'] = this.organizationId;
//     data['is_beneficiary'] = this.isBeneficiary;
//     data['reference_no'] = this.referenceNo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     data['created_by_user_id'] = this.createdByUserId;
//     data['first_name'] = this.firstName;
//     data['middle_name'] = this.middleName;
//     data['last_name'] = this.lastName;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['profile_picture'] = this.profilePicture;
//     data['otp'] = this.otp;
//     data['otp_created_at'] = this.otpCreatedAt;
//     return data;
//   }
// }


//RecipientRequestBody


class Recipient {
  int? id;
  int? userId;
  String? email;
  String? fullName;
  String? phone;
  int? countryId;
  String? streetAddress;
  String? postalCode;
  String? dateOfBirth;
  int? cityId;
  int? citizenCountryId;
  bool? isCitizen;
  String? recipientCode;
  String? status;
  ServerCountry? country;
  City? city;
  ServerCountry? citizenCountry;
  AppUser? user;

  Recipient(
      {this.email,
        this.fullName,
        this.phone,
        this.countryId,
        this.streetAddress,
        this.postalCode,
        this.dateOfBirth,
        this.cityId,
        this.citizenCountryId,
        this.isCitizen,
        this.recipientCode,
        this.id,
        this.userId,
        this.status,
        this.country,
        this.city,
        this.citizenCountry,
        this.user});

  Recipient.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    countryId = json['country_id'];
    streetAddress = json['street_address'];
    postalCode = json['postal_code'];
    dateOfBirth = json['date_of_birth'];
    cityId = json['city_id'];
    citizenCountryId = json['citizen_country_id'];
    isCitizen = json['is_citizen'];
    recipientCode = json['recipient_code'];
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    country = json['country'] != null ? ServerCountry.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    citizenCountry = json['citizen_country'] != null ? ServerCountry.fromJson(json['citizen_country']) : null;
    user = json['user'] != null ? AppUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['country_id'] = countryId;
    data['street_address'] = streetAddress;
    data['postal_code'] = postalCode;
    data['date_of_birth'] = dateOfBirth;
    data['city_id'] = cityId;
    data['citizen_country_id'] = citizenCountryId;
    data['is_citizen'] = isCitizen;
    data['recipient_code'] = recipientCode;
    data['id'] = id;
    data['user_id'] = userId;
    data['status'] = status;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (citizenCountry != null) {
      data['citizen_country'] = citizenCountry!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }


  @override
  bool operator ==(Object other) => other is Recipient && other.id == id;

  @override
  int get hashCode => id!;
}


class RecipientRequestBody {
  String? email;
  String? fullName;
  String? lastName;
  String? firstName;
  String? middleName;
  String? phone;
  int? countryId;
  String? streetAddress;
  int? postalCode;
  String? dateOfBirth;
  int? cityId;
  int? citizenCountryId;
  bool? isCitizen;
  // int? status;

  RecipientRequestBody(
      {this.email,
        this.fullName,
        this.firstName,
        this.lastName,
        this.middleName,
        this.phone,
        this.countryId,
        this.streetAddress,
        this.postalCode,
        this.dateOfBirth,
        this.cityId,
        this.citizenCountryId,
        this.isCitizen});

  RecipientRequestBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
    countryId = json['country_id'];
    streetAddress = json['street_address'];
    postalCode = json['postal_code'];
    dateOfBirth = json['date_of_birth'];
    cityId = json['city_id'];
    citizenCountryId = json['citizen_country_id'];
    isCitizen = json['is_citizen'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['email'] = email;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['phone'] = phone;
    data['country_id'] = countryId;
    data['street_address'] = streetAddress;
    //data['postal_code'] = postalCode;
    //data['date_of_birth'] = dateOfBirth;
    data['city_id'] = cityId;
    //data['citizen_country_id'] = citizenCountryId;
    //data['is_citizen'] = isCitizen;
    //data['status'] = status;
    return data;
  }
}