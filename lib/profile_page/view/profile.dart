import 'package:abitur/add_EGE_points_page/view/add_EGE_points_page.dart';
import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/profile_page/bloc/profile_bloc.dart';
import 'package:abitur/profile_page/view/widgets/separator.dart';
import 'package:abitur/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        final account = state.accountData;
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (BuildContext context, ProfileState profileState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          account!.firstName,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          account.lastName,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        if (account.surName != null)
                          Text(
                            account.surName.toString(),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        const SizedBox(
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
                        Separator(
                          label: 'День рождения',
                          value:
                              DateFormat.yMd('ru_RU').format(account.birthday),
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
                        // Separator(
                        //   label: 'Баллы ЕГЭ',
                        //   value: account.egePoints.toString(),
                        // ),
                        Separator(
                          label: 'Баллы в приложении',
                          value: account.points.toString(),
                        ),
                        const Text(
                          'Результаты ЕГЭ',
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        if (profileState.subjects.isNotEmpty)
                          ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              indent: 1,
                              height: 1,
                              color: Colors.black,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: account.subjectInAccount.length,
                            itemBuilder: (context,
                                    index) => //if (profileState.subjects.isNotEmpty)
                                Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      profileState.subjects
                                          .elementAt(account.subjectInAccount
                                              .elementAt(index)
                                              .id)
                                          .title,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      account.subjectInAccount
                                          .elementAt(index)
                                          .value
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryTheme.primaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.14),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: const [
                                      Text(
                                        'Ваш суммарный балл:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Результат без учёта индивидуальных достижений',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF909090)),
                                      )
                                    ],
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/image/big_figure_in_provile.svg',
                                        height: 124,
                                        width: 98),
                                    SvgPicture.asset(
                                        'assets/image/little_figure_in_profile.svg',
                                        height: 55.69,
                                        width: 45.14),
                                    Text(
                                      account.egePoints.toString(),
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: primaryTheme.primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => const AddEgepointsPage(),
                            ),
                          )
                              .then((_) {
                            setState(() {});
                          });
                        },
                        child: const Text(
                          'Добавить баллы ЕГЭ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
