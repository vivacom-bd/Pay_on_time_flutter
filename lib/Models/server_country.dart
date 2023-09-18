import 'package:hidmona/Models/server_currency.dart';

class ServerCountry {
  String? name;
  int? id;
  String? countryCode;
  String? logo;
  ServerCurrency? selectedCurrency;
  List<ServerCurrency>? currencies;

  ServerCountry({this.name, this.id,  this.countryCode, this.selectedCurrency});

  ServerCountry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    countryCode = json['iso_code_alpha_2'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['iso_code_alpha_2'] = countryCode;
    data['logo'] = logo;
    return data;
  }

  @override
  bool operator ==(Object other) => other is ServerCountry && other.id == id;

  @override
  int get hashCode => id!;

}