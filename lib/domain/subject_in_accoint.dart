class SubjectInAccount {
  final int id;
  final int value;
  const SubjectInAccount({required this.id, required this.value});

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
  factory SubjectInAccount.fromJson(Map<String, dynamic> json) =>
      SubjectInAccount(
        id: json["id"],
        value: json["value"],
      );
}
