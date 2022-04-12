class PaymentCard {
  int? userId;
  String? cardInfo;
  String? referenceNumber;
  String? cardType;
  int? id;

  PaymentCard(
      {this.userId,
        this.cardInfo,
        this.referenceNumber,
        this.cardType,
        this.id});

  PaymentCard.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cardInfo = json['card_info'];
    referenceNumber = json['reference_number'];
    cardType = json['card_type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['card_info'] = cardInfo;
    data['reference_number'] = referenceNumber;
    data['card_type'] = cardType;
    data['id'] = id;
    return data;
  }


  @override
  bool operator ==(Object other) => other is PaymentCard && other.id == id;

  @override
  int get hashCode => id!;
}