part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}

class LoginStarted extends AuthorizationEvent {
  // final String login;
  // final String password;
  final Map<String, dynamic> logAndPas;
  LoginStarted(
      {/*required this.login, required this.password*/ required this.logAndPas});
}
