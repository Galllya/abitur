import 'package:abitur/authorization_page/bloc/authorization_bloc.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/start_page/view/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationtListState createState() => _AuthorizationtListState();
}

class _AuthorizationtListState extends State<Authorization> {
  final String loginText = 'admin@mail.ru';
  final String passwordText = 'P_assword1';

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // var account = context.read<AccountRepository>();
    // print(account.loadAccount());
    loginController.text = loginText;
    passwordController.text = passwordText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (BuildContext context, AuthorizationState state) {
        if (state.textError.isNotEmpty)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.textError.join('\n')),
            ),
          );
        if (state.successfulAuthorization)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StartPage()));
        context.read<AccountBloc>().add(LoadingProfileData());
      },
      child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
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
                    controller: loginController,
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
                    controller: passwordController,
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
                            onPressed: state.formIsSent
                                ? null
                                : () {
                                    String login = loginController.text;
                                    String password = passwordController.text;
                                    context.read<AuthorizationBloc>().add(
                                        LoginStarted(
                                            login: login, password: password));
                                  },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: state.formIsSent
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Войти',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartPage()));
                      },
                      child: Text(
                        'Войти без регистрации',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0XFF909090),
                        ),
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
      }),
    );
  }
}
