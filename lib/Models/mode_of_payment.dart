class ModeOfPayment {
  String? name;
  int? id;
  String ? description;
  int ? status;

  ModeOfPayment({this.name, this.id, this.description, this.status});

  ModeOfPayment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['description'] = description;
    data['status'] = status;
    return data;
  }

  @override
  bool operator ==(Object other) => other is ModeOfPayment && other.id == id;

  @override
  int get hashCode => id!;
}