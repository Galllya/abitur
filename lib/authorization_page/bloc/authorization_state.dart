part of 'authorization_bloc.dart';

@immutable
class AuthorizationState {
  final bool formIsSent;
  final String textError;
  final bool successfulAuthorization;
  const AuthorizationState(
      {this.formIsSent = false,
      this.successfulAuthorization = false,
      this.textError = ""});
  AuthorizationState copyWith({
    bool? formIsSent,
    String? textError,
    bool? successfulAuthorization,
  }) {
    return AuthorizationState(
      formIsSent: formIsSent ?? this.formIsSent,
      textError: textError ?? this.textError,
      successfulAuthorization:
          successfulAuthorization ?? this.successfulAuthorization,
    );
  }
}
