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
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return _$AccountDataFromJson(json);
  }
}
