import 'package:hidmona/Models/agent.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/payment_bank.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Models/sending_purpose.dart';
import 'package:hidmona/Models/server_country.dart';


//Transaction
class Transaction {
  String? bankName;
  String? bankAccountNo;
  String? bankAccountTitle;
  String? bankSwiftCode;
  String? bankAddress;
  String? branchName;
  String? payoutCurrency;
  String? receivingCurrency;
  String? transactionDate;
  String? purpose;
  String? purposeDescription;
  String? settlementCurrency;
  String? remarks;
  int? id;
  Recipient? recipient;
  String? transactionNumber;
  String? paymentStatus;
  String? transactionStatus;
  String? paymentReceiveStatus;
  Recipient? sender;
  Agent? agent;
  int? payoutAmount;
  int? totalAmount;
  int? receivingAmount;
  ModeOfPayment? paymentReceiveMode;
  ModeOfPayment? paymentDeliveryMode;
  int? totalCommission;
  ServerCountry? senderCountry;
  City? recipientCity;
  ServerCountry? recipientCountry;
  String? status;
  Recipient? customer;
  PaymentBank? paymentBank;
  SendingPurpose? sendingPurpose;
  Recipient? agentCustomer;
  City? senderCity;

  Transaction(
      {this.bankName,
        this.bankAccountNo,
        this.bankAccountTitle,
        this.bankSwiftCode,
        this.bankAddress,
        this.branchName,
        this.payoutCurrency,
        this.receivingCurrency,
        this.transactionDate,
        this.purpose,
        this.purposeDescription,
        this.settlementCurrency,
        this.remarks,
        this.id,
        this.recipient,
        this.transactionNumber,
        this.paymentStatus,
        this.transactionStatus,
        this.paymentReceiveStatus,
        this.sender,
        this.agent,
        this.payoutAmount,
        this.totalAmount,
        this.receivingAmount,
        this.paymentReceiveMode,
        this.paymentDeliveryMode,
        this.totalCommission,
        this.senderCountry,
        this.recipientCity,
        this.recipientCountry,
        this.status,
        this.customer,
        this.paymentBank,
        this.sendingPurpose,
        this.agentCustomer,
        this.senderCity});

  Transaction.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccountNo = json['bank_account_no'];
    bankAccountTitle = json['bank_account_title'];
    bankSwiftCode = json['bank_swift_code'];
    bankAddress = json['bank_address'];
    branchName = json['branch_name'];
    payoutCurrency = json['payout_currency'];
    receivingCurrency = json['receiving_currency'];
    transactionDate = json['transaction_date'];
    purpose = json['purpose'];
    purposeDescription = json['purpose_description'];
    settlementCurrency = json['settlement_currency'];
    remarks = json['remarks'];
    id = json['id'];
    recipient = json['recipient'] != null
        ? Recipient.fromJson(json['recipient'])
        : null;
    transactionNumber = json['transaction_number'];
    paymentStatus = json['payment_status'];
    transactionStatus = json['transaction_status'];
    paymentReceiveStatus = json['payment_receive_status'];
    sender =
    json['sender'] != null ? Recipient.fromJson(json['sender']) : null;
    agent =
    json['agent'] != null ? Agent.fromJson(json['agent']) : null;
    payoutAmount = json['payout_amount'];
    totalAmount = json['total_amount'];
    receivingAmount = json['receiving_amount'];
    paymentReceiveMode = json['payment_receive_mode'] != null
        ? ModeOfPayment.fromJson(json['payment_receive_mode'])
        : null;
    paymentDeliveryMode = json['payment_delivery_mode'] != null
        ? ModeOfPayment.fromJson(json['payment_delivery_mode'])
        : null;
    totalCommission = json['total_commission'];
    senderCountry = json['sender_country'] != null
        ? ServerCountry.fromJson(json['sender_country'])
        : null;
    recipientCity = json['recipient_city'] != null
        ? City.fromJson(json['recipient_city'])
        : null;
    recipientCountry = json['recipient_country'] != null
        ? ServerCountry.fromJson(json['recipient_country'])
        : null;
    status = json['status'];
    customer = json['customer'] != null
        ? Recipient.fromJson(json['customer'])
        : null;
    paymentBank = json['payment_bank'] != null
        ? PaymentBank.fromJson(json['payment_bank'])
        : null;
    sendingPurpose = json['sending_purpose'] != null
        ? SendingPurpose.fromJson(json['sending_purpose'])
        : null;
    agentCustomer = json['agent_customer'] != null
        ? Recipient.fromJson(json['agent_customer'])
        : null;
    senderCity = json['sender_city'] != null
        ? City.fromJson(json['sender_city'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_account_no'] = bankAccountNo;
    data['bank_account_title'] = bankAccountTitle;
    data['bank_swift_code'] = bankSwiftCode;
    data['bank_address'] = bankAddress;
    data['branch_name'] = branchName;
    data['payout_currency'] = payoutCurrency;
    data['receiving_currency'] = receivingCurrency;
    data['transaction_date'] = transactionDate;
    data['purpose'] = purpose;
    data['purpose_description'] = purposeDescription;
    data['settlement_currency'] = settlementCurrency;
    data['remarks'] = remarks;
    data['id'] = id;
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    data['transaction_number'] = transactionNumber;
    data['payment_status'] = paymentStatus;
    data['transaction_status'] = transactionStatus;
    data['payment_receive_status'] = paymentReceiveStatus;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (agent != null) {
      data['agent'] = agent!.toJson();
    }
    data['payout_amount'] = payoutAmount;
    data['total_amount'] = totalAmount;
    data['receiving_amount'] = receivingAmount;
    if (paymentReceiveMode != null) {
      data['payment_receive_mode'] = paymentReceiveMode!.toJson();
    }
    if (paymentDeliveryMode != null) {
      data['payment_delivery_mode'] = paymentDeliveryMode!.toJson();
    }
    data['total_commission'] = totalCommission;
    if (senderCountry != null) {
      data['sender_country'] = senderCountry!.toJson();
    }
    if (recipientCity != null) {
      data['recipient_city'] = recipientCity!.toJson();
    }
    if (recipientCountry != null) {
      data['recipient_country'] = recipientCountry!.toJson();
    }
    data['status'] = status;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (paymentBank != null) {
      data['payment_bank'] = paymentBank!.toJson();
    }
    if (sendingPurpose != null) {
      data['sending_purpose'] = sendingPurpose!.toJson();
    }
    if (agentCustomer != null) {
      data['agent_customer'] = agentCustomer!.toJson();
    }
    if (senderCity != null) {
      data['sender_city'] = senderCity!.toJson();
    }
    return data;
  }
}






//TransactionRequestBody
class TransactionRequestBody {
  String? bankName;
  String? bankAccountNo;
  String? bankAccountTitle;
  String? bankSwiftCode;
  String? bankAddress;
  String? branchName;
  String? payoutCurrency;
  String? receivingCurrency;
  String? transactionDate;
  String? purpose;
  String? purposeDescription;
  String? settlementCurrency;
  String? remarks;
  int? paymentReceiveModeId;
  int? paymentDeliveryModeId;
  int? recipientId;
  int? senderCountryId;
  int? recipientCityId;
  int? recipientCountryId;
  int? sendingPurposeId;
  int? agentCustomerId;
  int? senderCityId;
  int? paymentBankId;
  int? amount;

  TransactionRequestBody(
      {this.bankName,
        this.bankAccountNo,
        this.bankAccountTitle,
        this.bankSwiftCode,
        this.bankAddress,
        this.branchName,
        this.payoutCurrency,
        this.receivingCurrency,
        this.transactionDate,
        this.purpose,
        this.purposeDescription,
        this.settlementCurrency,
        this.remarks,
        this.paymentReceiveModeId,
        this.paymentDeliveryModeId,
        this.recipientId,
        this.senderCountryId,
        this.recipientCityId,
        this.recipientCountryId,
        this.sendingPurposeId,
        this.agentCustomerId,
        this.senderCityId,
        this.paymentBankId,
        this.amount});

  TransactionRequestBody.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccountNo = json['bank_account_no'];
    bankAccountTitle = json['bank_account_title'];
    bankSwiftCode = json['bank_swift_code'];
    bankAddress = json['bank_address'];
    branchName = json['branch_name'];
    payoutCurrency = json['payout_currency'];
    receivingCurrency = json['receiving_currency'];
    transactionDate = json['transaction_date'];
    purpose = json['purpose'];
    purposeDescription = json['purpose_description'];
    settlementCurrency = json['settlement_currency'];
    remarks = json['remarks'];
    paymentReceiveModeId = json['payment_receive_mode_id'];
    paymentDeliveryModeId = json['payment_delivery_mode_id'];
    recipientId = json['recipient_id'];
    senderCountryId = json['sender_country_id'];
    recipientCityId = json['recipient_city_id'];
    recipientCountryId = json['recipient_country_id'];
    sendingPurposeId = json['sending_purpose_id'];
    agentCustomerId = json['agent_customer_id'];
    senderCityId = json['sender_city_id'];
    paymentBankId = json['payment_bank_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_account_no'] = bankAccountNo;
    data['bank_account_title'] = bankAccountTitle;
    data['bank_swift_code'] = bankSwiftCode;
    data['bank_address'] = bankAddress;
    data['branch_name'] = branchName;
    data['payout_currency'] = payoutCurrency;
    data['receiving_currency'] = receivingCurrency;
    data['transaction_date'] = transactionDate;
    data['purpose'] = purpose;
    data['purpose_description'] = purposeDescription;
    data['settlement_currency'] = settlementCurrency;
    data['remarks'] = remarks;
    data['payment_receive_mode_id'] = paymentReceiveModeId;
    data['payment_delivery_mode_id'] = paymentDeliveryModeId;
    data['recipient_id'] = recipientId;
    data['sender_country_id'] = senderCountryId;
    data['recipient_city_id'] = recipientCityId;
    data['recipient_country_id'] = recipientCountryId;
    data['sending_purpose_id'] = sendingPurposeId;
    data['agent_customer_id'] = agentCustomerId;
    data['sender_city_id'] = senderCityId;
    data['payment_bank_id'] = paymentBankId;
    data['amount'] = amount;
    return data;
  }
}