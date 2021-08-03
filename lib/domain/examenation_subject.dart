class ExamenationSubject {
  final int id;
  final int value;

  ExamenationSubject(this.id, this.value);

  factory ExamenationSubject.fromJson(Map<String, dynamic> json) =>
      ExamenationSubject(
        json['id'],
        json['value'],
      );
}
