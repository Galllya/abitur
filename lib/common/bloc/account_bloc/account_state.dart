part of 'account_bloc.dart';

@immutable
class AccountState {
  final bool isLoading;
  final AccountData? accountData;
  const AccountState({this.isLoading = false, this.accountData});
  AccountState copyWith({
    bool? isLoading,
    AccountData? accountData,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      accountData: accountData ?? this.accountData,
    );
  }
}
