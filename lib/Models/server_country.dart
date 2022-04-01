import 'package:hidmona/Models/server_currency.dart';

class ServerCountry {
  String? name;
  int? id;
  String? code;
  String? countryCode;
  String? logo;
  ServerCurrency? selectedCurrency;
  List<ServerCurrency>? currencies;

  ServerCountry({this.name, this.id, this.code, this.countryCode, this.selectedCurrency});

  ServerCountry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    code = json['code'];
    countryCode = json['country_code']??json['country_code_alpha2'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['code'] = code;
    data['country_code'] = countryCode;
    data['logo'] = logo;
    return data;
  }

}