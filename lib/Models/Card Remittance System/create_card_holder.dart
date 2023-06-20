class CreateCardHolder {
  bool? success;
  Data? data;

  CreateCardHolder({this.success, this.data});

  CreateCardHolder.fromJson(Map<String, dynamic> json) {
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
  List<Null>? cards;
  List<Null>? failedChecks;
  String? externalId;
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
    // if (json['cards'] != null) {
    //   cards = <Null>[];
    //   json['cards'].forEach((v) {
    //     cards!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['failedChecks'] != null) {
    //   failedChecks = <Null>[];
    //   json['failedChecks'].forEach((v) {
    //     failedChecks!.add(new Null.fromJson(v));
    //   });
    // }
    externalId = json['externalId'];
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
    // if (this.cards != null) {
    //   data['cards'] = this.cards!.map((v) => v?.toJson()).toList();
    // }
    // if (this.failedChecks != null) {
    //   data['failedChecks'] = this.failedChecks!.map((v) => v.toJson()).toList();
    // }
    data['externalId'] = this.externalId;
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
  String? lastName;
  String? title;
  String? embossedName;
  String? dateOfBirth;
  String? email;
  String? username;
  String? clientReference;

  CardholderDto(
      {this.firstName,
        this.lastName,
        this.title,
        this.embossedName,
        this.dateOfBirth,
        this.email,
        this.username,
        this.clientReference});

  CardholderDto.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    title = json['title'];
    embossedName = json['embossedName'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    username = json['username'];
    clientReference = json['clientReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['title'] = this.title;
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
