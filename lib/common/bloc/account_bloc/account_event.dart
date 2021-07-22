part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class LoadingProfileData extends AccountEvent {}

class LogOutOfProfile extends AccountEvent {}
