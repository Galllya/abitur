import 'package:abitur/authorization_page/view/authorization_page.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/favorites_page/view/favorites_page.dart';
import 'package:abitur/profile_page/view/profile_page.dart';
import 'package:abitur/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../start_page.dart';

class Draver extends StatelessWidget {
  const Draver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          BlocBuilder<AccountBloc, AccountState>(
              builder: (BuildContext context, AccountState state) {
            if (state.isLoading)
              return DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: primaryTheme.primaryColor),
                  accountName: Text(state.accountData!.firstName),
                  accountEmail: Text(state.accountData!.email),
                ),
              );
            else {
              return DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: primaryTheme.primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Вы не вошли/зарегистрировались!',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthorizationPage()));
                      },
                      child: Text(
                        'ВОЙТИ',
                        style: TextStyle(
                          color: primaryTheme.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text(
                        'ЗАРЕГИСТРИРОВАТЬСЯ',
                        style: TextStyle(
                          color: primaryTheme.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
          ListTile(
              title: Text("Главная"),
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
            },
          ),
          ListTile(
            title: Text("Избранное"),
            leading: Icon(Icons.favorite),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()));
            },
          )
        ],
      ),
    );
  }
}
