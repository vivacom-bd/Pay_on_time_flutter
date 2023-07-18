class PersonalAccountCard {
  bool? success;
  int? total;
  List<Data>? data;

  PersonalAccountCard({this.success, this.total, this.data});

  PersonalAccountCard.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? account;
  String? cardHolder;
  String? externalId;
  double? balance;
  String? state;
  String? type;
  String? sequenceNumber;
  String? panFirst6;
  String? panLast4;
  String? expiry;
  String? pinFailCount;
  String? status;
  String? addedDate;
  String? active;
  String? createdby;
  String? createdon;

  Data(
      {this.id,
        this.account,
        this.cardHolder,
        this.externalId,
        this.balance,
        this.state,
        this.type,
        this.sequenceNumber,
        this.panFirst6,
        this.panLast4,
        this.expiry,
        this.pinFailCount,
        this.status,
        this.addedDate,
        this.active,
        this.createdby,
        this.createdon});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account = json['account'];
    cardHolder = json['card_holder'];
    externalId = json['externalId'];
    balance = json['balance'];
    state = json['state'];
    type = json['type'];
    sequenceNumber = json['sequenceNumber'];
    panFirst6 = json['panFirst6'];
    panLast4 = json['panLast4'];
    expiry = json['expiry'];
    pinFailCount = json['pinFailCount'];
    status = json['status'];
    addedDate = json['addedDate'];
    active = json['active'];
    createdby = json['createdby'];
    createdon = json['createdon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account'] = this.account;
    data['card_holder'] = this.cardHolder;
    data['externalId'] = this.externalId;
    data['balance'] = this.balance;
    data['state'] = this.state;
    data['type'] = this.type;
    data['sequenceNumber'] = this.sequenceNumber;
    data['panFirst6'] = this.panFirst6;
    data['panLast4'] = this.panLast4;
    data['expiry'] = this.expiry;
    data['pinFailCount'] = this.pinFailCount;
    data['status'] = this.status;
    data['addedDate'] = this.addedDate;
    data['active'] = this.active;
    data['createdby'] = this.createdby;
    data['createdon'] = this.createdon;
    return data;
  }
}
