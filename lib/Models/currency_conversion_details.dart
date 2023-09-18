class CurrencyConversionDetails {
  String? message;
  Data? data;

  CurrencyConversionDetails({this.message, this.data});

  CurrencyConversionDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  double? ourRate;
  double? amountToSend;
  String? sendingCurrency;
  String? sendingCurrencyCode;
  double? fees;
  double? amountToPay;
  double? amountToReceive;
  String? receivingCurrency;
  String? receivingCurrencyCode;
  double? totalPayment;
  double? payoutAmountInUsd;
  double? totalAmountInUsd;
  double? receivingAmountInUsd;
  double? ourFees;

  Data(
      {this.ourRate,
        this.amountToSend,
        this.sendingCurrency,
        this.sendingCurrencyCode,
        this.fees,
        this.amountToPay,
        this.amountToReceive,
        this.receivingCurrency,
        this.receivingCurrencyCode,
        this.totalPayment,
        this.payoutAmountInUsd,
        this.totalAmountInUsd,
        this.receivingAmountInUsd,
        this.ourFees});

  Data.fromJson(Map<String, dynamic> json) {
    ourRate = json['our_rate'].toDouble();
    amountToSend = json['amount_to_send'].toDouble();
    sendingCurrency = json['sending_currency'];
    sendingCurrencyCode = json['sending_currency_code'];
    fees = json['fees'].toDouble();
    amountToPay = json['amount_to_pay'].toDouble();
    amountToReceive = json['amount_to_receive'].toDouble();
    receivingCurrency = json['receiving_currency'];
    receivingCurrencyCode = json['receiving_currency_code'];
    totalPayment = json['total_payment'].toDouble();
    payoutAmountInUsd = json['payout_amount_in_usd'].toDouble();
    totalAmountInUsd = json['total_amount_in_usd'].toDouble();
    receivingAmountInUsd = json['receiving_amount_in_usd'].toDouble();
    ourFees = json['our_fees'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['our_rate'] = this.ourRate;
    data['amount_to_send'] = this.amountToSend;
    data['sending_currency'] = this.sendingCurrency;
    data['sending_currency_code'] = this.sendingCurrencyCode;
    data['fees'] = this.fees;
    data['amount_to_pay'] = this.amountToPay;
    data['amount_to_receive'] = this.amountToReceive;
    data['receiving_currency'] = this.receivingCurrency;
    data['receiving_currency_code'] = this.receivingCurrencyCode;
    data['total_payment'] = this.totalPayment;
    data['payout_amount_in_usd'] = this.payoutAmountInUsd;
    data['total_amount_in_usd'] = this.totalAmountInUsd;
    data['receiving_amount_in_usd'] = this.receivingAmountInUsd;
    data['our_fees'] = this.ourFees;
    return data;
  }
}



// class CurrencyConversionDetails {
//   int? ourRate;
//   double? amountToSend;
//   double? fees;
//   double? amountToPay;
//   double? amountToReceive;
//   double? totalPayment;
//   double? payoutAmountInUsd;
//   double? totalAmountInUsd;
//   double? receivingAmountInUsd;
//   double? ourFees;
//   String? source;
//   String? sendingCurrency;
//   String? receivingCurrency;
//
//   CurrencyConversionDetails(
//       {this.ourRate,
//         this.amountToSend,
//         this.sendingCurrency,
//         this.fees,
//         this.amountToPay,
//         this.amountToReceive,
//         this.receivingCurrency,
//         this.totalPayment,
//         this.payoutAmountInUsd,
//         this.totalAmountInUsd,
//         this.receivingAmountInUsd,
//         this.ourFees,
//         this.source});
//
//   CurrencyConversionDetails.fromJson(Map<String, dynamic> json) {
//     //int tempOurRate = json['our_rate'];
//     ourRate = json['our_rate'];
//     amountToSend = json['amount_to_send'];
//     sendingCurrency = json['sending_currency'];
//     fees = json['fees'];
//     amountToPay = json['amount_to_pay'];
//     amountToReceive = json['amount_to_receive'];
//     receivingCurrency = json['receiving_currency'];
//     totalPayment = json['total_payment'];
//     payoutAmountInUsd = json['payout_amount_in_usd'];
//     totalAmountInUsd = json['total_amount_in_usd'];
//     receivingAmountInUsd = json['receiving_amount_in_usd'];
//     ourFees = json['our_fees'];
//     source = json['source'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['our_rate'] = this.ourRate;
//     data['amount_to_send'] = this.amountToSend;
//     data['sending_currency'] = this.sendingCurrency;
//     data['fees'] = this.fees;
//     data['amount_to_pay'] = this.amountToPay;
//     data['amount_to_receive'] = this.amountToReceive;
//     data['receiving_currency'] = this.receivingCurrency;
//     data['total_payment'] = this.totalPayment;
//     data['payout_amount_in_usd'] = this.payoutAmountInUsd;
//     data['total_amount_in_usd'] = this.totalAmountInUsd;
//     data['receiving_amount_in_usd'] = this.receivingAmountInUsd;
//     data['our_fees'] = this.ourFees;
//     data['source'] = this.source;
//     return data;
//   }
// }
