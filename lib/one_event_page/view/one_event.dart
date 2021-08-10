import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/one_event_page/bloc/one_event_bloc.dart';
import 'package:abitur/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class OneEvent extends StatefulWidget {
  const OneEvent({Key? key}) : super(key: key);

  @override
  _OneEventListState createState() => _OneEventListState();
}

class _OneEventListState extends State<OneEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OneEventBloc, OneEventState>(
      builder: (BuildContext context, OneEventState state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else {
          if (state.oneEvent != null) {
            return BlocBuilder<AccountBloc, AccountState>(
              builder: (BuildContext context, AccountState accountState) {
                return ListView(
                  children: <Widget>[
                    if (state.oneEvent!.picture != null)
                      Row(
                        children: [
                          Expanded(
                            child: Image.network(
                                state.oneEvent!.picture.toString(),
                                errorBuilder: (context, error, stackTrace) {
                              return const SizedBox();
                            }, loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const CircularProgressIndicator();
                            }),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (accountState.isLoading)
                      state.oneEvent!.isFavorite == true
                          ? IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                context
                                    .read<OneEventBloc>()
                                    .add(ChangedFavorites());
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                context
                                    .read<OneEventBloc>()
                                    .add(ChangedFavorites());
                              },
                            ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 16),
                            child: Text(
                              DateFormat.yMd('ru_RU')
                                      .format(state.oneEvent!.dateFrom!) +
                                  ' - ' +
                                  DateFormat.yMd('ru_RU')
                                      .format(state.oneEvent!.dateTo!),
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF909090)),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: primaryTheme.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Награда за участие',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        state.oneEvent!.points.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SvgPicture.asset(
                                        'assets/icons/icon_gift.svg',
                                        height: 20,
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text(
                            state.oneEvent!.title,
                            style: const TextStyle(
                                fontSize: 32,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          if ((state.oneEvent != null) &&
                              (state.oneEvent!.text!.isNotEmpty))
                            Html(
                              data: state.oneEvent!.text,
                            )
                          else
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Ошибка при загрузке события',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          }
        }
      },
    );
  }
}
