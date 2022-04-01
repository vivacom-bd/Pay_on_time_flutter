class ModeOfPayment {
  String? name;
  int? id;

  ModeOfPayment({this.name, this.id});

  ModeOfPayment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }

  static List<ModeOfPayment> getSendingPurpose(){
    return [
      ModeOfPayment(id: 1, name: "Cash"),
      ModeOfPayment(id: 2, name: "Bank"),
      ModeOfPayment(id: 3, name: "DEBIT_OR_CREDIT"),
    ];
  }
}