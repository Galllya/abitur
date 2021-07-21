import 'package:abitur/authorization_page/bloc/authorization_bloc.dart';
import 'package:abitur/authorization_page/view/authorization.dart';
import 'package:abitur/data/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationListPageState createState() => _AuthorizationListPageState();
}

class _AuthorizationListPageState extends State<AuthorizationPage> {
  late AuthorizationBloc authorizationBloc;

  @override
  void initState() {
    super.initState();
    authorizationBloc = AuthorizationBloc(
      accountRepository: context.read<AccountRepository>(),
    );
  }

  @override
  void dispose() {
    authorizationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authorizationBloc,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Authorization(),
        ),
      ),
    );
  }
}
