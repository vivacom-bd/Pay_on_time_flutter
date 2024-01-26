class KycTokenModel {
  String? kycApplicationId;
  String? kycUserToken;

  KycTokenModel({this.kycApplicationId, this.kycUserToken});

  KycTokenModel.fromJson(Map<String, dynamic> json) {
    kycApplicationId = json['kyc_application_id'];
    kycUserToken = json['kyc_user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kyc_application_id'] = this.kycApplicationId;
    data['kyc_user_token'] = this.kycUserToken;
    return data;
  }
}
