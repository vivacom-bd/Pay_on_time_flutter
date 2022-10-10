class PaymentAuthResponse {
  String? jwtToken;
  double? baseamount;
  String? transactionNumber;
  String? currencyiso3a;

  PaymentAuthResponse(
      {this.jwtToken,
        this.baseamount,
        this.transactionNumber,
        this.currencyiso3a});

  PaymentAuthResponse.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwt_token'];
    baseamount = json['baseamount']==null? 0 : json['baseamount']*1.0;
    transactionNumber = json['transaction_number'];
    currencyiso3a = json['currencyiso3a'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jwt_token'] = jwtToken;
    data['baseamount'] = baseamount;
    data['transaction_number'] = transactionNumber;
    data['currencyiso3a'] = currencyiso3a;
    return data;
  }
}