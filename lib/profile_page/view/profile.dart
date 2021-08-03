import 'package:abitur/add_EGE_points_page/view/add_EGE_points_page.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/profile_page/view/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    /// В этом месте не надо обращаться напрямую к состоянию блока, для использования состояния есть
    /// параметр в функции отрисовки - state, оно будет динамически изменяться при получении новых состояний
    // final account = context.read<AccountBloc>().state.accountData;
    /// И тут у тебя нет пока что завязки на ProfileBloc,так что можно испольовать напрямую AccountBloc
    final account = context.read<AccountBloc>().state.accountData;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  account!.firstName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  account.lastName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                if (account.surName != null)
                  Text(
                    account.surName.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  height: 10,
                ),
                Separator(
                  label: 'Email',
                  value: account.email,
                ),
                Separator(
                  label: 'Номер телефона',
                  value: account.phoneNumber,
                ),
                if (account.birthday != null)
                  Separator(
                    label: 'День рождения',
                    value: DateFormat.yMd('ru_RU').format(account.birthday),
                  ),
                if (account.country != null)
                  Separator(
                    label: ' Страна',
                    value: account.country.toString(),
                  ),
                if (account.region != null)
                  Separator(
                    label: 'Регион',
                    value: account.region.toString(),
                  ),
                Separator(
                  label: 'Город',
                  value: account.city,
                ),
                Separator(
                  label: 'Баллы ЕГЭ',
                  value: account.egePoints.toString(),
                ),
                Separator(
                  label: 'Баллы в приложении',
                  value: account.points.toString(),
                ),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEgepointsPage()));
                },
                child: Text(
                  'Добавить баллы ЕГЭ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}
