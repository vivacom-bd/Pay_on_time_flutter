class LoadCard {
  bool? success;
  String? reason;

  LoadCard({this.success, this.reason});

  LoadCard.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['reason'] = this.reason;
    return data;
  }
}
