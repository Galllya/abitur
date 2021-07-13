import 'package:abitur/models/event_model.dart';
import 'package:abitur/models/news_model.dart';
import 'package:abitur/models/pagination_model.dart';
import 'package:abitur/style/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class OneEvent extends StatefulWidget {
  final EventViewModel _eventViewModel;

  const OneEvent({Key? key, required EventViewModel eventViewModel})
      : _eventViewModel = eventViewModel;

  @override
  _OneEventState createState() => _OneEventState();
}

class _OneEventState extends State<OneEvent> {
  final dio = Dio();
  EventViewModel? event;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadnews();
  }

  loadnews() async {
    final String URL =
        'http://abiturient.paraweb.media/api/v1/Events/${widget._eventViewModel.id}';
    try {
      var response = await Dio().get(URL);
      print(response);
      final model = EventViewModel.fromJson(response.data);
      setState(() {
        event = model;
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget._eventViewModel.picture);

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Новость')),
        body: ListView(
          children: <Widget>[
            if (widget._eventViewModel.picture != null)
              Row(
                children: [
                  Expanded(
                    child: Image.network('${widget._eventViewModel.picture}',
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
                              .format(widget._eventViewModel.dateFrom!) +
                          ' - ' +
                          DateFormat.yMd('ru_RU')
                              .format(widget._eventViewModel.dateTo!),
                      style: TextStyle(fontSize: 16, color: Color(0XFF909090)),
                    ),
                  ),
                  if (event != null)
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: primaryTheme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Награда за участие',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  event!.points.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
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
                    widget._eventViewModel.title,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  if ((event != null) && (event!.text!.isNotEmpty))
                    Html(
                      data: """${event!.text}""",
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
