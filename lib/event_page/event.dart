import 'package:abitur/models/event_model.dart';
import 'package:abitur/models/news_model.dart';
import 'package:abitur/models/pagination_model.dart';
import 'package:abitur/start_page/widgets/event_section_card.dart';
import 'package:abitur/start_page/widgets/news_section_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Event> {
  final _scrollController = ScrollController();
  final dio = Dio();
  List<EventViewModel> event = [];
  bool haveConnection = true;
  bool loadingEvent = false;

  int currentPage = 1;
  PaginationModel<EventViewModel>? eventPagination;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEvent(currentPage);
    _scrollController.addListener(_onScroll);
  }

  loadEvent(int page) async {
    if (eventPagination != null) {
      if (eventPagination!.elements.length == eventPagination!.totalCount) {
        return;
      }
    }
    setState(() {
      loadingEvent = true;
    });
    final String URL =
        'http://abiturient.paraweb.media/api/v1/Events?page=1&forAbiturients=false&calendar=false$page&size=10';
    try {
      var response = await Dio().get(URL);
      print(response);
      final pagination = PaginationModel.fromJson(response.data,
          (json) => EventViewModel.fromJson(json as Map<String, dynamic>));
      setState(() {
        event = pagination.elements;
        loadingEvent = true;
      });

      setState(() {
        currentPage = page;
        eventPagination = PaginationModel<EventViewModel>(
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
        haveConnection = false;
        loadingEvent = true;
      });
      throw Exception('Ошибка загрузки событий');
    }
  }

  void _onScroll() {
    // if (newsPagination != null &&
    //     newsPagination!.totalCount != newsPagination!.elements.length &&
    //     loadingNews)
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
          title: Text("Мероприятния"),
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
