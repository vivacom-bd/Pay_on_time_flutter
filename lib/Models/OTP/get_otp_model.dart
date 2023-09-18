class GetOtp {
  String? message;
  List<Null>? data;

  GetOtp({this.message, this.data});

  GetOtp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        //data!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      //data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
