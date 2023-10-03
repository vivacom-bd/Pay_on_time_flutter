import 'package:hidmona/Models/agent.dart';
import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/mode_of_payment.dart';
import 'package:hidmona/Models/payment_bank.dart';
import 'package:hidmona/Models/recipient.dart';
import 'package:hidmona/Models/sending_purpose.dart';
import 'package:hidmona/Models/server_country.dart';


//Transaction
// class Transaction {
//   String? bankName;
//   String? bankAccountNo;
//   String? bankAccountTitle;
//   String? bankSwiftCode;
//   String? bankAddress;
//   String? branchName;
//   String? payoutCurrency;
//   String? receivingCurrency;
//   String? transactionDate;
//   String? purpose;
//   String? purposeDescription;
//   String? settlementCurrency;
//   String? remarks;
//   int? id;
//   Recipient? recipient;
//   String? transactionNumber;
//   String? remitterStatus;
//   String? benificiaryStatus;
//   String? paymentReceiveStatus;
//   Recipient? sender;
//   Agent? agent;
//   double? payoutAmount;
//   double? totalAmount;
//   double? receivingAmount;
//   ModeOfPayment? receiveMethod;
//   ModeOfPayment? paymentMethod;
//   double? totalCommission;
//   ServerCountry? senderCountry;
//   City? recipientCity;
//   ServerCountry? recipientCountry;
//   String? status;
//   Recipient? customer;
//   PaymentBank? paymentBank;
//   SendingPurpose? sendingPurpose;
//   Recipient? agentCustomer;
//   City? senderCity;
//
//   Transaction(
//       {this.bankName,
//         this.bankAccountNo,
//         this.bankAccountTitle,
//         this.bankSwiftCode,
//         this.bankAddress,
//         this.branchName,
//         this.payoutCurrency,
//         this.receivingCurrency,
//         this.transactionDate,
//         this.purpose,
//         this.purposeDescription,
//         this.settlementCurrency,
//         this.remarks,
//         this.id,
//         this.recipient,
//         this.transactionNumber,
//         this.remitterStatus,
//         this.benificiaryStatus,
//         this.paymentReceiveStatus,
//         this.sender,
//         this.agent,
//         this.payoutAmount,
//         this.totalAmount,
//         this.receivingAmount,
//         this.receiveMethod,
//         this.paymentMethod,
//         this.totalCommission,
//         this.senderCountry,
//         this.recipientCity,
//         this.recipientCountry,
//         this.status,
//         this.customer,
//         this.paymentBank,
//         this.sendingPurpose,
//         this.agentCustomer,
//         this.senderCity});
//
//   Transaction.fromJson(Map<String, dynamic> json) {
//     bankName = json['bank_name'];
//     bankAccountNo = json['bank_account_no'];
//     bankAccountTitle = json['bank_account_title'];
//     bankSwiftCode = json['bank_swift_code'];
//     bankAddress = json['bank_address'];
//     branchName = json['branch_name'];
//     payoutCurrency = json['payout_currency'];
//     receivingCurrency = json['receiving_currency'];
//     transactionDate = json['transaction_date'];
//     purpose = json['purpose'];
//     purposeDescription = json['purpose_description'];
//     settlementCurrency = json['settlement_currency'];
//     remarks = json['remarks'];
//     id = json['id'];
//     recipient = (json['recipient'] != null
//         ? Recipient.fromJson(json['recipient'])
//         : null);
//     transactionNumber = json['transaction_number'];
//     remitterStatus = json['remitter_status'];
//     benificiaryStatus = json['benificiary_status'];
//     paymentReceiveStatus = json['payment_receive_status'];
//     sender =
//     json['sender'] != null ? Recipient.fromJson(json['sender']) : null;
//     agent =
//     json['agent'] != null ? Agent.fromJson(json['agent']) : null;
//     payoutAmount = json['payout_amount']*1.0;
//     totalAmount = json['total_amount']*1.0;
//     receivingAmount = json['receiving_amount']*1.0;
//     receiveMethod = json['receive_method'] != null
//         ? ModeOfPayment.fromJson(json['receive_method'])
//         : null;
//     paymentMethod = json['payment_method'] != null
//         ? ModeOfPayment.fromJson(json['payment_method'])
//         : null;
//     totalCommission = json['total_commission']*1.0;
//     senderCountry = json['sender_country'] != null
//         ? ServerCountry.fromJson(json['sender_country'])
//         : null;
//     recipientCity = json['recipient_city'] != null
//         ? City.fromJson(json['recipient_city'])
//         : null;
//     recipientCountry = json['recipient_country'] != null
//         ? ServerCountry.fromJson(json['recipient_country'])
//         : null;
//     status = json['status'];
//     customer = json['customer'] != null
//         ? Recipient.fromJson(json['customer'])
//         : null;
//     paymentBank = json['payment_bank'] != null
//         ? PaymentBank.fromJson(json['payment_bank'])
//         : null;
//     sendingPurpose = json['sending_purpose'] != null
//         ? SendingPurpose.fromJson(json['sending_purpose'])
//         : null;
//     agentCustomer = json['agent_customer'] != null
//         ? Recipient.fromJson(json['agent_customer'])
//         : null;
//     senderCity = json['sender_city'] != null
//         ? City.fromJson(json['sender_city'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['bank_name'] = bankName;
//     data['bank_account_no'] = bankAccountNo;
//     data['bank_account_title'] = bankAccountTitle;
//     data['bank_swift_code'] = bankSwiftCode;
//     data['bank_address'] = bankAddress;
//     data['branch_name'] = branchName;
//     data['payout_currency'] = payoutCurrency;
//     data['receiving_currency'] = receivingCurrency;
//     data['transaction_date'] = transactionDate;
//     data['purpose'] = purpose;
//     data['purpose_description'] = purposeDescription;
//     data['settlement_currency'] = settlementCurrency;
//     data['remarks'] = remarks;
//     data['id'] = id;
//     if (recipient != null) {
//       data['recipient'] = recipient!.toJson();
//     }
//     data['transaction_number'] = transactionNumber;
//     data['remitter_status'] = remitterStatus;
//     data['benificiary_status'] = benificiaryStatus;
//     data['payment_receive_status'] = paymentReceiveStatus;
//     if (sender != null) {
//       data['sender'] = sender!.toJson();
//     }
//     if (agent != null) {
//       data['agent'] = agent!.toJson();
//     }
//     data['payout_amount'] = payoutAmount;
//     data['total_amount'] = totalAmount;
//     data['receiving_amount'] = receivingAmount;
//     if (receiveMethod != null) {
//       data['receive_method'] = receiveMethod!.toJson();
//     }
//     if (paymentMethod != null) {
//       data['payment_method'] = paymentMethod!.toJson();
//     }
//     data['total_commission'] = totalCommission;
//     if (senderCountry != null) {
//       data['sender_country'] = senderCountry!.toJson();
//     }
//     if (recipientCity != null) {
//       data['recipient_city'] = recipientCity!.toJson();
//     }
//     if (recipientCountry != null) {
//       data['recipient_country'] = recipientCountry!.toJson();
//     }
//     data['status'] = status;
//     if (customer != null) {
//       data['customer'] = customer!.toJson();
//     }
//     if (paymentBank != null) {
//       data['payment_bank'] = paymentBank!.toJson();
//     }
//     if (sendingPurpose != null) {
//       data['sending_purpose'] = sendingPurpose!.toJson();
//     }
//     if (agentCustomer != null) {
//       data['agent_customer'] = agentCustomer!.toJson();
//     }
//     if (senderCity != null) {
//       data['sender_city'] = senderCity!.toJson();
//     }
//     return data;
//   }
//
//   @override
//   bool operator ==(Object other) => other is Transaction && other.id == id;
//
//   @override
//   int get hashCode => id!;
// }






//TransactionRequestBody
class Transaction {
  String? message;
  Data? data;

  Transaction({this.message, this.data});

  Transaction.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? status;
  String? transactionNumber;
  String? partnerRefNumber;
  String? customerReferenceNo;
  String? beneficiaryReferenceNo;
  // Null? agentId;
  // Null? remarks;
  // Null? purpose;
  String? payoutCurrencyId;
  num? payoutAmount;
  // Null? remitterStatus;
  // Null? remitterStatusRemarks;
  int? beneficiaryStatus;
  //Null? beneficiaryStatusRemarks;
  int? senderMethodId;
  int? receiverMethodId;
  int? receiverCountryId;
  int? receiverCityId;
  //Null? organizationId;
  int? bankId;
  //Null? branchId;
  String? bankName;
  String? branchName;
  String? bankAccountNo;
  String? bankAccountTitle;
  String? bankSwiftCode;
  String? createdAt;
  String? updatedAt;
  //Null? deletedAt;
  int? createdByUserId;
  String? receivedCurrencyId;
  double? receivedAmount;
  num? commission;
  num? amountInUsd;
  num? commissionInUsd;
  int? purposeId;
  int? paymentBankId;
  double? totalAmount;
  PayoutCurrency? payoutCurrency;
  PayoutCurrency? receivedCurrency;
  ReceiverMethod? receiverMethod;
  SenderMethod? senderMethod;
  //Null? agent;
  Sender? sender;
  Receiver? receiver;
  TransactionSendingPurpose? sendingPurpose;
  //Null? paymentBank;

  Data(
      {this.id,
        this.status,
        this.transactionNumber,
        this.partnerRefNumber,
        this.customerReferenceNo,
        this.beneficiaryReferenceNo,
        // this.agentId,
        // this.remarks,
        // this.purpose,
        this.payoutCurrencyId,
        this.payoutAmount,
        // this.remitterStatus,
        // this.remitterStatusRemarks,
        this.beneficiaryStatus,
        //this.beneficiaryStatusRemarks,
        this.senderMethodId,
        this.receiverMethodId,
        this.receiverCountryId,
        this.receiverCityId,
       // this.organizationId,
        this.bankId,
        //this.branchId,
        this.bankName,
        this.branchName,
        this.bankAccountNo,
        this.bankAccountTitle,
        this.bankSwiftCode,
        this.createdAt,
        this.updatedAt,
        //this.deletedAt,
        this.createdByUserId,
        this.receivedCurrencyId,
        this.receivedAmount,
        this.commission,
        this.amountInUsd,
        this.commissionInUsd,
        this.purposeId,
        this.paymentBankId,
        this.totalAmount,
        this.payoutCurrency,
        this.receivedCurrency,
        this.receiverMethod,
        this.senderMethod,
        //this.agent,
        this.sender,
        this.receiver,
        this.sendingPurpose,
        //this.paymentBank
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    transactionNumber = json['transaction_number'];
    partnerRefNumber = json['partner_ref_number'];
    customerReferenceNo = json['customer_reference_no'];
    beneficiaryReferenceNo = json['beneficiary_reference_no'];
    // agentId = json['agent_id'];
    // remarks = json['remarks'];
    // purpose = json['purpose'];
    payoutCurrencyId = json['payout_currency_id'];
    payoutAmount = json['payout_amount'];
    // remitterStatus = json['remitter_status'];
    // remitterStatusRemarks = json['remitter_status_remarks'];
    beneficiaryStatus = json['beneficiary_status'];
    //beneficiaryStatusRemarks = json['beneficiary_status_remarks'];
    senderMethodId = json['sender_method_id'];
    receiverMethodId = json['receiver_method_id'];
    receiverCountryId = json['receiver_country_id'];
    receiverCityId = json['receiver_city_id'];
    //organizationId = json['organization_id'];
    bankId = json['bank_id'];
    //branchId = json['branch_id'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    bankAccountNo = json['bank_account_no'];
    bankAccountTitle = json['bank_account_title'];
    bankSwiftCode = json['bank_swift_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //deletedAt = json['deleted_at'];
    createdByUserId = json['created_by_user_id'];
    receivedCurrencyId = json['received_currency_id'];
    receivedAmount = json['received_amount'] !=null  ? json['received_amount'].toDouble() : json['received_amount'];
    commission = json['commission'];
    amountInUsd = json['amount_in_usd'];
    commissionInUsd = json['commission_in_usd'];
    purposeId = json['purpose_id'];
    paymentBankId = json['payment_bank_id'];
    totalAmount = json['total_amount'] !=null ? json['total_amount'].toDouble() : json['total_amount'];
    payoutCurrency = json['payout_currency'] != null
        ? new PayoutCurrency.fromJson(json['payout_currency'])
        : null;
    receivedCurrency = json['received_currency'] != null
        ? new PayoutCurrency.fromJson(json['received_currency'])
        : null;
    receiverMethod = json['receiver_method'] != null
        ? new ReceiverMethod.fromJson(json['receiver_method'])
        : null;
    senderMethod = json['sender_method'] != null
        ? new SenderMethod.fromJson(json['sender_method'])
        : null;
    //agent = json['agent'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    sendingPurpose = json['sending_purpose'] != null
        ? new TransactionSendingPurpose.fromJson(json['sending_purpose'])
        : null;
    //paymentBank = json['payment_bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['transaction_number'] = this.transactionNumber;
    data['partner_ref_number'] = this.partnerRefNumber;
    data['customer_reference_no'] = this.customerReferenceNo;
    data['beneficiary_reference_no'] = this.beneficiaryReferenceNo;
    // data['agent_id'] = this.agentId;
    // data['remarks'] = this.remarks;
    // data['purpose'] = this.purpose;
    data['payout_currency_id'] = this.payoutCurrencyId;
    data['payout_amount'] = this.payoutAmount;
    //data['remitter_status'] = this.remitterStatus;
   // data['remitter_status_remarks'] = this.remitterStatusRemarks;
    data['beneficiary_status'] = this.beneficiaryStatus;
   // data['beneficiary_status_remarks'] = this.beneficiaryStatusRemarks;
    data['sender_method_id'] = this.senderMethodId;
    data['receiver_method_id'] = this.receiverMethodId;
    data['receiver_country_id'] = this.receiverCountryId;
    data['receiver_city_id'] = this.receiverCityId;
   // data['organization_id'] = this.organizationId;
    data['bank_id'] = this.bankId;
    //data['branch_id'] = this.branchId;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['bank_account_no'] = this.bankAccountNo;
    data['bank_account_title'] = this.bankAccountTitle;
    data['bank_swift_code'] = this.bankSwiftCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    //data['deleted_at'] = this.deletedAt;
    data['created_by_user_id'] = this.createdByUserId;
    data['received_currency_id'] = this.receivedCurrencyId;
    data['received_amount'] = this.receivedAmount;
    data['commission'] = this.commission;
    data['amount_in_usd'] = this.amountInUsd;
    data['commission_in_usd'] = this.commissionInUsd;
    data['purpose_id'] = this.purposeId;
    data['payment_bank_id'] = this.paymentBankId;
    data['total_amount'] = this.totalAmount;
    if (this.payoutCurrency != null) {
      data['payout_currency'] = this.payoutCurrency!.toJson();
    }
    if (this.receivedCurrency != null) {
      data['received_currency'] = this.receivedCurrency!.toJson();
    }
    if (this.receiverMethod != null) {
      data['receiver_method'] = this.receiverMethod!.toJson();
    }
    if (this.senderMethod != null) {
      data['sender_method'] = this.senderMethod!.toJson();
    }
   // data['agent'] = this.agent;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    if (this.sendingPurpose != null) {
      data['sending_purpose'] = this.sendingPurpose!.toJson();
    }
   // data['payment_bank'] = this.paymentBank;
    return data;
  }
}

class PayoutCurrency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  // Null? createdAt;
  // Null? updatedAt;

  PayoutCurrency(
      {this.id,
        this.name,
        this.code,
        this.symbol,
        // this.createdAt,
        // this.updatedAt
      });

  PayoutCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['symbol'] = this.symbol;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ReceiverMethod {
  int? id;
  String? name;
  //Null? description;
  int? status;
  // Null? createdAt;
  // Null? updatedAt;
  // Null? deletedAt;

  ReceiverMethod(
      {this.id,
        this.name,
        //this.description,
        this.status,
        // this.createdAt,
        // this.updatedAt,
        // this.deletedAt
      });

  ReceiverMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //description = json['description'];
    status = json['status'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    //data['description'] = this.description;
    data['status'] = this.status;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class SenderMethod {
  int? id;
  String? name;
  //Null? description;
  int? status;
  // Null? createdAt;
  // Null? updatedAt;
  // Null? deletedAt;

  SenderMethod(
      {this.id,
        this.name,
        //this.description,
        this.status,
        // this.createdAt,
        // this.updatedAt,
        // this.deletedAt
      });

  SenderMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //description = json['description'];
    status = json['status'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    //data['description'] = this.description;
    data['status'] = this.status;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Sender {
  int? id;
  int? status;
  String? name;
  String? phone;
  String? email;
  String? streetAddress;
  String? postalCode;
  int? countryId;
  int? cityId;
  int? organizationId;
  int? isBeneficiary;
  String? referenceNo;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? createdByUserId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? emailVerifiedAt;
  // Null? dateOfBirth;
  // Null? profilePicture;
  // Null? otp;
  String? otpCreatedAt;
  TransactionCountry? country;
  TransactionCity? city;

  Sender(
      {this.id,
        this.status,
        this.name,
        this.phone,
        this.email,
        this.streetAddress,
        this.postalCode,
        this.countryId,
        this.cityId,
        this.organizationId,
        this.isBeneficiary,
        this.referenceNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.createdByUserId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.emailVerifiedAt,
        // this.dateOfBirth,
        // this.profilePicture,
        // this.otp,
        this.otpCreatedAt,
        this.country,
        this.city});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    streetAddress = json['street_address'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    organizationId = json['organization_id'];
    isBeneficiary = json['is_beneficiary'];
    referenceNo = json['reference_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdByUserId = json['created_by_user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailVerifiedAt = json['email_verified_at'];
    // dateOfBirth = json['date_of_birth'];
    // profilePicture = json['profile_picture'];
    // otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    country =
    json['country'] != null ? new TransactionCountry.fromJson(json['country']) : null;
    city = json['city'] != null ? new TransactionCity.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['street_address'] = this.streetAddress;
    data['postal_code'] = this.postalCode;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['organization_id'] = this.organizationId;
    data['is_beneficiary'] = this.isBeneficiary;
    data['reference_no'] = this.referenceNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_by_user_id'] = this.createdByUserId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email_verified_at'] = this.emailVerifiedAt;
    //data['date_of_birth'] = this.dateOfBirth;
    // data['profile_picture'] = this.profilePicture;
    // data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class TransactionCountry {
  int? id;
  int? status;
  String? name;
  //Null? description;
  String? isoCodeAlpha3;
  String? isoCodeAlpha2;
  // Null? logo;
  // Null? createdAt;
  // Null? updatedAt;
  // Null? deletedAt;

  TransactionCountry(
      {this.id,
        this.status,
        this.name,
        //this.description,
        this.isoCodeAlpha3,
        this.isoCodeAlpha2,
        // this.logo,
        // this.createdAt,
        // this.updatedAt,
        // this.deletedAt
     });

  TransactionCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    //description = json['description'];
    isoCodeAlpha3 = json['iso_code_alpha_3'];
    isoCodeAlpha2 = json['iso_code_alpha_2'];
    // logo = json['logo'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    //data['description'] = this.description;
    data['iso_code_alpha_3'] = this.isoCodeAlpha3;
    data['iso_code_alpha_2'] = this.isoCodeAlpha2;
    // data['logo'] = this.logo;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class TransactionCity {
  int? id;
  String? name;
  //Null? description;
  int? status;
  int? countryId;
  int? createdByUserId;
  String? createdAt;
  String? updatedAt;
  //Null? deletedAt;

  TransactionCity(
      {this.id,
        this.name,
        //this.description,
        this.status,
        this.countryId,
        this.createdByUserId,
        this.createdAt,
        this.updatedAt,
        //this.deletedAt
      });

  TransactionCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //description = json['description'];
    status = json['status'];
    countryId = json['country_id'];
    createdByUserId = json['created_by_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    //data['description'] = this.description;
    data['status'] = this.status;
    data['country_id'] = this.countryId;
    data['created_by_user_id'] = this.createdByUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
   // data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Receiver {
  int? id;
  int? status;
  String? name;
  String? phone;
  String? email;
  //Null? streetAddress;
  String? postalCode;
  int? countryId;
  int? cityId;
  int? organizationId;
  int? isBeneficiary;
  String? referenceNo;
  String? createdAt;
  String? updatedAt;
  //Null? deletedAt;
  int? createdByUserId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? emailVerifiedAt;
  // Null? dateOfBirth;
  // Null? profilePicture;
  // Null? otp;
  // Null? otpCreatedAt;
  TransactionCountry? country;
  TransactionCity? city;

  Receiver(
      {this.id,
        this.status,
        this.name,
        this.phone,
        this.email,
        //this.streetAddress,
        this.postalCode,
        this.countryId,
        this.cityId,
        this.organizationId,
        this.isBeneficiary,
        this.referenceNo,
        this.createdAt,
        this.updatedAt,
        //this.deletedAt,
        this.createdByUserId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.emailVerifiedAt,
        // this.dateOfBirth,
        // this.profilePicture,
        // this.otp,
        // this.otpCreatedAt,
        this.country,
        this.city});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    //streetAddress = json['street_address'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    organizationId = json['organization_id'];
    isBeneficiary = json['is_beneficiary'];
    referenceNo = json['reference_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //deletedAt = json['deleted_at'];
    createdByUserId = json['created_by_user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailVerifiedAt = json['email_verified_at'];
    // dateOfBirth = json['date_of_birth'];
    // profilePicture = json['profile_picture'];
    // otp = json['otp'];
    // otpCreatedAt = json['otp_created_at'];
    country =
    json['country'] != null ? new TransactionCountry.fromJson(json['country']) : null;
    city = json['city'] != null ? new TransactionCity.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    //data['street_address'] = this.streetAddress;
    data['postal_code'] = this.postalCode;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['organization_id'] = this.organizationId;
    data['is_beneficiary'] = this.isBeneficiary;
    data['reference_no'] = this.referenceNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    //data['deleted_at'] = this.deletedAt;
    data['created_by_user_id'] = this.createdByUserId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email_verified_at'] = this.emailVerifiedAt;
    // data['date_of_birth'] = this.dateOfBirth;
    // data['profile_picture'] = this.profilePicture;
    // data['otp'] = this.otp;
    // data['otp_created_at'] = this.otpCreatedAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class TransactionSendingPurpose {
  int? id;
  String? name;
  String? description;
  int? status;
  // Null? createdAt;
  // Null? updatedAt;
  // Null? deletedAt;

  TransactionSendingPurpose(
      {this.id,
        this.name,
        this.description,
        this.status,
        // this.createdAt,
        // this.updatedAt,
        // this.deletedAt
      });

  TransactionSendingPurpose.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['deleted_at'] = this.deletedAt;
    return data;
  }
}




class TransactionRequestBody {
  int ? bankId;
  String ? bankAccountNo;
  String ? bankAccountTitle;
  String ? bankSwiftCode;
  String ? payoutCurrency;
  String ? receivingCurrency;
  double ? payoutAmount;
  int ? receiverMethodId;
  int ? senderMethodId;
  int ? recipientId;
  int? senderCountryId;
  int ? receiverCityId;
  int ? receiverCountryId;
  int? purposeId;
  String? bankName;
  String? branchName;

  TransactionRequestBody(
      {
        this.bankId,
        this.bankAccountNo,
        this.bankAccountTitle,
        this.bankSwiftCode,
        this.payoutCurrency,
        this.receivingCurrency,
        this.payoutAmount,
        this.receiverMethodId,
        this.senderMethodId,
        this.recipientId,
        this.senderCountryId,
        this.receiverCityId,
        this.receiverCountryId,
        this.purposeId,
        this.bankName,
        this.branchName
      });

  TransactionRequestBody.fromJson(Map<String, dynamic> json) {
    //bankId = json['bank_id'];
    bankAccountNo = json['bank_account_no'];
    bankAccountTitle = json['bank_account_title'];
    bankSwiftCode = json['bank_swift_code'];
    payoutCurrency = json['payout_currency'];
    receivingCurrency = json['receiving_currency'];
    payoutAmount = json['payout_amount'];
    receiverMethodId = json['receiver_method_id'];
    senderMethodId = json['sender_method_id'];
    recipientId = json['recipient_id'];
    senderCountryId = json['sender_country_id'];
    receiverCityId = json['receiver_city_id'];
    receiverCountryId = json['receiver_country_id'];
    purposeId = json['purpose_id'];
    branchName = json['bank_name'];
    bankName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['bank_id'] = bankId;
    data['bank_account_no'] = bankAccountNo;
    data['bank_account_title'] = bankAccountTitle;
    data['bank_swift_code'] = bankSwiftCode;
    data['payout_currency'] = payoutCurrency;
    data['receiving_currency'] = receivingCurrency;
    data['payout_amount'] = payoutAmount;
    data['receiver_method_id'] = receiverMethodId;
    data['sender_method_id'] = senderMethodId;
    data['recipient_id'] = recipientId;
    data['sender_country_id'] = senderCountryId;
    data['receiver_city_id'] = receiverCityId;
    data['receiver_country_id'] = receiverCountryId;
    data['purpose_id'] = purposeId;
    data['bank_name'] = branchName;
    data['branch_name'] = bankName;

    return data;
  }
}

class TransactionRequestBodyforBank {
  int ? bankId;
  String ? bankAccountNo;
  String ? bankAccountTitle;
  String ? bankSwiftCode;
  String ? payoutCurrency;
  String ? receivingCurrency;
  double ? payoutAmount;
  int ? receiverMethodId;
  int ? senderMethodId;
  int ? recipientId;
  int? senderCountryId;
  int ? receiverCityId;
  int ? receiverCountryId;
  int? purposeId;
  String? bankName;
  String? branchName;

  TransactionRequestBodyforBank(
      {
        this.bankId,
        this.bankAccountNo,
        this.bankAccountTitle,
        this.bankSwiftCode,
        this.payoutCurrency,
        this.receivingCurrency,
        this.payoutAmount,
        this.receiverMethodId,
        this.senderMethodId,
        this.recipientId,
        this.senderCountryId,
        this.receiverCityId,
        this.receiverCountryId,
        this.purposeId,
        this.bankName,
        this.branchName
      });

  TransactionRequestBodyforBank.fromJson(Map<String, dynamic> json) {
    bankId = json['bank_id'];
    bankAccountNo = json['bank_account_no'];
    bankAccountTitle = json['bank_account_title'];
    bankSwiftCode = json['bank_swift_code'];
    payoutCurrency = json['payout_currency'];
    receivingCurrency = json['receiving_currency'];
    payoutAmount = json['payout_amount'];
    receiverMethodId = json['receiver_method_id'];
    senderMethodId = json['sender_method_id'];
    recipientId = json['recipient_id'];
    senderCountryId = json['sender_country_id'];
    receiverCityId = json['receiver_city_id'];
    receiverCountryId = json['receiver_country_id'];
    purposeId = json['purpose_id'];
    branchName = json['bank_name'];
    bankName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_id'] = bankId;
    data['bank_account_no'] = bankAccountNo;
    data['bank_account_title'] = bankAccountTitle;
    data['bank_swift_code'] = bankSwiftCode;
    data['payout_currency'] = payoutCurrency;
    data['receiving_currency'] = receivingCurrency;
    data['payout_amount'] = payoutAmount;
    data['receiver_method_id'] = receiverMethodId;
    data['sender_method_id'] = senderMethodId;
    data['recipient_id'] = recipientId;
    data['sender_country_id'] = senderCountryId;
    data['receiver_city_id'] = receiverCityId;
    data['receiver_country_id'] = receiverCountryId;
    data['purpose_id'] = purposeId;
    data['bank_name'] = branchName;
    data['branch_name'] = bankName;

    return data;
  }
}