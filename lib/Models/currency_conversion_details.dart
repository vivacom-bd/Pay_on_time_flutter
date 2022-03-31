class CurrencyConversionDetails {
  double? ourRate;
  double? amountToSend;
  String? sendingCurrency;
  double? fees;
  double? amountToPay;
  double? amountToReceive;
  String? receivingCurrency;
  double? totalPayment;

  CurrencyConversionDetails(
      {this.ourRate,
        this.amountToSend,
        this.sendingCurrency,
        this.fees,
        this.amountToPay,
        this.amountToReceive,
        this.receivingCurrency,
        this.totalPayment});

  CurrencyConversionDetails.fromJson(Map<String, dynamic> json) {
    ourRate = json['our_rate'];
    amountToSend = json['amount_to_send'];
    sendingCurrency = json['sending_currency'];
    fees = json['fees'];
    amountToPay = json['amount_to_pay'];
    amountToReceive = json['amount_to_receive'];
    receivingCurrency = json['receiving_currency'];
    totalPayment = json['total_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['our_rate'] = this.ourRate;
    data['amount_to_send'] = this.amountToSend;
    data['sending_currency'] = this.sendingCurrency;
    data['fees'] = this.fees;
    data['amount_to_pay'] = this.amountToPay;
    data['amount_to_receive'] = this.amountToReceive;
    data['receiving_currency'] = this.receivingCurrency;
    data['total_payment'] = this.totalPayment;
    return data;
  }
}