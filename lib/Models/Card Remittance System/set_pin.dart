class PinSet {
  bool? success;
  String? reason;

  PinSet({this.success, this.reason});

  PinSet.fromJson(Map<String, dynamic> json) {
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
