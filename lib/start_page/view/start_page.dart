import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/data/event_repository.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/initialization_page/view/initialization_page.dart';
import 'package:abitur/profile_page/view/profile.dart';
import 'package:abitur/profile_page/view/profile_page.dart';
import 'package:abitur/start_page/bloc/start_bloc.dart';
import 'package:abitur/start_page/view/start.dart';
import 'package:abitur/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartListPageState createState() => _StartListPageState();
}

class _StartListPageState extends State<StartPage> {
  late StartBloc startBloc;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    startBloc = StartBloc(
        newsRepository: context.read<NewsRepository>(),
        eventRepository: context.read<EventRepository>())
      ..add(StartLoaded());
  }

  @override
  void dispose() {
    startBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountBloc>().state;
    return BlocProvider.value(
      value: startBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Главная'),
          centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.comment),
          //   color: Theme.of(context).iconTheme.color,
          //   onPressed: () {
          //     // Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) => InitializationPage()));
          //     context.read<AccountBloc>().add(LogOutOfProfile());
          //   },
          // ),
        ),
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: primaryTheme.primaryColor),
                  accountName: Text('имя пользовалеля'),
                  accountEmail: Text("емейл пользователя"),
                ),
              ),
              ListTile(
                  title: new Text("Главная"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => StartPage()));
                  }),
              BlocBuilder<AccountBloc, AccountState>(
                  builder: (BuildContext context, AccountState state) {
                if (state.isLoading)
                  return ListTile(
                      title: new Text("Профиль"),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      });
                else
                  return SizedBox();
              }),
            ],
          ),
        ),
        body: Start(),
      ),
    );
  }
}
