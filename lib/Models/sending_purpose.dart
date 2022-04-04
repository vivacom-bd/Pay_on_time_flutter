class SendingPurpose {
  String? name;
  String? description;
  int? id;
  String? status;

  SendingPurpose({this.name, this.description, this.id, this.status});

  SendingPurpose.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    data['status'] = status;
    return data;
  }

  @override
  bool operator ==(Object other) => other is SendingPurpose && other.id == id;

  @override
  int get hashCode => id!;


}