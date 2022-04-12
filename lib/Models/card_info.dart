class CardInfo {
  String? pan;
  String? expiryDate;
  String? securityCode;
  String? billingPremise;
  String? billingPostcode;

  CardInfo(
      {this.pan,
        this.expiryDate,
        this.securityCode,
        this.billingPremise,
        this.billingPostcode});

  CardInfo.fromJson(Map<String, dynamic> json) {
    pan = json['pan'];
    expiryDate = json['expirydate'];
    securityCode = json['securitycode'];
    billingPremise = json['billingpremise'];
    billingPostcode = json['billingpostcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pan'] = pan;
    data['expirydate'] = expiryDate;
    data['securitycode'] = securityCode;
    data['billingpremise'] = billingPremise;
    data['billingpostcode'] = billingPostcode;
    return data;
  }
}