class CardDetails {
  bool? success;
  Data? data;

  CardDetails({this.success, this.data});

  CardDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CardholderDto? cardholderDto;
  ShippingAddress? shippingAddress;
  ShippingAddress? address;
  String? phone;
  int? status;
  List<Card>? cards;
  List<Null>? failedChecks;
  String? externalId;
  String? cardLedgerUid;
  String? holderId;
  String? programmeConfigurationUid;
  String? applicationId;
  int? partners;
  String? programmeUid;

  Data(
      {this.cardholderDto,
        this.shippingAddress,
        this.address,
        this.phone,
        this.status,
        this.cards,
        this.failedChecks,
        this.externalId,
        this.cardLedgerUid,
        this.holderId,
        this.programmeConfigurationUid,
        this.applicationId,
        this.partners,
        this.programmeUid});

  Data.fromJson(Map<String, dynamic> json) {
    cardholderDto = json['cardholderDto'] != null
        ? new CardholderDto.fromJson(json['cardholderDto'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    address = json['address'] != null
        ? new ShippingAddress.fromJson(json['address'])
        : null;
    phone = json['phone'];
    status = json['status'];
    if (json['cards'] != null) {
      cards = <Card>[];
      json['cards'].forEach((v) {
        cards!.add(new Card.fromJson(v));
      });
    }
    if (json['failedChecks'] != null) {
      failedChecks = <Null>[];
      json['failedChecks'].forEach((v) {
        //failedChecks!.add(new Null.fromJson(v));
      });
    }
    externalId = json['externalId'];
    cardLedgerUid = json['cardLedgerUid'];
    holderId = json['holderId'];
    programmeConfigurationUid = json['programmeConfigurationUid'];
    applicationId = json['applicationId'];
    partners = json['partners'];
    programmeUid = json['programmeUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardholderDto != null) {
      data['cardholderDto'] = this.cardholderDto!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    data['status'] = this.status;
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    // if (this.failedChecks != null) {
    //   data['failedChecks'] = this.failedChecks!.map((v) => v.toJson()).toList();
    // }
    data['externalId'] = this.externalId;
    data['cardLedgerUid'] = this.cardLedgerUid;
    data['holderId'] = this.holderId;
    data['programmeConfigurationUid'] = this.programmeConfigurationUid;
    data['applicationId'] = this.applicationId;
    data['partners'] = this.partners;
    data['programmeUid'] = this.programmeUid;
    return data;
  }
}

class CardholderDto {
  String? firstName;
  String? middleName;
  String? lastName;
  String? title;
  String? suffix;
  String? embossedName;
  String? dateOfBirth;
  String? email;
  String? username;
  String? clientReference;

  CardholderDto(
      {this.firstName,
        this.middleName,
        this.lastName,
        this.title,
        this.suffix,
        this.embossedName,
        this.dateOfBirth,
        this.email,
        this.username,
        this.clientReference});

  CardholderDto.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    title = json['title'];
    suffix = json['suffix'];
    embossedName = json['embossedName'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    username = json['username'];
    clientReference = json['clientReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['title'] = this.title;
    data['suffix'] = this.suffix;
    data['embossedName'] = this.embossedName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['username'] = this.username;
    data['clientReference'] = this.clientReference;
    return data;
  }
}

class ShippingAddress {
  String? postalCode;
  String? city;
  String? country;
  String? state;
  String? line1;
  String? line2;

  ShippingAddress(
      {this.postalCode,
        this.city,
        this.country,
        this.state,
        this.line1,
        this.line2});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    line1 = json['line1'];
    line2 = json['line2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    return data;
  }
}

class Card {
  String? externalId;
  int? type;
  int? state;
  int? sequenceNumber;
  String? embossedName;
  String? panFirst6;
  String? panLast4;
  String? expiry;
  int? pinFailCount;
  int? status;
  String? addedDate;

  Card(
      {this.externalId,
        this.type,
        this.state,
        this.sequenceNumber,
        this.embossedName,
        this.panFirst6,
        this.panLast4,
        this.expiry,
        this.pinFailCount,
        this.status,
        this.addedDate});

  Card.fromJson(Map<String, dynamic> json) {
    externalId = json['externalId'];
    type = json['type'];
    state = json['state'];
    sequenceNumber = json['sequenceNumber'];
    embossedName = json['embossedName'];
    panFirst6 = json['panFirst6'];
    panLast4 = json['panLast4'];
    expiry = json['expiry'];
    pinFailCount = json['pinFailCount'];
    status = json['status'];
    addedDate = json['addedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['externalId'] = this.externalId;
    data['type'] = this.type;
    data['state'] = this.state;
    data['sequenceNumber'] = this.sequenceNumber;
    data['embossedName'] = this.embossedName;
    data['panFirst6'] = this.panFirst6;
    data['panLast4'] = this.panLast4;
    data['expiry'] = this.expiry;
    data['pinFailCount'] = this.pinFailCount;
    data['status'] = this.status;
    data['addedDate'] = this.addedDate;
    return data;
  }
}
