import 'package:json_annotation/json_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';
part 'transfer_login_and_password.g.dart';

@JsonSerializable()
class LoginPasswordModel {
  final String email;
  final String password;

  LoginPasswordModel({required this.email, required this.password});

  // factory LoginPasswordModel.toJson(Map<String, dynamic> json) =>
  //     _$LoginPasswordModelToJson(json);

  Map<String, dynamic> toJson() => _$LoginPasswordModelToJson(this);

  @override
  String toString() => toJson().toString();

  factory LoginPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$LoginPasswordModelFromJson(json);
}
