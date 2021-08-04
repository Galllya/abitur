import 'package:abitur/add_EGE_points_page/bloc/add_ege_points_bloc.dart';
import 'package:abitur/add_EGE_points_page/view/add_EGE_points.dart';
import 'package:abitur/data/account_repository.dart';
import 'package:abitur/data/subjects_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEgepointsPage extends StatefulWidget {
  const AddEgepointsPage({Key? key}) : super(key: key);

  @override
  _AddEgepointsPageState createState() => _AddEgepointsPageState();
}

class _AddEgepointsPageState extends State<AddEgepointsPage> {
  late AddEgePointsBloc addEgePointsBloc;

  @override
  void initState() {
    super.initState();
    final account = context.read<AccountRepository>();
    addEgePointsBloc = AddEgePointsBloc(
        accountRepository: account,
        subjectsRepository: context.read<SubjectsRepository>())
      ..add(AddEgePointsLoaded());
  }

  @override
  void dispose() {
    addEgePointsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: addEgePointsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Добавление баллов ЕГЭ'),
          centerTitle: true,
        ),
        body: AddEgePoints(),
      ),
    );
  }
}
