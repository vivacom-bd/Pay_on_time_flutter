class GetPersonalAccount {
  bool? success;
  int? total;
  List<Data>? data;

  GetPersonalAccount({this.success, this.total, this.data});

  GetPersonalAccount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? familyName;
  String? givenName;
  String? nationality;
  String? dateofBirth;
  String? email;
  String? phoneNumber;
  BankAccountDetails? bankAccountDetails;

  Data(
      {this.id,
        this.familyName,
        this.givenName,
        this.nationality,
        this.dateofBirth,
        this.email,
        this.phoneNumber,
        this.bankAccountDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyName = json['familyName'];
    givenName = json['givenName'];
    nationality = json['nationality'];
    dateofBirth = json['dateofBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    bankAccountDetails = json['bank_account_details'] != null
        ? new BankAccountDetails.fromJson(json['bank_account_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyName'] = this.familyName;
    data['givenName'] = this.givenName;
    data['nationality'] = this.nationality;
    data['dateofBirth'] = this.dateofBirth;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    if (this.bankAccountDetails != null) {
      data['bank_account_details'] = this.bankAccountDetails!.toJson();
    }
    return data;
  }
}

class BankAccountDetails {
  String? iban;
  String? swiftBic;
  String? bankIdentifier;
  String? bankCountry;
  String? branchIdentifier;
  String? currency;

  BankAccountDetails(
      {this.iban,
        this.swiftBic,
        this.bankIdentifier,
        this.bankCountry,
        this.branchIdentifier,
        this.currency});

  BankAccountDetails.fromJson(Map<String, dynamic> json) {
    iban = json['iban'];
    swiftBic = json['swift_bic'];
    bankIdentifier = json['bank_identifier'];
    bankCountry = json['bank_country'];
    branchIdentifier = json['branch_identifier'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iban'] = this.iban;
    data['swift_bic'] = this.swiftBic;
    data['bank_identifier'] = this.bankIdentifier;
    data['bank_country'] = this.bankCountry;
    data['branch_identifier'] = this.branchIdentifier;
    data['currency'] = this.currency;
    return data;
  }
}
