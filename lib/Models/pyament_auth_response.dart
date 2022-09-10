class PaymentAuthResponse {
  String? jwtToken;
  int? baseamount;
  String? transactionNumber;
  String? currencyiso3a;

  PaymentAuthResponse(
      {this.jwtToken,
        this.baseamount,
        this.transactionNumber,
        this.currencyiso3a});

  PaymentAuthResponse.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwt_token'];
    baseamount = json['baseamount'];
    transactionNumber = json['transaction_number'];
    currencyiso3a = json['currencyiso3a'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt_token'] = this.jwtToken;
    data['baseamount'] = this.baseamount;
    data['transaction_number'] = this.transactionNumber;
    data['currencyiso3a'] = this.currencyiso3a;
    return data;
  }
}