import 'package:abitur/domain/subject_in_accoint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(
  createToJson: false,
)
class AccountData {
  final int id;
  final String firstName;
  final String lastName;
  final String? surName;
  final String email;
  final String phoneNumber;
  final DateTime birthday;
  final String? country;
  final String? region;
  final String city;
  final int points;
  final int egePoints;
  final List<SubjectInAccount> subjectInAccount;

  AccountData({
    required this.id,
    required this.points,
    required this.birthday,
    required this.city,
    required this.country,
    required this.egePoints,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.region,
    required this.surName,
    required this.subjectInAccount,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        surName: json["surName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        birthday: DateTime.parse(json["birthday"]),
        country: json["country"],
        region: json["region"],
        city: json["city"],
        points: json["points"],
        egePoints: json["egePoints"],
        subjectInAccount: List<SubjectInAccount>.from(
            json["subjects"].map((x) => SubjectInAccount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "surName": surName,
        "email": email,
        "phoneNumber": phoneNumber,
        "birthday": birthday.toIso8601String(),
        "country": country,
        "region": region,
        "city": city,
        "points": points,
        "egePoints": egePoints,
        "subjects": List<dynamic>.from(subjectInAccount.map((x) => x.toJson())),
      };
}
