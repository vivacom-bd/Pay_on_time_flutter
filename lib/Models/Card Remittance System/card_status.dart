class CardStatus {
  bool? success;
  String? message;
  String? state;

  CardStatus({this.success, this.message, this.state});

  CardStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['state'] = this.state;
    return data;
  }
}
