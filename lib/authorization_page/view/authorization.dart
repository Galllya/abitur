import 'package:abitur/authorization_page/bloc/authorization_bloc.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/start_page/view/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationtListState createState() => _AuthorizationtListState();
}

class _AuthorizationtListState extends State<Authorization> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final form = FormGroup({
    'email': FormControl<String>(
      value: 'admin@mail.ru',
      validators: [
        Validators.minLength(0),
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl<String>(value: 'P_assword1', validators: [
      Validators.required,
      Validators.minLength(0),
    ]),
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (BuildContext context, AuthorizationState state) {
        if (state.textError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.textError.join('\n')),
            ),
          );
        }
        if (state.successfulAuthorization) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const StartPage()));
        }
        context.read<AccountBloc>().add(LoadingProfileData());
      },
      child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (BuildContext context, AuthorizationState state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Column(
                  children: [
                    const Align(
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
                    const SizedBox(
                      height: 42,
                    ),
                    ReactiveForm(
                      formGroup: form,
                      child: Column(
                        children: <Widget>[
                          ReactiveTextField(
                            formControlName: 'email',
                            decoration: const InputDecoration(
                              labelText: 'Логин',
                            ),
                            validationMessages: (control) => {
                              'required': 'Не оставляйте поле пустым!',
                              'email': 'Некорректный формат email'
                            },
                          ),
                          ReactiveTextField(
                            formControlName: 'password',
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: const InputDecoration(
                              labelText: 'Код подтверждения',
                            ),
                            validationMessages: (control) => {
                              'required': 'Не оставляйте поле пустым!',
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                      child: const Text(
                        'Забыли пароль?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF909090),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ReactiveForm(
                              formGroup: form,
                              child: ReactiveFormConsumer(
                                  builder: (context, form, child) {
                                return TextButton(
                                  onPressed: form.valid == true
                                      ? state.formIsSent
                                          ? null
                                          : () {
                                              context
                                                  .read<AuthorizationBloc>()
                                                  .add(LoginStarted(
                                                      logAndPas: form.value));
                                            }
                                      : null,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: state.formIsSent
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            'Войти',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        style: Theme.of(context)
                            .textButtonTheme
                            .style!
                            .copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StartPage()));
                        },
                        child: const Text(
                          'Войти без регистрации',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF909090),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
