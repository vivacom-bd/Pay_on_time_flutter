class PaymentBank {
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountTitle;
  String? status;
  String? branchName;
  int? id;

  PaymentBank(
      {this.bankName,
        this.bankAccountNumber,
        this.bankAccountTitle,
        this.status,
        this.branchName,
        this.id});

  PaymentBank.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    bankAccountTitle = json['bank_account_title'];
    status = json['status'];
    branchName = json['branch_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_account_number'] = bankAccountNumber;
    data['bank_account_title'] = bankAccountTitle;
    data['status'] = status;
    data['branch_name'] = branchName;
    data['id'] = id;
    return data;
  }
}