import 'package:abitur/common/widgets/event_section_card.dart';
import 'package:abitur/data/news_repository.dart';
import 'package:abitur/domain/event.dart';
import 'package:abitur/domain/pagination.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EventLate extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<EventLate> {
  final _scrollController = ScrollController();
  final dio = Dio();

  int currentPage = 1;
  Pagination<EventArticle>? eventPagination;

  bool haveConnection = true;
  bool loadingEvent = false;

  @override
  void initState() {
    super.initState();

    loadEvent(currentPage);

    _scrollController.addListener(_onScroll);
  }

  void loadEvent(int page) async {
    if (eventPagination != null) {
      if (eventPagination!.elements.length == eventPagination!.totalCount) {
        return;
      }
    }
    setState(() {
      loadingEvent = true;
    });
    final String url =
        'http://abiturient.paraweb.media/api/v1/Events?page=1&forAbiturients=false&calendar=false$page&size=10';
    try {
      var response = await dio.get(url);

      final pagination = Pagination.fromJson(response.data,
          (json) => EventArticle.fromJson(json as Map<String, dynamic>));
      setState(() {
        currentPage = page;
        eventPagination = Pagination<EventArticle>(
          [
            if (eventPagination != null) ...eventPagination!.elements,
            ...pagination.elements,
          ],
          pagination.totalCount,
        );
        loadingEvent = false;
      });
    } catch (e) {
      setState(() {
        loadingEvent = false;
        haveConnection = false;
      });
      throw Exception('Ошибка загрузки событий');
    }
  }

  void _onScroll() {
    if (_isBottom && !loadingEvent) {
      loadEvent(currentPage + 1);
    }
  }

  /// проверяем на достижения нижней позиции скролла
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Мероприятия"),
          centerTitle: true,
        ),
        body: haveConnection
            ? eventPagination != null
                ? ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (BuildContext context, int index) {
                      /// выводим индикатор загрузки, если индекс выходит за длину массива
                      if (index >= eventPagination!.elements.length)
                        return const CircularProgressIndicator();

                      final element = EventSectionCard(
                        eventViewModel:
                            eventPagination!.elements.elementAt(index),
                      );
                      return element;
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: eventPagination!.totalCount >
                            eventPagination!.elements.length
                        ? eventPagination!.elements.length + 1
                        : eventPagination!.elements.length,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [CircularProgressIndicator()])
            : Center(
                child: Text(
                  'Ошибка при загрузке событий',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ));
  }
}
