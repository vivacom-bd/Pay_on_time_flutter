class TransactionList {
  String? message;
  List<TransactionData>? data;

  TransactionList({this.message, this.data});

  TransactionList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionData {
  int? id;
  int? status;
  String? transactionNumber;
  String? partnerRefNumber;
  String? customerReferenceNo;
  String? beneficiaryReferenceNo;
  int? agentId;
  String? remarks;
  String? purpose;
  String? payoutCurrencyId;
  double? payoutAmount;
  int? remitterStatus;
  String? remitterStatusRemarks;
  int? beneficiaryStatus;
  String? beneficiaryStatusRemarks;
  int? senderMethodId;
  int? receiverMethodId;
  int? receiverCountryId;
  int? receiverCityId;
  int? organizationId;
  int? bankId;
  int? branchId;
  String? bankName;
  String? branchName;
  String? bankAccountNo;
  String? bankAccountTitle;
  String? bankSwiftCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? createdByUserId;
  String? receivedCurrencyId;
  double? receivedAmount;
  double? commission;
  double? amountInUsd;
  double? commissionInUsd;
  int? purposeId;
  int? paymentBankId;
  num ? totalAmount;
  String? payoutCurrency;
  String? receivedCurrency;
  ReceiverMethod? receiverMethod;
  ReceiverMethod? senderMethod;
  //String? agent;
  Sender? sender;
  Receiver? receiver;
  SendingPurpose? sendingPurpose;
  String? paymentBank;

  TransactionData(
      {this.id,
        this.status,
        this.transactionNumber,
        this.partnerRefNumber,
        this.customerReferenceNo,
        this.beneficiaryReferenceNo,
        this.agentId,
        this.remarks,
        this.purpose,
        this.payoutCurrencyId,
        this.payoutAmount,
        this.remitterStatus,
        this.remitterStatusRemarks,
        this.beneficiaryStatus,
        this.beneficiaryStatusRemarks,
        this.senderMethodId,
        this.receiverMethodId,
        this.receiverCountryId,
        this.receiverCityId,
        this.organizationId,
        this.bankId,
        this.branchId,
        this.bankName,
        this.branchName,
        this.bankAccountNo,
        this.bankAccountTitle,
        this.bankSwiftCode,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
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
        this.paymentBank});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    transactionNumber = json['transaction_number'];
    partnerRefNumber = json['partner_ref_number'];
    customerReferenceNo = json['customer_reference_no'];
    beneficiaryReferenceNo = json['beneficiary_reference_no'];
    agentId = json['agent_id'];
    remarks = json['remarks'];
    purpose = json['purpose'];
    payoutCurrencyId = json['payout_currency_id'];
    payoutAmount = json['payout_amount'] !=null ?  json['payout_amount'].toDouble() : 0.00;
    remitterStatus = json['remitter_status'];
    remitterStatusRemarks = json['remitter_status_remarks'];
    beneficiaryStatus = json['beneficiary_status'];
    beneficiaryStatusRemarks = json['beneficiary_status_remarks'];
    senderMethodId = json['sender_method_id'];
    receiverMethodId = json['receiver_method_id'];
    receiverCountryId = json['receiver_country_id'];
    receiverCityId = json['receiver_city_id'];
    organizationId = json['organization_id'];
    bankId = json['bank_id'];
    branchId = json['branch_id'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    bankAccountNo = json['bank_account_no'];
    bankAccountTitle = json['bank_account_title'];
    bankSwiftCode = json['bank_swift_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdByUserId = json['created_by_user_id'];
    receivedCurrencyId = json['received_currency_id'];
    receivedAmount = json['received_amount'] !=null ?  json['received_amount'].toDouble() : json['received_amount'];
    commission = json['commission'] !=null ? json['commission'].toDouble() : 0.00;
    amountInUsd = json['amount_in_usd'] !=null ? json['amount_in_usd'].toDouble() : 0.00;
    commissionInUsd = json['commission_in_usd'] !=null ? json['commission_in_usd'].toDouble() : 0.00;
    purposeId = json['purpose_id'];
    paymentBankId = json['payment_bank_id'];
    //totalAmount = (json['total_amount'] !=null && json['total_amount'] is int) ? json['total_amount'].toDouble : json['total_amount'];
    totalAmount = json['total_amount'];
    payoutCurrency = json['payout_currency'];
    receivedCurrency = json['received_currency'];
    receiverMethod = json['receiver_method'] != null
        ? new ReceiverMethod.fromJson(json['receiver_method'])
        : null;
    senderMethod = json['sender_method'] != null
        ? new ReceiverMethod.fromJson(json['sender_method'])
        : null;
    //agent = json['agent'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    sendingPurpose = json['sending_purpose'] != null
        ? new SendingPurpose.fromJson(json['sending_purpose'])
        : null;
    paymentBank = json['payment_bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['transaction_number'] = this.transactionNumber;
    data['partner_ref_number'] = this.partnerRefNumber;
    data['customer_reference_no'] = this.customerReferenceNo;
    data['beneficiary_reference_no'] = this.beneficiaryReferenceNo;
    data['agent_id'] = this.agentId;
    data['remarks'] = this.remarks;
    data['purpose'] = this.purpose;
    data['payout_currency_id'] = this.payoutCurrencyId;
    data['payout_amount'] = this.payoutAmount;
    data['remitter_status'] = this.remitterStatus;
    data['remitter_status_remarks'] = this.remitterStatusRemarks;
    data['beneficiary_status'] = this.beneficiaryStatus;
    data['beneficiary_status_remarks'] = this.beneficiaryStatusRemarks;
    data['sender_method_id'] = this.senderMethodId;
    data['receiver_method_id'] = this.receiverMethodId;
    data['receiver_country_id'] = this.receiverCountryId;
    data['receiver_city_id'] = this.receiverCityId;
    data['organization_id'] = this.organizationId;
    data['bank_id'] = this.bankId;
    data['branch_id'] = this.branchId;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['bank_account_no'] = this.bankAccountNo;
    data['bank_account_title'] = this.bankAccountTitle;
    data['bank_swift_code'] = this.bankSwiftCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_by_user_id'] = this.createdByUserId;
    data['received_currency_id'] = this.receivedCurrencyId;
    data['received_amount'] = this.receivedAmount;
    data['commission'] = this.commission;
    data['amount_in_usd'] = this.amountInUsd;
    data['commission_in_usd'] = this.commissionInUsd;
    data['purpose_id'] = this.purposeId;
    data['payment_bank_id'] = this.paymentBankId;
    data['total_amount'] = this.totalAmount;
    data['payout_currency'] = this.payoutCurrency;
    data['received_currency'] = this.receivedCurrency;
    if (this.receiverMethod != null) {
      data['receiver_method'] = this.receiverMethod!.toJson();
    }
    if (this.senderMethod != null) {
      data['sender_method'] = this.senderMethod!.toJson();
    }
    //data['agent'] = this.agent;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    if (this.sendingPurpose != null) {
      data['sending_purpose'] = this.sendingPurpose!.toJson();
    }
    data['payment_bank'] = this.paymentBank;
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
  // Null? emailVerifiedAt;
  // Null? dateOfBirth;
  // Null? profilePicture;
  // Null? otp;
  String? otpCreatedAt;
  Country? country;
  City? city;

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
        // this.emailVerifiedAt,
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
    // emailVerifiedAt = json['email_verified_at'];
    // dateOfBirth = json['date_of_birth'];
    // profilePicture = json['profile_picture'];
    // otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
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
    // data['email_verified_at'] = this.emailVerifiedAt;
    // data['date_of_birth'] = this.dateOfBirth;
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

class Country {
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

  Country(
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

  Country.fromJson(Map<String, dynamic> json) {
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

class City {
  int? id;
  String? name;
  //Null? description;
  int? status;
  int? countryId;
  int? createdByUserId;
  String? createdAt;
  String? updatedAt;
  //Null? deletedAt;

  City(
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

  City.fromJson(Map<String, dynamic> json) {
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
    //data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Receiver {
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
  // Null? emailVerifiedAt;
  // Null? dateOfBirth;
  // Null? profilePicture;
  // Null? otp;
  // Null? otpCreatedAt;
  Country? country;
  City? city;

  Receiver(
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
        // this.emailVerifiedAt,
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
    // emailVerifiedAt = json['email_verified_at'];
    // dateOfBirth = json['date_of_birth'];
    // profilePicture = json['profile_picture'];
    // otp = json['otp'];
    // otpCreatedAt = json['otp_created_at'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
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
    // data['email_verified_at'] = this.emailVerifiedAt;
    // data['date_of_birth'] = this.dateOfBirth;
    // data['profile_picture'] = this.profilePicture;
    // data['otp'] = this.otp;
    //data['otp_created_at'] = this.otpCreatedAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class SendingPurpose {
  int? id;
  String? name;
  String? description;
  int? status;
  // Null? createdAt;
  // Null? updatedAt;
  // Null? deletedAt;

  SendingPurpose(
      {this.id,
        this.name,
        this.description,
        this.status,
        // this.createdAt,
        // this.updatedAt,
        // this.deletedAt
      });

  SendingPurpose.fromJson(Map<String, dynamic> json) {
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
