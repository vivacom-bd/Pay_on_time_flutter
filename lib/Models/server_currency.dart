
class ServerCurrency {
  int? id;
  String? name;
  String? code;
  bool? defaultCurrency;

  ServerCurrency({this.id, this.name, this.code, this.defaultCurrency});

  ServerCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    defaultCurrency = json['default_currency']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['default_currency'] = defaultCurrency;
    return data;
  }

  @override
  bool operator ==(Object other) => other is ServerCurrency && other.id == id;

  @override
  int get hashCode => id!;
}