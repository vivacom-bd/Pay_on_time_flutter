import 'package:hidmona/Models/server_country.dart';
import 'package:hidmona/Models/server_currency.dart';

class RecipientBank {
  String? bankName;
  String? bankAddress;
  String? status;
  int? id;
  ServerCountry? country;

  RecipientBank(
      {this.bankName, this.bankAddress, this.status, this.id, this.country});

  RecipientBank.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAddress = json['bank_address'];
    status = json['status'];
    id = json['id'];
    country =
    json['country'] != null ? ServerCountry.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_address'] = bankAddress;
    data['status'] = status;
    data['id'] = id;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object bank) => bank is RecipientBank && bank.id == id;

  @override
  int get hashCode => id!;
}


class RecipientBankBranch {
  String? branchName;
  String? branchAddress;
  String? status;
  int? id;
  RecipientBank? bank;

  RecipientBankBranch(
      {this.branchName, this.branchAddress, this.status, this.id, this.bank});

  RecipientBankBranch.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    branchAddress = json['branch_address'];
    status = json['status'];
    id = json['id'];
    bank = json['bank'] != null ? RecipientBank.fromJson(json['bank']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_name'] = branchName;
    data['branch_address'] = branchAddress;
    data['status'] = status;
    data['id'] = id;
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object branch) => branch is RecipientBankBranch && branch.id == id;

  @override
  int get hashCode => id!;
}