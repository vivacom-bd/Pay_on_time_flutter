class CardPin {
  bool? success;
  String? message;
  String? pin;

  CardPin({this.success, this.message, this.pin});

  CardPin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['pin'] = this.pin;
    return data;
  }
}
