class DashunBankInfo {
  String? detail;
  String? name;
  Data? data;

  DashunBankInfo({this.detail, this.name, this.data});

  DashunBankInfo.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    name = json['name'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['name'] = name;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? lang1;
  String? cp1;
  String? name1Lang1;
  String? name2Lang1;

  Data({this.lang1, this.cp1, this.name1Lang1, this.name2Lang1});

  Data.fromJson(Map<String, dynamic> json) {
    lang1 = json['lang1'];
    cp1 = json['cp1'];
    name1Lang1 = json['name1Lang1'];
    name2Lang1 = json['name2Lang1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lang1'] = lang1;
    data['cp1'] = cp1;
    data['name1Lang1'] = name1Lang1;
    data['name2Lang1'] = name2Lang1;
    return data;
  }
}