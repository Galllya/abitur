import 'package:abitur/authorization_page/bloc/authorization_bloc.dart';
import 'package:abitur/data/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationtListState createState() => _AuthorizationtListState();
}

class _AuthorizationtListState extends State<Authorization> {
  @override
  void initState() {
    var account = context.read<AccountRepository>();
    print(account.loadAccount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (BuildContext context, AuthorizationState state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(
              flex: 2,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Авторизация',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                TextField(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Логин",
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Код подтверждения",
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Забыли пароль?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0XFF909090),
                  ),
                ),
                // SizedBox(
                //   height: 183,
                // ),
              ],
            ),
            Spacer(
              flex: 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Войти',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Войти без регистрации',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFF909090),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
