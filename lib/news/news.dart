import 'package:abitur/models/news_model.dart';
import 'package:abitur/models/pagination_model.dart';
import 'package:abitur/start_page/widgets/news_section_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<News> {
  final dio = Dio();
  List<NewsViewModel> news = [];
  bool haveConnection = true;
  bool loadingNews = false;
  bool loadingEvent = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadnews();
  }

  loadnews() async {
    final String URL =
        'http://abiturient.paraweb.media/api/v1/News?page=1&size=100';
    try {
      var response = await Dio().get(URL);

      final pagination = PaginationModel.fromJson(response.data,
          (json) => NewsViewModel.fromJson(json as Map<String, dynamic>));
      setState(() {
        news = pagination.elements;
        loadingNews = true;
      });
    } catch (e) {
      haveConnection = false;
      loadingNews = true;
      throw Exception('Ошибка загрузки новостей');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Новости"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 16),
        child: loadingNews
            ? haveConnection
                ? ListView(
                    children: List.generate(
                      news.length,
                      (index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: index == news.length - 1 ? 0 : 8),
                          child: NewsSectionCard(
                            newsViewModel: news.elementAt(index),
                          )),
                    ),
                  )
                : Center(
                    child: Text(
                      'Ошибка при загрузке новостей',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [CircularProgressIndicator()]),
      ),
    );
  }
}
