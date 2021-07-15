import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/news.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:abitur/start_page/widgets/event_section_card.dart';
import 'package:abitur/start_page/widgets/news_section_card.dart';
import 'package:abitur/start_page/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  List<NewsArticle> news = [];
  List<EventArticle> event = [];
  bool haveConnection = true;
  bool loadingNews = false;
  bool loadingEvent = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadnews();
    loadevent();
  }

  loadnews() async {
    final String URL =
        'http://abiturient.paraweb.media/api/v1/News?page=1&size=3';
    try {
      var response = await Dio().get(URL);
      print(response);

      final pagination = Pagination.fromJson(response.data,
          (json) => NewsArticle.fromJson(json as Map<String, dynamic>));
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

  loadevent() async {
    final String URL =
        'http://abiturient.paraweb.media/api/v1/Events?page=1&forAbiturients=false&calendar=false&size=3';
    try {
      var response = await Dio().get(URL);
      print(response);
      final pagination = Pagination.fromJson(response.data,
          (json) => EventArticle.fromJson(json as Map<String, dynamic>));
      setState(() {
        event = pagination.elements;
        loadingEvent = true;
      });
    } catch (e) {
      setState(() {
        haveConnection = false;
        loadingEvent = true;
      });
      throw Exception('Ошибка загрузки событий');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Главная")),
      body: ListView(
        children: <Widget>[
          SectionHeader(title: 'Новости', buttonText: 'Все новости'),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: loadingNews
                ? haveConnection
                    ? Column(
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
          SectionHeader(buttonText: 'Все события', title: 'События'),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: loadingEvent
                ? haveConnection
                    ? event.isNotEmpty
                        ? Column(
                            children: List.generate(
                              event.length,
                              (index) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          index == event.length - 1 ? 0 : 8),
                                  child: EventSectionCard(
                                    eventViewModel: event.elementAt(index),
                                  )),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 51),
                            child: Text(
                              'В ближайшее время никаких событий не ожидается, но вы увидите их здесь, как только они появятся',
                              style: TextStyle(
                                  color: Color(0XFF909090), fontSize: 16),
                            ),
                          )
                    : Center(
                        child: Text(
                          'Ошибка при загрузке событий',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                : SizedBox(
                    height: 40,
                    width: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [CircularProgressIndicator()]),
                  ),
          ),
        ],
      ),
    );
  }
}
