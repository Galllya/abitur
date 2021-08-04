// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountData _$AccountDataFromJson(Map<String, dynamic> json) {
  return AccountData(
    id: json['id'] as int,
    points: json['points'] as int,
    birthday: DateTime.parse(json['birthday'] as String),
    city: json['city'] as String,
    country: json['country'] as String?,
    egePoints: json['egePoints'] as int,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    region: json['region'] as String?,
    surName: json['surName'] as String?,
    subjectInAccount: (json['subjectInAccount'] as List<dynamic>)
        .map((e) => SubjectInAccount.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
