import 'package:hidmona/Models/server_country.dart';

class CountryWiseBank {
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountTitle;
  int? status;
  String? branchName;
  int? id;
  ServerCountry? country;

  CountryWiseBank(
      {this.bankName,
        this.bankAccountNumber,
        this.bankAccountTitle,
        this.status,
        this.branchName,
        this.id,
        this.country});

  CountryWiseBank.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    bankAccountTitle = json['bank_account_title'];
    status = json['status'];
    branchName = json['branch_name'];
    id = json['id'];
    country =
    json['country'] != null ? ServerCountry.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_account_number'] = bankAccountNumber;
    data['bank_account_title'] = bankAccountTitle;
    data['status'] = status;
    data['branch_name'] = branchName;
    data['id'] = id;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}
