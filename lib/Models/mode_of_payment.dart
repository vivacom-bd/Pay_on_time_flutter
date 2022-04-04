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

  @override
  bool operator ==(Object other) => other is ModeOfPayment && other.id == id;

  @override
  int get hashCode => id!;
}