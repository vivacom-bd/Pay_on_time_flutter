
import 'package:hidmona/Models/app_user.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/server_country.dart';


//Recipient
class Recipient {
  int? id;
  int? userId;
  String? email;
  String? fullName;
  String? phone;
  int? countryId;
  String? streetAddress;
  int? postalCode;
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
    country =
    json['country'] != null ? ServerCountry.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    citizenCountry = json['citizen_country'] != null
        ? ServerCountry.fromJson(json['citizen_country'])
        : null;
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


//RecipientRequestBody
class RecipientRequestBody {
  String? email;
  String? fullName;
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
    // data['status'] = status;
    return data;
  }
}