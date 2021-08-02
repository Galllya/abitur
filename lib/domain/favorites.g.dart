// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesDate _$FavoritesDateFromJson(Map<String, dynamic> json) {
  return FavoritesDate(
    id: json['id'] as int,
    title: json['title'] as String,
    points: json['points'] as int,
    dateTo: DateTime.parse(json['dateTo'] as String),
    dateFrom: DateTime.parse(json['dateFrom'] as String),
    picture: json['picture'] as String,
    timeTo: json['timeTo'] as String,
    timeFrom: json['timeFrom'] as String,
    category: json['category'] as String,
    costPoints: json['costPoints'] as int,
    costRubles: json['costRubles'] as int,
  );
}
