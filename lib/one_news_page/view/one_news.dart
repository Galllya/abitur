import 'package:abitur/common/bloc/account_bloc/account_bloc.dart';
import 'package:abitur/one_news_page/bloc/one_news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class OneNews extends StatefulWidget {
  const OneNews({Key? key}) : super(key: key);

  @override
  _OneNewsListState createState() => _OneNewsListState();
}

class _OneNewsListState extends State<OneNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OneNewsBloc, OneNewsState>(
      builder: (BuildContext context, OneNewsState state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else {
          if (state.oneNews != null) {
            return BlocBuilder<AccountBloc, AccountState>(
              builder: (BuildContext context, AccountState accountState) {
                return ListView(
                  children: <Widget>[
                    if (state.oneNews!.picture != null)
                      Row(
                        children: [
                          Expanded(
                            child:
                                Image.network(state.oneNews!.picture.toString(),
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
                      state.oneNews!.isFavorite
                          ? IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                context
                                    .read<OneNewsBloc>()
                                    .add(ChangedFavorites());
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                context
                                    .read<OneNewsBloc>()
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
                                  .format(state.oneNews!.date),
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF909090)),
                            ),
                          ),
                          Text(
                            state.oneNews!.title,
                            style: const TextStyle(
                                fontSize: 32,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          if ((state.oneNews != null) &&
                              (state.oneNews!.text!.isNotEmpty))
                            Html(
                              data: state.oneNews!.text,
                            )
                          else
                            const CircularProgressIndicator(),
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
                'Ошибка при загрузке новости',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          }
        }
      },
    );
  }
}
