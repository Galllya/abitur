import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/data/subjects_repository.dart';
import 'package:abitur/profile_page/bloc/profile_bloc.dart';
import 'package:abitur/profile_page/view/profile.dart';
import 'package:abitur/start_page/view/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfiePageState createState() => _ProfiePageState();
}

class _ProfiePageState extends State<ProfilePage> {
  late ProfileBloc profileBloc;
  @override
  void initState() {
    profileBloc =
        ProfileBloc(subjectsRepository: context.read<SubjectsRepository>())
          ..add(LoadSubjects());
    super.initState();
  }

  @override
  void dispose() {
    profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Профиль'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                print(context.read<AccountBloc>().state.accountData);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StartPage()));
                context.read<AccountBloc>().add(LogOutOfProfile());
                print(context.read<AccountBloc>().state.accountData);
              },
            ),
          ],
        ),
        body: Profile(),
      ),
    );
  }
}
