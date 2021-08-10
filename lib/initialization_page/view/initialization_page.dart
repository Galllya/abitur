import 'package:abitur/initialization_page/bloc/initialization_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'initialization.dart';

class InitializationPage extends StatefulWidget {
  const InitializationPage({Key? key}) : super(key: key);

  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  late InitializationBloc initializationBloc;

  @override
  void initState() {
    initializationBloc =
        InitializationBloc(sharedPreferences: context.read<SharedPreferences>())
          ..add(LoadingEvent());
    super.initState();
  }

  @override
  void dispose() {
    initializationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: initializationBloc,
      child: const Scaffold(
        body: Initialization(),
      ),
    );
  }
}
