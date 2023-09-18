class UserSignupRequest {
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  String? username;
  String? countryId;
  String? fullName;
  String? firstName;
  String? middleName;
  String? lastName;
  int? cityId;
  bool? isCitizen;
  int? citizenCountryId;
  String? dateOfBirth;
  String? streetAddress;
  int? postalCode;

  UserSignupRequest(
      {this.email,
        this.phone,
        this.password,
        this.confirmPassword,
        this.username,
        this.countryId,
        this.fullName,
        this.firstName,
        this.middleName,
        this.lastName,
        this.cityId,
        this.isCitizen,
        this.citizenCountryId,
        this.dateOfBirth,
        this.streetAddress,
        this.postalCode});

  UserSignupRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['password_confirmation'];
    username = json['username'];
    //countryId = json['country_id'];
    countryId = json['country_code'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    cityId = json['city_id'];
    isCitizen = json['is_citizen'];
    citizenCountryId = json['citizen_country_id'];
    dateOfBirth = json['date_of_birth'];
    streetAddress = json['street_address'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['password_confirmation'] = confirmPassword;
    data['username'] = username;
    //data['country_id'] = countryId;
    data['country_code'] = countryId;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['city_id'] = cityId;
    data['is_citizen'] = isCitizen;
    data['citizen_country_id'] = citizenCountryId;
    data['date_of_birth'] = dateOfBirth;
    data['street_address'] = streetAddress;
    data['postal_code'] = postalCode;
    return data;
  }
}