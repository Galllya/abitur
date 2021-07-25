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
      if (state.isLoading)
        return Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [CircularProgressIndicator()]),
        );
      else {
        if (state.oneNews != null)
          return ListView(
            children: <Widget>[
              if (state.oneNews!.picture != null)
                Row(
                  children: [
                    Expanded(
                      child: Image.network('${state.oneNews!.picture}',
                          errorBuilder: (context, error, stackTrace) {
                        return SizedBox();
                      }, loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [CircularProgressIndicator()]);
                      }),
                    ),
                  ],
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        DateFormat.yMd('ru_RU').format(state.oneNews!.date),
                        style:
                            TextStyle(fontSize: 16, color: Color(0XFF909090)),
                      ),
                    ),

                    /// так как добавление в избранное - функционал авторизованного пользователя, надо скрывать кнопку, если пользователь не авторизован
                    /// или можно показать модалку с предложением авторизоваться
                    state.oneNews!.isFavorite
                        ? IconButton(
                            icon: const Icon(Icons.favorite),
                            onPressed: () {
                              context.read<OneNewsBloc>()
                                ..add(ChangedFavorites());
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                    Text(
                      state.oneNews!.title,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    if ((state.oneNews != null) &&
                        (state.oneNews!.text!.isNotEmpty))

                      /// тут можно без интерполяции передавать текст напрямую
                      Html(
                        data: """${state.oneNews!.text}""",
                      )
                    else
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [CircularProgressIndicator()]),
                  ],
                ),
              ),
            ],
          );
        else
          return Center(
            child: Text(
              'Ошибка при загрузке новости',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
      }
    });
  }
}
