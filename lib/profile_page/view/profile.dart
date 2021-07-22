import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/profile_page/bloc/profile_bloc.dart';
import 'package:abitur/profile_page/view/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
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
    final account = context.read<AccountBloc>().state.accountData;
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
              littleText: 'Email',
              bigText: account.email,
            ),
            Separator(
              littleText: 'Номер телефона',
              bigText: account.phoneNumber,
            ),
            if (account.birthday != null)
              Separator(
                littleText: 'День рождения',
                bigText: DateFormat.yMd('ru_RU').format(account.birthday),
              ),
            if (account.country != null)
              Separator(
                littleText: ' Страна',
                bigText: account.country.toString(),
              ),
            if (account.region != null)
              Separator(
                littleText: 'Регион',
                bigText: account.region.toString(),
              ),
            Separator(
              littleText: 'Город',
              bigText: account.city,
            ),
            Separator(
              littleText: 'Баллы ЕГЭ',
              bigText: account.egePoints.toString(),
            ),
            Separator(
              littleText: 'Баллы в приложении',
              bigText: account.points.toString(),
            ),
          ],
        ),
      );
    });
    ;
  }
}
