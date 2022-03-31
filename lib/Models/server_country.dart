import 'package:hidmona/Models/server_currency.dart';

class ServerCountry {
  String? name;
  int? id;
  String? code;
  String? countryCode;
  ServerCurrency? selectedCurrency;
  List<ServerCurrency>? currencies;

  ServerCountry({this.name, this.id, this.code, this.countryCode, this.selectedCurrency});

  ServerCountry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    code = json['code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['code'] = code;
    data['country_code'] = countryCode;
    return data;
  }

}