class SendingPurpose{
  String value;
  String title;

  SendingPurpose({required this.value, required this.title});

  @override
  bool operator ==(Object other) => other is SendingPurpose && other.value == value;

  @override
  int get hashCode => value.hashCode;
}