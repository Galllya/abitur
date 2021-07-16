// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventArticle _$EventArticleFromJson(Map<String, dynamic> json) {
  return EventArticle(
    id: json['id'] as int,
    title: json['title'] as String,
    text: json['text'] as String?,
    picture: json['picture'] as String?,
    isFavorite: json['isFavorite'] as bool?,
    address: json['address'] as String?,
    dateFrom: json['dateFrom'] == null
        ? null
        : DateTime.parse(json['dateFrom'] as String),
    dateTo: json['dateTo'] == null
        ? null
        : DateTime.parse(json['dateTo'] as String),
    forAbiturients: json['forAbiturients'] as bool?,
    image: json['image'] as String?,
    isAvailable: json['isAvailable'] as bool?,
    isInCalendar: json['isInCalendar'] as bool?,
    locationX: json['locationX'] as int?,
    locationY: json['locationY'] as int?,
    points: json['points'] as int,
    timeFrom: json['timeFrom'] as String?,
    timeTo: json['timeTo'] as String?,
  );
}
