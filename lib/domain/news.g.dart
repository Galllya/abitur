// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticle _$NewsArticleFromJson(Map<String, dynamic> json) {
  return NewsArticle(
    id: json['id'] as int,
    title: json['title'] as String,
    date: DateTime.parse(json['date'] as String),
    isFavorite: json['isFavorite'] as bool,
    picture: json['picture'] as String?,
    text: json['text'] as String?,
  );
}
