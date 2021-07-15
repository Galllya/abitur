import 'package:abitur/domain/news.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class OneNews extends StatefulWidget {
  final NewsArticle _newsViewModel;

  const OneNews({Key? key, required NewsArticle newsViewModel})
      : _newsViewModel = newsViewModel,
        super(key: key);

  @override
  _OneNewsState createState() => _OneNewsState();
}

class _OneNewsState extends State<OneNews> {
  final dio = Dio();
  NewsArticle? news;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadnews();
  }

  loadnews() async {
    final String URL =
        'http://abiturient.paraweb.media/api/v1/News/${widget._newsViewModel.id}';
    try {
      var response = await Dio().get(URL);
      print(response);
      final model = NewsArticle.fromJson(response.data);
      setState(() {
        news = model;
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget._newsViewModel.picture);

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Новость')),
        body: ListView(
          children: <Widget>[
            if (widget._newsViewModel.picture != null)
              Row(
                children: [
                  Expanded(
                    child: Image.network('${widget._newsViewModel.picture}',
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
                      DateFormat.yMd('ru_RU')
                          .format(widget._newsViewModel.date),
                      style: TextStyle(fontSize: 16, color: Color(0XFF909090)),
                    ),
                  ),
                  Text(
                    widget._newsViewModel.title,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  if ((news != null) && (news!.text!.isNotEmpty))
                    Html(
                      data: """${news!.text}""",
                    )
                  else
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [CircularProgressIndicator()]),
                ],
              ),
            ),
          ],
        ));
  }
}
