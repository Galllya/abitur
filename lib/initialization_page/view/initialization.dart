import 'package:abitur/authorization_page/view/authorization_page.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/initialization_page/bloc/initialization_bloc.dart';
import 'package:abitur/start_page/view/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Initialization extends StatefulWidget {
  const Initialization({Key? key}) : super(key: key);

  @override
  _InitializationState createState() => _InitializationState();
}

class _InitializationState extends State<Initialization> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InitializationBloc, InitializationState>(
      listener: (BuildContext context, InitializationState state) {
        if (state.isLogged!) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const StartPage()));
          context.read<AccountBloc>().add(LoadingProfileData());
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AuthorizationPage()));
        }
      },
      child: BlocBuilder<InitializationBloc, InitializationState>(
          builder: (BuildContext context, InitializationState state) {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
