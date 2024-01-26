class KYCDataRetrieve {
  String? email;
  String? kycApplicationId;
  String? kycApplicationStatus;
  var kycApplicationCurrentStatus;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  Nationality? nationality;
  PhysicalAddress? physicalAddress;

  KYCDataRetrieve(
      {
        this.email,
        this.kycApplicationId,
        this.kycApplicationStatus,
        this.kycApplicationCurrentStatus,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dateOfBirth,
        this.nationality,
        this.physicalAddress
      });

  KYCDataRetrieve.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    kycApplicationId = json['kyc_application_id'];
    kycApplicationStatus = json['kyc_application_status'];
    kycApplicationCurrentStatus = json['kyc_application_current_status'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    nationality = json['nationality'] != null
        ? new Nationality.fromJson(json['nationality'])
        : null;
    physicalAddress = json['physical_address'] != null
        ? new PhysicalAddress.fromJson(json['physical_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['kyc_application_id'] = this.kycApplicationId;
    data['kyc_application_status'] = this.kycApplicationStatus;
    data['kyc_application_current_status'] = this.kycApplicationCurrentStatus;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['date_of_birth'] = this.dateOfBirth;
    if (this.nationality != null) {
      data['nationality'] = this.nationality!.toJson();
    }
    if (this.physicalAddress != null) {
      data['physical_address'] = this.physicalAddress!.toJson();
    }
    return data;
  }
}

class Nationality {
  String? name;
  int? id;
  String? code;
  String? countryCodeAlpha2;
  String? countryCodeAlpha3;
  Null? logo;

  Nationality(
      {this.name,
        this.id,
        this.code,
        this.countryCodeAlpha2,
        this.countryCodeAlpha3,
        this.logo});

  Nationality.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    code = json['code'];
    countryCodeAlpha2 = json['country_code_alpha2'];
    countryCodeAlpha3 = json['country_code_alpha3'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['code'] = this.code;
    data['country_code_alpha2'] = this.countryCodeAlpha2;
    data['country_code_alpha3'] = this.countryCodeAlpha3;
    data['logo'] = this.logo;
    return data;
  }
}

class PhysicalAddress {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? province;
  String? postalcode;

  PhysicalAddress(
      {
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.province,
        this.postalcode
      });

  PhysicalAddress.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    city = json['city'];
    province = json['province'];
    postalcode = json['postalcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postalcode'] = this.postalcode;
    return data;
  }
}
