// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_login_and_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPasswordModel _$LoginPasswordModelFromJson(Map<String, dynamic> json) {
  return LoginPasswordModel(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginPasswordModelToJson(LoginPasswordModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
